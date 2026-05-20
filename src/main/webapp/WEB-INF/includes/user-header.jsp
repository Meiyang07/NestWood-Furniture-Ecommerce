<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  user-header.jsp — NestWood User Navigation
  Redesigned: Banani UserDashboard nav prototype.
  All href paths, session attributes (userName, userId, userRole) UNCHANGED.
  Active-link detection via requestURI UNCHANGED.
--%>
<nav class="user-nav">

    <!-- Brand -->
    <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-brand">
        Nest<span>Wood</span>
    </a>

    <!-- Center links (desktop) -->
    <div class="nav-center">
        <a href="${pageContext.request.contextPath}/user/dashboard"
           class="${pageContext.request.requestURI.contains('dashboard') ? 'nav-active' : ''}">
            Home
        </a>
        <a href="${pageContext.request.contextPath}/user/browse"
           class="${pageContext.request.requestURI.contains('browse') ? 'nav-active' : ''}">
            Browse
        </a>
        <a href="${pageContext.request.contextPath}/about"
           class="${pageContext.request.requestURI.contains('about') ? 'nav-active' : ''}">
            About
        </a>
        <a href="${pageContext.request.contextPath}/contact"
           class="${pageContext.request.requestURI.contains('contact') ? 'nav-active' : ''}">
            Contact
        </a>
        <a href="${pageContext.request.contextPath}/order?action=history"
           class="${pageContext.request.requestURI.contains('history') ? 'nav-active' : ''}">
            My Orders
        </a>
        <a href="${pageContext.request.contextPath}/wishlist"
           class="${pageContext.request.requestURI.contains('wishlist') ? 'nav-active' : ''}">
            Wishlist
        </a>
        <a href="${pageContext.request.contextPath}/user/profile"
           class="${pageContext.request.requestURI.contains('profile') ? 'nav-active' : ''}">
            Profile
        </a>
    </div>

    <!-- Mobile toggle -->
    <button class="nav-toggle" aria-label="Toggle menu" aria-expanded="false">
        <span></span><span></span><span></span>
    </button>

    <!-- Right: user dropdown + logout (desktop) -->
    <div class="nav-right">
        <c:choose>
            <c:when test="${not empty sessionScope.loggedUser}">
                <!-- User dropdown -->
                <div class="nav-user-dropdown">
                    <a href="${pageContext.request.contextPath}/user/profile" class="nav-user" aria-label="Go to profile">
                        <c:choose>
                            <c:when test="${not empty sessionScope.userAvatar && sessionScope.userAvatar != 'default.png'}">
                                <img src="${pageContext.request.contextPath}/assets/images/uploads/${sessionScope.userAvatar}" 
                                     alt="${sessionScope.userName}" class="nav-avatar" />
                            </c:when>
                            <c:otherwise>
                                <div class="nav-avatar" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">
                                    ${sessionScope.userName.substring(0, 1).toUpperCase()}
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <span>${sessionScope.userName}</span>
                    </a>
                    
                    <!-- Dropdown menu -->
                    <div class="nav-dropdown-menu">
                        <a href="${pageContext.request.contextPath}/wishlist" class="nav-dropdown-item">
                            <i class="fas fa-heart" aria-hidden="true"></i> Wishlist
                        </a>
                        <div class="nav-dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/logout" class="nav-dropdown-item nav-dropdown-item-danger">
                            <i class="fas fa-sign-out-alt" aria-hidden="true"></i> Logout
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Guest section -->
                <div class="nav-guest-section">
                    <div class="nav-guest-icon" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">
                        G
                    </div>
                    <span style="color: var(--text-mid); font-weight: 500; margin-right: 0.75rem;">Guest</span>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-gold btn-sm">Sign In</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Mobile nav links (hidden until toggle) -->
    <ul class="nav-links">
        <li>
            <a href="${pageContext.request.contextPath}/user/dashboard"
               class="${pageContext.request.requestURI.contains('dashboard') ? 'nav-active' : ''}">
                <i class="fas fa-home" aria-hidden="true"></i> Home
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/user/browse"
               class="${pageContext.request.requestURI.contains('browse') ? 'nav-active' : ''}">
                <i class="fas fa-couch" aria-hidden="true"></i> Browse
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/about"
               class="${pageContext.request.requestURI.contains('about') ? 'nav-active' : ''}">
                <i class="fas fa-info-circle" aria-hidden="true"></i> About
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/contact"
               class="${pageContext.request.requestURI.contains('contact') ? 'nav-active' : ''}">
                <i class="fas fa-envelope" aria-hidden="true"></i> Contact
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order?action=history"
               class="${pageContext.request.requestURI.contains('history') ? 'nav-active' : ''}">
                <i class="fas fa-box" aria-hidden="true"></i> My Orders
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/wishlist"
               class="${pageContext.request.requestURI.contains('wishlist') ? 'nav-active' : ''}">
                <i class="fas fa-heart" aria-hidden="true"></i> Wishlist
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/user/profile"
               class="${pageContext.request.requestURI.contains('profile') ? 'nav-active' : ''}">
                <i class="fas fa-user" aria-hidden="true"></i> Profile
            </a>
        </li>
        <c:choose>
            <c:when test="${not empty sessionScope.loggedUser}">
                <li>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-cta">Logout</a>
                </li>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="${pageContext.request.contextPath}/login" class="nav-cta">Sign In</a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>

</nav>

<%-- Script loads here so slider/nav JS runs after DOM is ready --%>
<script src="${pageContext.request.contextPath}/assets/js/script.js" defer></script>
