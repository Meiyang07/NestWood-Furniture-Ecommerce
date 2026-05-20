package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * WishlistServlet — session-based wishlist feature.
 * No database table required. Product IDs stored in HttpSession.
 * Works for both guests and logged-in users.
 *
 * Actions (GET):
 *   /wishlist                      → view wishlist page
 *   /wishlist?action=add&productId=X&from=browse  → add item, redirect back
 *   /wishlist?action=remove&productId=X           → remove item
 *   /wishlist?action=clear                        → clear all
 */
@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    // Session key for the wishlist list
    private static final String WISHLIST_KEY = "wishlist";

    /** Returns the wishlist from session, creating it if needed. */
    @SuppressWarnings("unchecked")
    private List<Integer> getWishlist(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        List<Integer> list = (List<Integer>) session.getAttribute(WISHLIST_KEY);
        if (list == null) {
            list = new ArrayList<>();
            session.setAttribute(WISHLIST_KEY, list);
        }
        return list;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                // ── Add product to wishlist ──────────────────────────────
                String pidStr = req.getParameter("productId");
                if (pidStr != null && !pidStr.trim().isEmpty()) {
                    int productId = Integer.parseInt(pidStr);
                    List<Integer> wishlist = getWishlist(req);
                    if (!wishlist.contains(productId)) {
                        wishlist.add(productId);
                    }
                }
                // Redirect back to where user came from
                String from = req.getParameter("from");
                if ("browse".equals(from)) {
                    resp.sendRedirect(req.getContextPath() + "/browse?added=true");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/wishlist?added=true");
                }
                return;
            }

            if ("remove".equals(action)) {
                // ── Remove product from wishlist ─────────────────────────
                String pidStr = req.getParameter("productId");
                if (pidStr != null && !pidStr.trim().isEmpty()) {
                    int productId = Integer.parseInt(pidStr);
                    getWishlist(req).remove(Integer.valueOf(productId));
                }
                resp.sendRedirect(req.getContextPath() + "/wishlist?removed=true");
                return;
            }

            if ("clear".equals(action)) {
                // ── Clear entire wishlist ────────────────────────────────
                req.getSession(true).removeAttribute(WISHLIST_KEY);
                resp.sendRedirect(req.getContextPath() + "/wishlist?cleared=true");
                return;
            }

            // ── Default: view wishlist page ──────────────────────────────
            List<Integer> wishlistIds = getWishlist(req);
            List<Product> wishlistProducts = new ArrayList<>();

            for (int id : wishlistIds) {
                try {
                    Product p = productDAO.findById(id);
                    if (p != null) {
                        wishlistProducts.add(p);
                    }
                } catch (Exception ignored) {
                    // Product may have been deleted — skip it silently
                }
            }

            req.setAttribute("wishlistProducts", wishlistProducts);
            req.setAttribute("wishlistCount", wishlistProducts.size());
            req.getRequestDispatcher("/wishlist.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/wishlist");
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }
}
