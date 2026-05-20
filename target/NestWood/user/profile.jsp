<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — NestWood</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=4.8">
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<main class="user-main">

    <div class="page-header" style="margin-bottom: 2rem;">
        <div>
            <p class="section-label"><i class="fas fa-user-circle" style="color: #C8A96E;"></i> Account Settings</p>
            <h1 class="page-title">My Profile</h1>
        </div>
        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline">
            <i class="fas fa-home"></i> Back to Dashboard
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
    </c:if>

    <div class="profile-layout">

        <%-- ── Enhanced Profile Card ────────────────────────────────────── --%>
        <div class="profile-sidebar-card" style="background: linear-gradient(135deg, #fdfbf7 0%, #f8f4ed 100%); border: 1px solid #e8dcc8; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
            <div class="profile-avatar-section" style="padding: 2rem 1.5rem;">
                <div class="profile-avatar-ring" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); padding: 5px; box-shadow: 0 6px 20px rgba(200, 169, 110, 0.3);">
                    <img src="${pageContext.request.contextPath}/assets/images/uploads/${sessionScope.loggedUser.avatar}"
                         alt="Avatar" class="avatar-lg"
                         style="border: 4px solid #fff;"
                         onerror="this.src='${pageContext.request.contextPath}/assets/images/uploads/default_avatar.png'">
                </div>
                <h3 class="profile-display-name" style="margin-top: 1.25rem; font-size: 1.5rem; color: #5A4A3A;">${sessionScope.loggedUser.fullName}</h3>
                <p class="profile-display-email" style="color: #8B7355; font-size: 0.95rem; margin-top: 0.25rem;">
                    <i class="fas fa-envelope" style="color: #C8A96E;"></i> ${sessionScope.loggedUser.email}
                </p>
                <span class="profile-member-badge" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; padding: 0.5rem 1.25rem; border-radius: 20px; font-size: 0.85rem; font-weight: 600; margin-top: 1rem; display: inline-block; box-shadow: 0 3px 10px rgba(200, 169, 110, 0.3);">
                    <i class="fas fa-star"></i> NestWood Member
                </span>
            </div>

            <div class="profile-nav-links" style="padding: 0 1rem 1.5rem;">
                <a href="${pageContext.request.contextPath}/order?action=history" class="profile-nav-link" style="background: #fff; border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.85rem 1rem; margin-bottom: 0.5rem; transition: all 0.3s ease; display: flex; align-items: center; gap: 0.75rem;">
                    <i class="fas fa-box" aria-hidden="true" style="color: #C8A96E; font-size: 1.1rem;"></i> 
                    <span style="color: #5A4A3A; font-weight: 500;">My Orders</span>
                </a>
                <a href="${pageContext.request.contextPath}/wishlist" class="profile-nav-link" style="background: #fff; border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.85rem 1rem; margin-bottom: 0.5rem; transition: all 0.3s ease; display: flex; align-items: center; gap: 0.75rem;">
                    <i class="fas fa-heart" aria-hidden="true" style="color: #C8A96E; font-size: 1.1rem;"></i> 
                    <span style="color: #5A4A3A; font-weight: 500;">My Wishlist</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/browse" class="profile-nav-link" style="background: #fff; border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.85rem 1rem; margin-bottom: 0.5rem; transition: all 0.3s ease; display: flex; align-items: center; gap: 0.75rem;">
                    <i class="fas fa-couch" aria-hidden="true" style="color: #C8A96E; font-size: 1.1rem;"></i> 
                    <span style="color: #5A4A3A; font-weight: 500;">Browse Furniture</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="profile-nav-link profile-nav-link--danger" style="background: #fff; border: 1px solid #ffcdd2; border-radius: 8px; padding: 0.85rem 1rem; transition: all 0.3s ease; display: flex; align-items: center; gap: 0.75rem;">
                    <i class="fas fa-door-open" aria-hidden="true" style="color: #e53935; font-size: 1.1rem;"></i> 
                    <span style="color: #e53935; font-weight: 500;">Logout</span>
                </a>
            </div>
        </div>

        <%-- ── Edit Forms ──────────────────────────────────────── --%>
        <div class="profile-forms-col">

            <%-- Update Profile Form --%>
            <div class="form-card" style="background: #fff; border: 1px solid #e8dcc8; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.06); margin-bottom: 1.5rem;">
                <div class="form-card-header" style="background: linear-gradient(135deg, #fdfbf7 0%, #f8f4ed 100%); padding: 1.5rem; border-bottom: 1px solid #e8dcc8; border-radius: 12px 12px 0 0;">
                    <span class="form-card-icon" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; width: 40px; height: 40px; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center; margin-right: 0.75rem; box-shadow: 0 3px 10px rgba(200, 169, 110, 0.3);"><i class="fas fa-user" aria-hidden="true"></i></span>
                    <h2 style="display: inline-block; color: #5A4A3A; font-size: 1.35rem; font-weight: 600;">Update Profile</h2>
                </div>
                <form action="${pageContext.request.contextPath}/user/profile"
                      method="post" enctype="multipart/form-data" style="padding: 2rem;">
                    <input type="hidden" name="action" value="updateProfile">

                    <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; margin-bottom: 1.25rem;">
                        <div class="form-group">
                            <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-user-tag" style="color: #C8A96E;"></i> Full Name <span class="required">*</span>
                            </label>
                            <input type="text" name="fullName"
                                   value="${sessionScope.loggedUser.fullName}"
                                   class="form-input" style="border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem;" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-phone" style="color: #C8A96E;"></i> Phone Number <span class="required">*</span>
                            </label>
                            <input type="tel" name="phone"
                                   value="${sessionScope.loggedUser.phone}"
                                   class="form-input" style="border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem;" maxlength="10" required>
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom: 1.25rem;">
                        <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-envelope" style="color: #C8A96E;"></i> Email Address
                        </label>
                        <input type="email" value="${sessionScope.loggedUser.email}"
                               class="form-input" disabled
                               style="opacity:0.6;cursor:not-allowed; border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem; background: #f8f4ed;">
                        <small class="form-hint" style="color: #8B7355; font-size: 0.85rem; margin-top: 0.35rem; display: block;">
                            <i class="fas fa-info-circle"></i> Email address cannot be changed.
                        </small>
                    </div>

                    <div class="form-group" style="margin-bottom: 1.5rem;">
                        <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.75rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-camera" style="color: #C8A96E;"></i> Profile Picture
                        </label>
                        <div class="file-upload-wrap" style="background: linear-gradient(135deg, #fdfbf7 0%, #f8f4ed 100%); border: 2px dashed #c8a96e; border-radius: 10px; padding: 1.5rem; text-align: center; transition: all 0.3s ease;">
                            <input type="file" name="avatar" accept="image/*" id="avatarInput"
                                   class="file-upload-input" style="display: none;">
                            <label for="avatarInput" class="file-upload-label" style="cursor: pointer; display: inline-block;">
                                <div style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; padding: 0.75rem 1.5rem; border-radius: 8px; font-weight: 600; box-shadow: 0 3px 10px rgba(200, 169, 110, 0.3); transition: all 0.3s ease;">
                                    <i class="fas fa-cloud-upload-alt" aria-hidden="true"></i> Choose Image
                                </div>
                            </label>
                            <span class="file-upload-hint" style="display: block; margin-top: 0.75rem; color: #8B7355; font-size: 0.85rem;">
                                <i class="fas fa-info-circle"></i> JPG, PNG, WEBP — Max 2MB
                            </span>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); border: none; padding: 0.85rem 2rem; border-radius: 8px; font-weight: 600; box-shadow: 0 4px 12px rgba(200, 169, 110, 0.3); transition: all 0.3s ease;">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>

            <%-- Change Password Form --%>
            <div class="form-card" style="background: #fff; border: 1px solid #e8dcc8; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.06);">
                <div class="form-card-header" style="background: linear-gradient(135deg, #fdfbf7 0%, #f8f4ed 100%); padding: 1.5rem; border-bottom: 1px solid #e8dcc8; border-radius: 12px 12px 0 0;">
                    <span class="form-card-icon" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; width: 40px; height: 40px; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center; margin-right: 0.75rem; box-shadow: 0 3px 10px rgba(200, 169, 110, 0.3);"><i class="fas fa-key" aria-hidden="true"></i></span>
                    <h2 style="display: inline-block; color: #5A4A3A; font-size: 1.35rem; font-weight: 600;">Change Password</h2>
                </div>
                <form action="${pageContext.request.contextPath}/user/profile" method="post" style="padding: 2rem;">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="form-group" style="margin-bottom: 1.25rem;">
                        <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-lock" style="color: #C8A96E;"></i> Current Password <span class="required">*</span>
                        </label>
                        <input type="password" name="currentPassword" class="form-input" style="border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem;" required>
                    </div>

                    <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; margin-bottom: 1.5rem;">
                        <div class="form-group">
                            <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-lock" style="color: #C8A96E;"></i> New Password <span class="required">*</span>
                            </label>
                            <input type="password" name="newPassword" id="newPwd"
                                   class="form-input" style="border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem;" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" style="color: #5A4A3A; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-check-circle" style="color: #C8A96E;"></i> Confirm Password <span class="required">*</span>
                            </label>
                            <input type="password" name="confirmNew" id="confirmPwd"
                                   class="form-input" style="border: 1px solid #e8dcc8; border-radius: 8px; padding: 0.75rem 1rem;" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-warning" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); border: none; padding: 0.85rem 2rem; border-radius: 8px; font-weight: 600; color: #fff; box-shadow: 0 4px 12px rgba(200, 169, 110, 0.3); transition: all 0.3s ease;">
                            <i class="fas fa-shield-alt"></i> Update Password
                        </button>
                    </div>
                </form>
            </div>

        </div><%-- end profile-forms-col --%>
    </div>

</main>

<footer class="site-footer">
    <div class="footer-grid">
        <div>
            <div class="footer-brand-name"><i class="fas fa-tree" aria-hidden="true"></i> Nest<span>Wood</span></div>
            <p class="footer-brand-desc">Premium furniture for modern homes. Crafted with care, designed for comfort.</p>
            <div class="footer-social">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook" aria-hidden="true"></i></a>
                <a href="#" aria-label="Instagram"><i class="fab fa-instagram" aria-hidden="true"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter" aria-hidden="true"></i></a>
                <a href="#" aria-label="Pinterest"><i class="fab fa-pinterest" aria-hidden="true"></i></a>
            </div>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/dashboard">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/browse">Browse</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Customer Service</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/order?action=history">Track Order</a></li>
                <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                <li><a href="${pageContext.request.contextPath}/user/profile">My Account</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Help & Support</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="footer-contact">
                <li><i class="fas fa-map-marker-alt" aria-hidden="true"></i> Kathmandu, Nepal</li>
                <li><i class="fas fa-phone" aria-hidden="true"></i> +977 1-4567890</li>
                <li><i class="fas fa-envelope" aria-hidden="true"></i> info@nestwood.com</li>
                <li><i class="fas fa-clock" aria-hidden="true"></i> Mon-Sat: 9AM-6PM</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 NestWood · Premium Furniture E-Commerce · Nepal</p>
        <div class="footer-bottom-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<style>
    /* Profile page hover effects */
    .profile-nav-link:hover {
        transform: translateX(5px);
        box-shadow: 0 4px 12px rgba(200, 169, 110, 0.2) !important;
        border-color: #c8a96e !important;
    }
    
    .profile-nav-link--danger:hover {
        transform: translateX(5px);
        box-shadow: 0 4px 12px rgba(229, 57, 53, 0.2) !important;
        border-color: #e53935 !important;
    }
    
    .file-upload-wrap:hover {
        border-color: #d4b87a;
        background: linear-gradient(135deg, #fff 0%, #fdfbf7 100%);
    }
    
    .file-upload-label:hover > div {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(200, 169, 110, 0.4);
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(200, 169, 110, 0.4) !important;
    }
    
    .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 152, 0, 0.4) !important;
    }
</style>
</body>
</html>