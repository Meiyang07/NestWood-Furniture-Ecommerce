package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.*;

import java.io.IOException;

/**
 * UserProfileServlet — view and update user profile.
 * GET  → show profile.jsp
 * POST → update profile or change password
 */
@WebServlet("/user/profile")
@MultipartConfig(maxFileSize = 2097152)
public class UserProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        User loggedUser = SessionUtil.getUser(req);

        try {
            if ("updateProfile".equals(action)) {
                String fullName = req.getParameter("fullName");
                String phone    = req.getParameter("phone");

                if (ValidationUtil.isEmpty(fullName) || !ValidationUtil.isValidPhone(phone)) {
                    req.setAttribute("error", "Invalid input. Check all fields.");
                    req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
                    return;
                }

                // Handle avatar upload
                String avatarFileName = loggedUser.getAvatar(); // keep old by default
                Part avatarPart = req.getPart("avatar");
                if (avatarPart != null && avatarPart.getSize() > 0) {
                    String uploadFolder = getServletContext().getRealPath("/assets/images/uploads/");
                    avatarFileName = FileUploadUtil.saveFile(avatarPart, uploadFolder);
                }

                loggedUser.setFullName(fullName.trim());
                loggedUser.setPhone(phone.trim());
                loggedUser.setAvatar(avatarFileName);

                userDAO.updateProfile(loggedUser);

                // Update session with new data
                SessionUtil.setUser(req, loggedUser);
                req.setAttribute("success", "Profile updated successfully.");

            } else if ("changePassword".equals(action)) {
                String current    = req.getParameter("currentPassword");
                String newPass    = req.getParameter("newPassword");
                String confirmNew = req.getParameter("confirmNew");

                if (!PasswordUtil.verifyPassword(current, loggedUser.getPassword())) {
                    req.setAttribute("error", "Current password is incorrect.");
                    req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
                    return;
                }
                if (!ValidationUtil.isStrongPassword(newPass)) {
                    req.setAttribute("error", "New password must be 8+ chars with uppercase and number.");
                    req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
                    return;
                }
                if (!newPass.equals(confirmNew)) {
                    req.setAttribute("error", "Passwords do not match.");
                    req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
                    return;
                }

                String hashed = PasswordUtil.hashPassword(newPass);
                userDAO.updatePassword(loggedUser.getId(), hashed);
                loggedUser.setPassword(hashed);
                SessionUtil.setUser(req, loggedUser);
                req.setAttribute("success", "Password changed successfully.");
            }

            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }
}