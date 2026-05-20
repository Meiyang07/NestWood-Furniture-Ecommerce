<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — NestWood</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5.4">
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<main class="user-main">

    <%-- ── Hero Banner ─────────────────────────────────────────── --%>
    <div class="hero-banner">
        <div>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                    <p class="hero-welcome">Welcome back</p>
                    <h1 class="hero-name">${sessionScope.userName}</h1>
                </c:when>
                <c:otherwise>
                    <p class="hero-welcome">Welcome</p>
                    <h1 class="hero-name">Guest</h1>
                </c:otherwise>
            </c:choose>
            <p class="hero-tagline">Discover premium furniture crafted for your home.</p>
            <div class="hero-cta-row">
                <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-gold btn-lg">Browse Collection</a>
                <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-outline-light">My Orders</a>
            </div>
        </div>
        <span class="hero-banner-emoji"><i class="fas fa-tree" aria-hidden="true"></i></span>
    </div>

    <%-- ── Quick Actions ───────────────────────────────────────── --%>
    <div class="action-grid">
        <a href="${pageContext.request.contextPath}/user/browse" class="action-card">
            <span class="action-icon"><i class="fas fa-couch" aria-hidden="true"></i></span>
            <span class="action-title">Browse Furniture</span>
            <span class="action-desc">Explore our full collection</span>
        </a>
        <a href="${pageContext.request.contextPath}/order?action=history" class="action-card">
            <span class="action-icon"><i class="fas fa-box" aria-hidden="true"></i></span>
            <span class="action-title">My Orders</span>
            <span class="action-desc">Track your purchases</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/profile" class="action-card">
            <span class="action-icon"><i class="fas fa-user" aria-hidden="true"></i></span>
            <span class="action-title">My Profile</span>
            <span class="action-desc">Update your details</span>
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope.loggedUser}">
                <a href="${pageContext.request.contextPath}/logout" class="action-card">
                    <span class="action-icon"><i class="fas fa-door-open" aria-hidden="true"></i></span>
                    <span class="action-title">Logout</span>
                    <span class="action-desc">Sign out securely</span>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="action-card">
                    <span class="action-icon"><i class="fas fa-sign-in-alt" aria-hidden="true"></i></span>
                    <span class="action-title">Sign In</span>
                    <span class="action-desc">Login to your account</span>
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- ── Featured Products Slider ──────────────────────────── --%>
    <section class="section">
        <div class="section-header">
            <div>
                <p class="section-label">Handpicked For You</p>
                <h2 class="section-title">Featured Products</h2>
            </div>
            <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-outline">View All</a>
        </div>

        <%-- Slider wrapper if products exist --%>
        <c:if test="${not empty featuredProducts}">
            <section class="slider-section" style="border-radius:var(--radius-lg);margin-bottom:0">
                <div class="slider-track">
                    <c:forEach var="p" items="${featuredProducts}" end="3">
                        <div class="slide" style="height:420px">
                            <c:choose>
                                <c:when test="${not empty p.image}">
                                    <img src="${pageContext.request.contextPath}/assets/images/uploads/${p.image}"
                                         alt="${p.name}" class="slide-bg"
                                         onerror="this.style.display='none'">
                                </c:when>
                            </c:choose>
                            <div class="slide-overlay">
                                <div class="slide-content">
                                    <p class="slide-tag">${p.categoryName}</p>
                                    <h2 class="slide-title" style="font-size:clamp(1.4rem,3vw,2.2rem)">${p.name}</h2>
                                    <p class="slide-desc">${p.description}</p>
                                    <div class="slide-cta">
                                        <a href="${pageContext.request.contextPath}/order?action=checkout&productId=${p.id}"
                                           class="btn btn-gold">Order Now</a>
                                        <span class="slide-price">Rs. <fmt:formatNumber value="${p.price}" pattern="#,##0"/></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="slider-arrow prev" aria-label="Previous">&#8592;</button>
                <button class="slider-arrow next" aria-label="Next">&#8594;</button>
                <div class="slider-dots">
                    <c:forEach var="p" items="${featuredProducts}" begin="0" end="3" varStatus="s">
                        <button class="slider-dot ${s.first ? 'active' : ''}" aria-label="Slide ${s.index + 1}"></button>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <c:if test="${empty featuredProducts}">
            <p class="text-muted">No featured products available right now.</p>
        </c:if>
    </section>

    <%-- ── Product Grid (below slider) ──────────────────────── --%>
    <section class="section">
        <div class="browse-grid" style="grid-template-columns: repeat(4, 1fr);">
            <c:forEach var="p" items="${featuredProducts}" end="3">
                <div class="browse-card">
                    <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="browse-card-link">
                        <div class="browse-card-image">
                            <img src="${pageContext.request.contextPath}/assets/images/uploads/${p.image}"
                                 alt="${p.name}" class="product-img"
                                 onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                            <div class="product-img-placeholder" style="display:none"><i class="fas fa-couch" aria-hidden="true"></i></div>
                            <c:if test="${p.stock <= 0}">
                                <span class="product-badge-oos">Out of Stock</span>
                            </c:if>
                            <%-- Featured Badge --%>
                            <span class="product-featured-badge">
                                <i class="fas fa-star" aria-hidden="true"></i> Featured
                            </span>
                        </div>
                        <div class="browse-card-body">
                            <span class="category-tag">${p.categoryName}</span>
                            <h3>${p.name}</h3>
                            <p class="product-desc">${p.description}</p>
                        </div>
                    </a>
                    <%-- Wishlist Icon Top Right --%>
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedUser}">
                            <a href="${pageContext.request.contextPath}/wishlist?action=add&productId=${p.id}&from=dashboard"
                               class="product-wishlist-icon" title="Add to Wishlist">
                                <i class="fas fa-heart"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login?redirect=dashboard"
                               class="product-wishlist-icon" title="Sign in to add to wishlist">
                                <i class="fas fa-heart"></i>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <div class="browse-card-actions">
                        <div class="product-footer">
                            <p class="price">Rs. <fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></p>
                            <p class="stock-info">
                                <c:choose>
                                    <c:when test="${p.stock > 0}">
                                        <span class="stock-dot available"></span>&nbsp;In Stock (${p.stock})
                                    </c:when>
                                    <c:otherwise>
                                        <span class="stock-dot out"></span>&nbsp;Out of Stock
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="product-card-buttons">
                            <c:choose>
                                <c:when test="${p.stock > 0}">
                                    <%-- Order Now Button --%>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.loggedUser}">
                                            <a href="${pageContext.request.contextPath}/order?action=checkout&productId=${p.id}"
                                               class="btn btn-primary btn-block">
                                                <i class="fas fa-shopping-bag"></i> Order Now
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login?redirect=checkout&productId=${p.id}"
                                               class="btn btn-primary btn-block">
                                                <i class="fas fa-shopping-bag"></i> Order Now
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-disabled btn-block" disabled>
                                        <i class="fas fa-times-circle"></i> Out of Stock
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <%-- ── Recent Orders ──────────────────────────────────────── --%>
    <section class="section">
        <div class="section-header">
            <div>
                <p class="section-label">Your Activity</p>
                <h2 class="section-title">Recent Orders</h2>
            </div>
            <c:if test="${not empty myOrders}">
                <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-outline">View All</a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.loggedUser}">
                <div class="card" style="padding:2.5rem;text-align:center;">
                    <p style="font-size:2.5rem;margin-bottom:1rem"><i class="fas fa-sign-in-alt" aria-hidden="true"></i></p>
                    <p class="text-muted" style="margin-bottom:1rem">Sign in to view your orders.</p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Sign In</a>
                </div>
            </c:when>
            <c:when test="${empty myOrders}">
                <div class="card" style="padding:2.5rem;text-align:center;">
                    <p style="font-size:2.5rem;margin-bottom:1rem"><i class="fas fa-shopping-cart" aria-hidden="true"></i></p>
                    <p class="text-muted" style="margin-bottom:1rem">You haven't placed any orders yet.</p>
                    <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-primary">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <table class="data-table">
                        <thead>
                        <tr><th>Product</th><th>Qty</th><th>Total</th><th>Status</th><th>Date</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${myOrders}" end="4">
                            <tr>
                                <td>${o.productName}</td>
                                <td>${o.quantity}</td>
                                <td>Rs. <fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/></td>
                                <td><span class="badge badge-${o.status}">${o.status}</span></td>
                                <td>${o.createdAt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

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

</body>
</html>
