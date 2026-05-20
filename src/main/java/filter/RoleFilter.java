package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import util.SessionUtil;

import java.io.IOException;

/**
 * Makes sure admins can't access user pages and vice versa
 */
@WebFilter(urlPatterns = {"/admin/*", "/user/*"})
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String role = SessionUtil.getRole(req);
        String uri  = req.getRequestURI();

        // Let guests view dashboard and browse
        if (uri.endsWith("/user/dashboard") || uri.endsWith("/user/browse")) {
            chain.doFilter(request, response);
            return;
        }

        if (role == null) {
            // Not logged in - redirect to login
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (uri.contains("/admin/") && !"admin".equals(role)) {
            req.getRequestDispatcher("/error/unauthorized.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("/user/") && !"user".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }
}