package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import util.SessionUtil;

import java.io.IOException;

/**
 * Stops logged-in users from seeing login/register pages
 */
@WebFilter(urlPatterns = {"/login", "/register"})
public class GuestFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if (SessionUtil.isLoggedIn(req)) {
            String role = SessionUtil.getRole(req);
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/dashboard");
            }
        } else {
            chain.doFilter(request, response);
        }
    }
}