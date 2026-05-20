<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--login.jsp — NestWood Login Page--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NestWood — Sign In</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="auth-page">

<div class="auth-split">

    <!-- ── Left: Form Panel ───────────────────────────────────────── -->
    <div class="auth-form-side">

        <div class="auth-brand">
            <div class="auth-brand-name">Nest<span>Wood</span></div>
        </div>

        <h1 class="auth-card-title">Sign In</h1>
        <p class="auth-card-sub">Enter your details to access your account.</p>

        <%-- Success message after registration --%>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <%-- Success message after logout --%>
        <c:if test="${param.logout == 'true'}">
            <div class="alert alert-success">You have been logged out successfully.</div>
        </c:if>

        <%-- Error message --%>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <%-- Show contextual message when guest tries to order --%>
        <c:if test="${param.msg eq 'login_to_order'}">
            <div class="alert alert-info" style="margin-bottom:1rem;padding:0.75rem 1rem;background:#fef9f0;border-left:4px solid #c8a96e;border-radius:6px;font-size:0.93rem">
                <i class="fas fa-info-circle" style="color:#c8a96e"></i>
                Please log in to place an order.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" novalidate>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       value="${not empty rememberedEmail ? rememberedEmail : ''}"
                       placeholder="you@example.com" required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="password" style="display:flex;justify-content:space-between;align-items:center">
                    Password
                    <a href="javascript:void(0)" onclick="alert('Please contact the administrator to reset your password.')" style="font-size:0.78rem;color:var(--gold);font-weight:500">Forgot password?</a>
                </label>
                <input type="password" id="password" name="password"
                       placeholder="Enter your password" required autocomplete="current-password">
            </div>

            <div class="form-check">
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <label for="rememberMe">Remember me</label>
            </div>

            <button type="submit" class="btn btn-gold btn-block btn-lg" style="margin-top:0.5rem">
                Sign In
            </button>

        </form>

        <p class="auth-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Register here</a>
        </p>

    </div>

    <!--Right: Image/Brand Panel-->
    <div class="auth-image-side">
        <!-- Add your background image here -->
        <img src="${pageContext.request.contextPath}/assets/images/uploads/login-hero.jpg"
             alt="NestWood Furniture" class="auth-image-bg">
        <div class="auth-image-gradient"></div>
        <div class="auth-image-overlay">
            <h2>Welcome Back</h2>
            <p>Sign in to continue accessing your premium furniture orders and wishlist.</p>
        </div>
    </div>

</div>

</body>
</html>
