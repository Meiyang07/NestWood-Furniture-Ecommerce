package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Admin page to manage users - approve or reject registrations
 */
@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("users", userDAO.getAllUsers());
            req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            String userIdStr = req.getParameter("userId");

            if (userIdStr == null || userIdStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/users?error=invalid");
                return;
            }

            int userId = Integer.parseInt(userIdStr);

            if ("approve".equals(action)) {
                userDAO.updateStatus(userId, "approved");
                resp.sendRedirect(req.getContextPath() + "/admin/users?success=approved");
            } else if ("reject".equals(action)) {
                userDAO.updateStatus(userId, "rejected");
                resp.sendRedirect(req.getContextPath() + "/admin/users?success=rejected");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/users?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/users?error=failed");
        }
    }
}
