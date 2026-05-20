package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.User;
import service.OrderService;
import service.ProductService;
import util.SessionUtil;
import util.ValidationUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Handles order placement, history, cancellation, and admin order management
 */
@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(OrderServlet.class.getName());

    private final OrderService   orderService   = new OrderService();
    private final ProductService productService = new ProductService();

    // Check if user is logged in

    private User requireLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        User user = SessionUtil.getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
        return user;
    }

    // Check if user has admin role
    private boolean requireAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        User user = SessionUtil.getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        if (!"admin".equals(user.getRole())) {
            req.getRequestDispatcher("/error/unauthorized.jsp").forward(req, resp);
            return false;
        }
        return true;
    }

    // GET - handle order viewing, status updates, checkout, history, cancel

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            // Admin: view all orders
            if ("adminOrders".equals(action)) {
                if (!requireAdmin(req, resp)) return;
                // Load all orders for admin
                req.setAttribute("allOrders", orderService.getAllOrders());
                req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
                return;
            }

            // Admin: update order status
            if ("updateStatus".equals(action)) {
                if (!requireAdmin(req, resp)) return;
                String idStr  = req.getParameter("id");
                String status = req.getParameter("status");
                if (ValidationUtil.isEmpty(idStr) || ValidationUtil.isEmpty(status)) {
                    req.setAttribute("error", "Missing order ID or status.");
                    // Reload orders list
                    req.setAttribute("allOrders", orderService.getAllOrders());
                    req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
                    return;
                }
                try {
                    orderService.updateOrderStatus(Integer.parseInt(idStr.trim()), status);
                    resp.sendRedirect(req.getContextPath() + "/order?action=adminOrders&updated=true");
                } catch (IllegalArgumentException e) {
                    // Business rule violation
                    req.setAttribute("allOrders", orderService.getAllOrders());
                    req.setAttribute("error", e.getMessage());
                    req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
                } catch (SQLException e) {
                    throw new ServletException("Database error updating order status", e);
                }
                return;
            }

            // Checkout - guests redirect to login
            if ("checkout".equals(action)) {
                if (!SessionUtil.isLoggedIn(req)) {
                    resp.sendRedirect(req.getContextPath()
                            + "/login?msg=login_to_order&redirect=checkout&productId="
                            + req.getParameter("productId"));
                    return;
                }
                String pidStr = req.getParameter("productId");
                if (ValidationUtil.isEmpty(pidStr)) {
                    resp.sendRedirect(req.getContextPath() + "/browse");
                    return;
                }
                int productId = Integer.parseInt(pidStr.trim());
                // Load product for checkout page
                req.setAttribute("product", productService.getProductById(productId));
                req.getRequestDispatcher("/user/checkout.jsp").forward(req, resp);
                return;
            }

            // All actions below require login
            User user = requireLogin(req, resp);
            if (user == null) return;

            if ("history".equals(action)) {
                // Show user's order history
                req.setAttribute("orders", orderService.getOrdersByUser(user.getId()));
                req.getRequestDispatcher("/user/history.jsp").forward(req, resp);

            } else if ("cancel".equals(action)) {
                String idStr = req.getParameter("id");
                if (ValidationUtil.isEmpty(idStr)) {
                    resp.sendRedirect(req.getContextPath() + "/order?action=history");
                    return;
                }
                try {
                    orderService.cancelOrder(Integer.parseInt(idStr.trim()), user.getId());
                    resp.sendRedirect(req.getContextPath() + "/order?action=history&cancelled=true");
                } catch (IllegalArgumentException e) {
                    // Business rule violation
                    req.setAttribute("orders", orderService.getOrdersByUser(user.getId()));
                    req.setAttribute("error", e.getMessage());
                    req.getRequestDispatcher("/user/history.jsp").forward(req, resp);
                } catch (SQLException e) {
                    throw new ServletException("Database error cancelling order", e);
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid ID format.");
            req.getRequestDispatcher("/error/404.jsp").forward(req, resp);
        } catch (Exception e) {
            // Log error and show error page
            LOG.log(Level.SEVERE, "Unexpected error in OrderServlet.doGet", e);
            req.setAttribute("error", "A server error occurred. Please try again.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    // POST - place a new order

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        User user = requireLogin(req, resp);
        if (user == null) return;

        if ("admin".equals(user.getRole())) {
            req.getRequestDispatcher("/error/unauthorized.jsp").forward(req, resp);
            return;
        }

        String productIdStr = req.getParameter("productId");
        String quantityStr  = req.getParameter("quantity");
        String address      = ValidationUtil.sanitize(req.getParameter("address"));

        // Validate input before processing
        if (ValidationUtil.isEmpty(productIdStr)) {
            forwardCheckoutError(req, resp, "Product not specified. Please select a product.", null);
            return;
        }

        if (!ValidationUtil.isValidQuantity(quantityStr)) {
            // Get product for error context
            Product product = safeGetProduct(productIdStr);
            forwardCheckoutError(req, resp, "Quantity must be a whole number between 1 and 999.", product);
            return;
        }

        if (!ValidationUtil.isValidAddress(address)) {
            // Get product for error context
            Product product = safeGetProduct(productIdStr);
            forwardCheckoutError(req, resp, "Delivery address must be between 10 and 255 characters.", product);
            return;
        }

        // Process the order
        try {
            int productId = Integer.parseInt(productIdStr.trim());
            int quantity  = Integer.parseInt(quantityStr.trim());

            orderService.placeOrder(user.getId(), productId, quantity, address);
            resp.sendRedirect(req.getContextPath() + "/order?action=history&placed=true");

        } catch (IllegalArgumentException e) {
            // Business rule violation (out of stock, etc.)
            Product product = safeGetProduct(productIdStr);
            forwardCheckoutError(req, resp, e.getMessage(), product);

        } catch (SQLException e) {
            // Database error
            LOG.log(Level.SEVERE, "DB error placing order", e);
            req.setAttribute("error", "A server error occurred while placing your order.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);

        } catch (Exception e) {
            // Unexpected error
            LOG.log(Level.SEVERE, "Unexpected error placing order", e);
            req.setAttribute("error", "A server error occurred while placing your order.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    // Forward to checkout page with error message
    private void forwardCheckoutError(HttpServletRequest req, HttpServletResponse resp,
                                      String msg, Object product)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        if (product != null) req.setAttribute("product", product);
        req.getRequestDispatcher("/user/checkout.jsp").forward(req, resp);
    }

    // Safely get product by ID (returns null on error)
    private Product safeGetProduct(String productIdStr) {
        try {
            int pid = Integer.parseInt(productIdStr.trim());
            if (pid > 0) return productService.getProductById(pid);
        } catch (Exception ignored) {
            // Bad ID or database error - product context is optional
        }
        return null;
    }
}
