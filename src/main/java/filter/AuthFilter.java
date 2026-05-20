package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import util.SessionUtil;

import java.io.IOException;

/**
 * Blocks unauthenticated users from protected pages
 */
@WebFilter(urlPatterns = {
        "/admin/*",
        "/user/profile",
        "/user/checkout",
        "/user/history",
        "/order"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Let guests access checkout (OrderServlet will redirect if needed)
        String action = req.getParameter("action");
        if ("checkout".equals(action)) {
            chain.doFilter(request, response);
            return;
        }

        if (SessionUtil.isLoggedIn(req)) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}