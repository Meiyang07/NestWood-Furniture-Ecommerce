package controller;

import dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("stats",              dashboardDAO.getStats());
            req.setAttribute("recentOrders",       dashboardDAO.getRecentOrders());
            req.setAttribute("productsByCategory", dashboardDAO.getProductsByCategory());
            req.setAttribute("ordersByStatus",     dashboardDAO.getOrdersByStatus());
            req.setAttribute("monthlySales",       dashboardDAO.getMonthlySales());
            req.setAttribute("lowStockProducts",   dashboardDAO.getLowStockProducts());
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }
}