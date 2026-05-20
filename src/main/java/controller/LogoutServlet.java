package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.CookieUtil;
import util.SessionUtil;

import java.io.IOException;

/**
 * LogoutServlet — destroys session and clears cookies, then redirects to login.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        SessionUtil.invalidate(req);         // destroy session
        CookieUtil.deleteRememberMe(resp);   // remove remember-me cookie
        resp.sendRedirect(req.getContextPath() + "/login?logout=true");
    }
}