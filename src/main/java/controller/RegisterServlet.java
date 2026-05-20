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
 * RegisterServlet — Phase 6 hardened.
 * GET  → show register.jsp
 * POST → validate (name/email/phone/password) → save → redirect to login
 *
 * Changes from Phase 6:
 *  • Uses ValidationUtil.isValidName() for full-name check
 *  • Uses ValidationUtil.isStrongPasswordLenient() (keeps existing rule)
 *    but displays a clearer hint message
 *  • Escapes re-displayed values via ValidationUtil.sanitize()
 *  • Wraps everything in top-level try/catch → /error/500.jsp (no stack trace)
 *  • Adds address-length guard on avatar file type/size
 */
@WebServlet("/register")
@MultipartConfig(maxFileSize = 2097152) // 2 MB
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (SessionUtil.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            return;
        }
        req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String fullName = ValidationUtil.sanitize(req.getParameter("fullName"));
        String email    = ValidationUtil.sanitize(req.getParameter("email")).toLowerCase();
        String phone    = ValidationUtil.sanitize(req.getParameter("phone"));
        String password = req.getParameter("password");           // never sanitize raw passwords
        String confirm  = req.getParameter("confirmPassword");

        try {
            // ── Field-by-field validation with specific messages ──────────
            if (!ValidationUtil.isValidName(fullName)) {
                setErrorAndForward(req, resp,
                        "Full name must be 2–80 characters (letters, spaces, hyphens).",
                        fullName, email, phone);
                return;
            }
            if (!ValidationUtil.isValidEmail(email)) {
                setErrorAndForward(req, resp,
                        "Please enter a valid email address (e.g. you@example.com).",
                        fullName, email, phone);
                return;
            }
            if (!ValidationUtil.isValidPhone(phone)) {
                setErrorAndForward(req, resp,
                        "Phone number must be exactly 10 digits (no spaces or dashes).",
                        fullName, email, phone);
                return;
            }
            if (ValidationUtil.isEmpty(password)) {
                setErrorAndForward(req, resp, "Password is required.", fullName, email, phone);
                return;
            }
            if (!ValidationUtil.isStrongPasswordLenient(password)) {
                setErrorAndForward(req, resp,
                        "Password must be at least 8 characters and include an uppercase letter and a number.",
                        fullName, email, phone);
                return;
            }
            if (!password.equals(confirm)) {
                setErrorAndForward(req, resp, "Passwords do not match. Please re-enter.", fullName, email, phone);
                return;
            }

            // ── Duplicate checks ──────────────────────────────────────────
            if (userDAO.emailExists(email)) {
                setErrorAndForward(req, resp,
                        "That email address is already registered. Try logging in or use a different email.",
                        fullName, email, phone);
                return;
            }
            if (userDAO.phoneExists(phone)) {
                setErrorAndForward(req, resp,
                        "That phone number is already registered. Please use a different number.",
                        fullName, email, phone);
                return;
            }

            // ── Avatar upload ─────────────────────────────────────────────
            String avatarFileName = "default.png";
            Part avatarPart = req.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                // Guard: only accept image types
                String contentType = avatarPart.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    setErrorAndForward(req, resp,
                            "Avatar must be an image file (JPG, PNG, GIF, etc.).",
                            fullName, email, phone);
                    return;
                }
                String uploadFolder = getServletContext().getRealPath("/assets/images/uploads/");
                avatarFileName = FileUploadUtil.saveFile(avatarPart, uploadFolder);
            }

            // ── Build & save user ─────────────────────────────────────────
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setRole("user");
            user.setStatus("pending");  // New users require admin approval
            user.setAvatar(avatarFileName);

            if (userDAO.insertUser(user)) {
                resp.sendRedirect(req.getContextPath() + "/login?registered=true");
            } else {
                setErrorAndForward(req, resp,
                        "Registration failed. Please try again.", fullName, email, phone);
            }

        } catch (IllegalArgumentException e) {
            // FileUploadUtil validation error (e.g. bad extension)
            setErrorAndForward(req, resp, e.getMessage(), fullName, email, phone);
        } catch (Exception e) {
            // Never expose stack trace to user
            e.printStackTrace();
            req.setAttribute("error", "An unexpected server error occurred. Please try again later.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    private void setErrorAndForward(HttpServletRequest req, HttpServletResponse resp,
                                    String msg, String fullName, String email, String phone)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.setAttribute("fullName", fullName);
        req.setAttribute("email",    email);
        req.setAttribute("phone",    phone);
        req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
    }
}
