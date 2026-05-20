<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  admin-header.jsp — NestWood Admin Layout
  Redesigned: Banani AdminDashboard prototype.
  Dark charcoal sidebar + white topbar with user info.
  All href paths, session attributes (userName, userRole) UNCHANGED.
  Active detection via requestURI UNCHANGED.
--%>

<!-- ── Admin Sidebar ───────────────────────────────────────────── -->
<aside class="admin-sidebar">

    <!-- Brand -->
    <div class="sidebar-brand">
        Nest<span>Wood</span>
        <span class="sidebar-badge" style="color: white;">Admin</span>
    </div>

    <!-- Main menu -->
    <span class="sidebar-section-label">Menu</span>
    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                <span class="sidebar-icon"><i class="fas fa-th-large" aria-hidden="true"></i></span>
                Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/products?action=list"
               class="${pageContext.request.requestURI.contains('product') && !pageContext.request.requestURI.contains('product-add') ? 'active' : ''}">
                <span class="sidebar-icon"><i class="fas fa-couch" aria-hidden="true"></i></span>
                Products
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/products?action=add"
               class="${pageContext.request.requestURI.contains('product-add') || (pageContext.request.requestURI.contains('product') && request.getParameter('action') != null && request.getParameter('action').equals('add')) ? 'active' : ''}">
                <span class="sidebar-icon"><i class="fas fa-plus" aria-hidden="true"></i></span>
                Add Product
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order?action=adminOrders"
               class="${pageContext.request.requestURI.contains('order') ? 'active' : ''}">
                <span class="sidebar-icon"><i class="fas fa-box" aria-hidden="true"></i></span>
                Orders
                <%-- Pending order count badge — shown if stat is available --%>
                <c:if test="${not empty sessionScope.pendingOrderCount && sessionScope.pendingOrderCount > 0}">
                    <span class="sidebar-count">${sessionScope.pendingOrderCount}</span>
                </c:if>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="${pageContext.request.requestURI.contains('user') ? 'active' : ''}">
                <span class="sidebar-icon"><i class="fas fa-users" aria-hidden="true"></i></span>
                Users
            </a>
        </li>
    </ul>

    <!-- Admin profile section -->
    <a href="${pageContext.request.contextPath}/user/profile" class="sidebar-profile" style="text-decoration:none;color:inherit">
        <c:choose>
            <c:when test="${not empty sessionScope.userAvatar && sessionScope.userAvatar != 'default.png'}">
                <img src="${pageContext.request.contextPath}/assets/images/uploads/${sessionScope.userAvatar}" 
                     alt="${sessionScope.userName}" class="sidebar-profile-avatar" />
            </c:when>
            <c:otherwise>
                <div class="sidebar-profile-avatar" style="background: linear-gradient(135deg, #c8a96e 0%, #d4b87a 100%); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 1.1rem;">
                    ${sessionScope.userName.substring(0, 1).toUpperCase()}
                </div>
            </c:otherwise>
        </c:choose>
        <div class="sidebar-profile-info">
            <strong>${sessionScope.userName}</strong>
            <span>${sessionScope.userRole}</span>
        </div>
    </a>

    <!-- Logout at bottom -->
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout">
            <span class="sidebar-icon"><i class="fas fa-sign-out-alt" aria-hidden="true"></i></span>
            Logout
        </a>
    </div>

</aside>

<!-- ── Admin Topbar ────────────────────────────────────────────── -->
<nav class="admin-topbar">

    <div class="topbar-title">
        <h1>Dashboard Overview</h1>
        <p>Welcome back, <strong>${sessionScope.userName}</strong></p>
    </div>

    <div class="topbar-right">

        <!-- Notification bell -->
        <a href="${pageContext.request.contextPath}/order?action=adminOrders"
           class="nav-icon-btn" title="Pending orders" aria-label="Notifications">
            <i class="fas fa-bell" aria-hidden="true"></i>
            <c:if test="${not empty sessionScope.pendingOrderCount && sessionScope.pendingOrderCount > 0}">
                <span class="nav-badge">${sessionScope.pendingOrderCount}</span>
            </c:if>
        </a>

        <!-- User info -->
        <a href="${pageContext.request.contextPath}/user/profile" class="topbar-user" style="text-decoration:none;color:inherit">
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
            <div>
                <strong>${sessionScope.userName}</strong>
                <span>Super Administrator</span>
            </div>
        </a>

    </div>

</nav>

<script src="${pageContext.request.contextPath}/assets/js/script.js" defer></script>
