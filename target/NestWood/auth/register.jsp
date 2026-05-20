<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  register.jsp — NestWood Register Page--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NestWood — Create Account</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="auth-page">

<div class="auth-split">

    <!--Left: Form Panel-->
    <div class="auth-form-side">

        <div class="auth-brand">
            <div class="auth-brand-name">Nest<span>Wood</span></div>
        </div>

        <h1 class="auth-card-title">Create Account</h1>
        <p class="auth-card-sub">Join NestWood to start shopping premium furniture.</p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <%-- Avatar upload circle — clicking triggers hidden file input --%>
        <div class="avatar-upload-wrap">
            <div class="avatar-upload-circle" id="avatarCircle" title="Upload profile photo">
                <i class="fas fa-camera" aria-hidden="true"></i>
                <span class="avatar-upload-plus">+</span>
            </div>
        </div>

        <%-- enctype for file upload — UNCHANGED --%>
        <form action="${pageContext.request.contextPath}/register"
              method="post" enctype="multipart/form-data" novalidate>

            <%-- Hidden file input triggered by avatar circle --%>
            <input type="file" id="avatar" name="avatar" accept="image/*"
                   style="display:none">

            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       value="${not empty fullName ? fullName : ''}"
                       placeholder="Pokemon Gurung" required autocomplete="name">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       value="${not empty email ? email : ''}"
                       placeholder="you@example.com" required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone"
                       value="${not empty phone ? phone : ''}"
                       placeholder="+977 9800000000" maxlength="10" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"
                           placeholder="Enter your password" required autocomplete="new-password">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Confirm your password" required autocomplete="new-password">
                </div>
            </div>

            <button type="submit" class="btn btn-gold btn-block btn-lg" style="margin-top:0.25rem">
                Register Account
            </button>

        </form>

        <p class="auth-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign In</a>
        </p>

    </div>

    <!-- ── Right: Image/Brand Panel ───────────────────────────────── -->
    <div class="auth-image-side">
        <!-- Add your background image here -->
        <img src="${pageContext.request.contextPath}/assets/images/uploads/register-hero.jpg"
             alt="NestWood Furniture" class="auth-image-bg">
        <div class="auth-image-gradient"></div>
        <div class="auth-image-overlay">
            <h2>Design Your Dream Home</h2>
            <p>Join thousands of customers who have elevated their living spaces with NestWood.</p>
        </div>
    </div>

</div>

<script>
    /* Avatar preview — triggers file input via circle click */
    (function () {
        var circle = document.getElementById('avatarCircle');
        var input  = document.getElementById('avatar');
        if (!circle || !input) return;
        circle.addEventListener('click', function () { input.click(); });
        input.addEventListener('change', function () {
            var file = this.files[0];
            if (!file) return;
            var reader = new FileReader();
            reader.onload = function (e) {
                circle.style.backgroundImage  = 'url(' + e.target.result + ')';
                circle.style.backgroundSize   = 'cover';
                circle.style.backgroundPosition = 'center';
                circle.innerHTML = '';
            };
            reader.readAsDataURL(file);
        });
    })();
</script>

</body>
</html>
