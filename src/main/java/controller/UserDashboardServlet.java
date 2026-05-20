package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.SessionUtil;

import java.io.IOException;

/**
 * User dashboard - shows featured products and recent orders
 */
@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final OrderDAO   orderDAO   = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Show featured products for everyone
            req.setAttribute("featuredProducts", productDAO.getActiveProducts());

            // Load orders only if user is logged in
            User user = SessionUtil.getUser(req);
            if (user != null) {
                req.setAttribute("myOrders", orderDAO.getOrdersByUser(user.getId()));
            }

            req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }
}