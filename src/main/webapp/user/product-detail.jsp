<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=6.0">
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<main class="user-main">
    
    <%-- Breadcrumb --%>
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-home" aria-hidden="true"></i> Home</a>
        <span class="breadcrumb-separator">/</span>
        <a href="${pageContext.request.contextPath}/browse">Browse</a>
        <span class="breadcrumb-separator">/</span>
        <span class="breadcrumb-current">${product.name}</span>
    </div>

    <%-- Product Detail Section --%>
    <div class="product-detail-layout">
        
        <%-- Product Image --%>
        <div class="product-detail-image" style="position: relative;">
            <div class="product-image-main">
                <img src="${pageContext.request.contextPath}/assets/images/uploads/${product.image}"
                     alt="${product.name}"
                     onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                <div class="product-img-placeholder" style="display:none">
                    <i class="fas fa-couch" aria-hidden="true"></i>
                </div>
            </div>
            <c:if test="${product.stock <= 0}">
                <div class="product-out-of-stock-badge">
                    <i class="fas fa-times-circle" aria-hidden="true"></i> Out of Stock
                </div>
            </c:if>
            <%-- Wishlist Icon Top Right --%>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                    <a href="${pageContext.request.contextPath}/wishlist?action=add&productId=${product.id}&from=detail"
                       class="product-detail-wishlist-icon" title="Add to Wishlist">
                        <i class="fas fa-heart"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login?redirect=detail&productId=${product.id}"
                       class="product-detail-wishlist-icon" title="Sign in to add to wishlist">
                        <i class="fas fa-heart"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Product Info --%>
        <div class="product-detail-info">
            <div style="display: flex; align-items: center; gap: 1rem; flex-wrap: wrap;">
                <span class="product-category-badge">
                    <i class="fas fa-tag" aria-hidden="true"></i> ${product.categoryName}
                </span>
                <c:if test="${isFeatured}">
                    <span class="product-featured-badge-detail">
                        <i class="fas fa-star" aria-hidden="true"></i> Featured Product
                    </span>
                </c:if>
            </div>
            <h1 class="product-detail-title">${product.name}</h1>
            
            <div class="product-detail-price">
                <span class="price-label">Price:</span>
                <span class="price-value">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
            </div>

            <div class="product-detail-stock">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <span class="stock-badge stock-available">
                            <i class="fas fa-check-circle" aria-hidden="true"></i> In Stock (${product.stock} available)
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="stock-badge stock-unavailable">
                            <i class="fas fa-times-circle" aria-hidden="true"></i> Out of Stock
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="product-detail-description">
                <h3><i class="fas fa-info-circle" aria-hidden="true"></i> Description</h3>
                <p>${product.description}</p>
            </div>

            <%-- Action Buttons --%>
            <div class="product-detail-actions">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <c:choose>
                            <c:when test="${not empty sessionScope.loggedUser}">
                                <a href="${pageContext.request.contextPath}/order?action=checkout&productId=${product.id}"
                                   class="btn btn-primary btn-lg">
                                    <i class="fas fa-shopping-bag" aria-hidden="true"></i> Order Now
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login?redirect=checkout&productId=${product.id}"
                                   class="btn btn-primary btn-lg">
                                    <i class="fas fa-shopping-bag" aria-hidden="true"></i> Order Now
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-disabled btn-lg" disabled>
                            <i class="fas fa-times-circle" aria-hidden="true"></i> Out of Stock
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Additional Info --%>
            <div class="product-detail-meta">
                <div class="meta-item">
                    <i class="fas fa-shipping-fast" aria-hidden="true" style="color: #C8A96E;"></i>
                    <span>Free delivery on orders over Rs. 50,000</span>
                </div>
                <div class="meta-item">
                    <i class="fas fa-certificate" aria-hidden="true" style="color: #C8A96E;"></i>
                    <span>1 Year warranty on all products</span>
                </div>
                <div class="meta-item">
                    <i class="fas fa-sync-alt" aria-hidden="true" style="color: #C8A96E;"></i>
                    <span>7 days return policy</span>
                </div>
            </div>
        </div>
    </div>

    <%-- Back to Browse --%>
    <div style="margin-top: 3rem; text-align: center;">
        <a href="${pageContext.request.contextPath}/browse" class="btn btn-outline-gold btn-lg">
            <i class="fas fa-arrow-left" aria-hidden="true"></i> Back to Browse
        </a>
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
                <li><a href="mailto:info@nestwood.com"><i class="fas fa-envelope" aria-hidden="true"></i> info@nestwood.com</a></li>
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
