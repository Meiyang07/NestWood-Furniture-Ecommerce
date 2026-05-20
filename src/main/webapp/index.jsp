<%@ page contentType="text/html;charset=UTF-8" %>
<%--
  index.jsp — NestWood Landing Page
  Redirects all users (guests and logged-in) to appropriate dashboard.
--%>
<%
    Object userId = session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");

    if (userId != null) {
        if ("admin".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    } else {
        // Redirect guests to user dashboard as well
        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }
%>
