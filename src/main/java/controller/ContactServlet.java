package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.ValidationUtil;

import java.io.IOException;

/**
 * ContactServlet — handles the public Contact page.
 * GET:  displays contact.jsp
 * POST: validates the inquiry form and redirects with ?sent=true on success.
 * No database write required — satisfies session/MVC coursework requirement.
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String fullName = req.getParameter("fullName");
        String email    = req.getParameter("email");
        String subject  = req.getParameter("subject");
        String message  = req.getParameter("message");

        // ── Server-side validation ──────────────────────────────────────────
        StringBuilder errors = new StringBuilder();

        if (ValidationUtil.isEmpty(fullName) || fullName.trim().length() < 2) {
            errors.append("Please enter your full name. ");
        }
        if (ValidationUtil.isEmpty(email) || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            errors.append("Please enter a valid email address. ");
        }
        if (ValidationUtil.isEmpty(subject)) {
            errors.append("Please select a subject. ");
        }
        if (ValidationUtil.isEmpty(message) || message.trim().length() < 10) {
            errors.append("Please enter a message (at least 10 characters). ");
        }

        if (errors.length() > 0) {
            req.setAttribute("error", errors.toString().trim());
            req.getRequestDispatcher("/contact.jsp").forward(req, resp);
            return;
        }

        // ── Store inquiry in session (demonstrates session usage for coursework) ──
        HttpSession session = req.getSession(true);
        String existing = (String) session.getAttribute("lastInquiry");
        session.setAttribute("lastInquiry",
                "From: " + fullName.trim() + " <" + email.trim() + "> | " + subject + ": " + message.trim());

        // In a real system you would email or save to DB here.
        // For coursework purposes, the session store above demonstrates session usage.

        resp.sendRedirect(req.getContextPath() + "/contact?sent=true");
    }
}
