package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.*;

import java.io.IOException;

/**
 * Handles user login - shows login form and processes authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final int MAX_EMAIL_LEN    = 254;
    private static final int MAX_PASSWORD_LEN = 128;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (SessionUtil.isLoggedIn(req)) {
            redirectByRole(req, resp);
            return;
        }

        String rememberedEmail = CookieUtil.getRememberMe(req);
        if (rememberedEmail != null) {
            req.setAttribute("rememberedEmail", rememberedEmail);
        }
        if ("true".equals(req.getParameter("registered"))) {
            req.setAttribute("success", "Registration successful! Your account is pending admin approval.");
        }
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email    = ValidationUtil.sanitize(req.getParameter("email")).toLowerCase();
        String password = req.getParameter("password");
        String remember = req.getParameter("rememberMe");

        // Check if email and password are provided
        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            forwardWithError(req, resp, "Email and password are required.", email);
            return;
        }

        // Validate email format
        if (!ValidationUtil.isValidEmail(email)) {
            forwardWithError(req, resp, "Please enter a valid email address.", email);
            return;
        }

        // Prevent very long inputs (security measure)
        if (email.length() > MAX_EMAIL_LEN || password.length() > MAX_PASSWORD_LEN) {
            forwardWithError(req, resp, "Invalid email or password.", "");
            return;
        }

        try {
            User user = userDAO.findByEmail(email);

            if (user == null || !PasswordUtil.verifyPassword(password, user.getPassword())) {
                // Don't reveal whether email exists
                forwardWithError(req, resp, "Invalid email or password.", email);
                return;
            }

            // Check if user account is approved
            if (!"approved".equalsIgnoreCase(user.getStatus())) {
                String statusMsg = getStatusMessage(user.getStatus());
                forwardWithError(req, resp, statusMsg, email);
                return;
            }

            // Login successful
            SessionUtil.setUser(req, user);

            if ("on".equals(remember)) {
                CookieUtil.setRememberMe(resp, user.getEmail());
            } else {
                CookieUtil.deleteRememberMe(resp);
            }

            redirectByRole(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "A server error occurred during login. Please try again.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp,
                                  String msg, String email)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.setAttribute("rememberedEmail", email);
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    private void redirectByRole(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String role = SessionUtil.getRole(req);
        if ("admin".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
        }
    }

    private String getStatusMessage(String status) {
        if ("pending".equalsIgnoreCase(status)) {
            return "Your account is pending approval. Please wait for admin approval.";
        } else if ("rejected".equalsIgnoreCase(status)) {
            return "Your account has been rejected. Please contact support.";
        }
        return "Your account is not active. Please contact support.";
    }
}
