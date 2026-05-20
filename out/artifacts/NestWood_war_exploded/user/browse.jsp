<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Furniture — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5.4">
</head>

<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<main class="user-main">

    <%-- ── Page Header ─────────────────────────────────────────────── --%>
    <div class="page-header">
        <div>
            <p class="section-label">Our Collection</p>
            <h1 class="page-title">Browse Furniture</h1>
        </div>
    </div>

    <%-- ── Search Bar — action points to public /browse ──────────────── --%>
    <div class="browse-filter-bar">
        <form action="${pageContext.request.contextPath}/browse" method="get" class="filter-form">
            <div class="filter-search-wrap">
                <span class="filter-search-icon"><i class="fas fa-search" aria-hidden="true"></i></span>
                <input type="text" name="keyword" value="${keyword}"
                       placeholder="Search sofas, beds, tables..."
                       class="filter-search-input">
            </div>
            <div class="filter-actions">
                <button type="submit" class="btn btn-primary">Search</button>
                <a href="${pageContext.request.contextPath}/browse" class="btn btn-outline">Clear</a>
            </div>
        </form>
    </div>

    <%-- ── Results Info ─────────────────────────────────────────────── --%>
    <c:if test="${not empty keyword}">
        <p class="browse-result-info">
            Showing results for: <strong>"${keyword}"</strong>
            <a href="${pageContext.request.contextPath}/browse" class="browse-clear-link">× Clear</a>
        </p>
    </c:if>

    <%-- ── Guest login notice ────────────────────────────────────────── --%>
    <c:if test="${empty sessionScope.loggedUser}">
        <div class="info-banner" style="margin-bottom:1.5rem;padding:0.85rem 1.2rem;background:#fef9f0;border-left:4px solid #c8a96e;border-radius:6px;font-size:0.93rem">
            <i class="fas fa-info-circle" style="color:#c8a96e"></i>
            You are browsing as a guest.
            <a href="${pageContext.request.contextPath}/login" style="color:#c8a96e;font-weight:600">Log in</a>
            or
            <a href="${pageContext.request.contextPath}/register" style="color:#c8a96e;font-weight:600">register</a>
            to place orders.
        </div>
    </c:if>

    <%-- ── Success Messages ──────────────────────────────────────────── --%>
    <c:if test="${param.cartAdded == 'true'}">
        <div class="alert alert-success" style="margin-bottom:1.5rem">
            <i class="fas fa-check-circle"></i>
            Product added to cart successfully!
            <a href="${pageContext.request.contextPath}/cart" style="color:#2A6040;font-weight:600;margin-left:0.5rem">View Cart</a>
        </div>
    </c:if>

    <c:if test="${param.added == 'true'}">
        <div class="alert alert-success" style="margin-bottom:1.5rem">
            <i class="fas fa-heart"></i>
            Product added to wishlist successfully!
            <a href="${pageContext.request.contextPath}/wishlist" style="color:#2A6040;font-weight:600;margin-left:0.5rem">View Wishlist</a>
        </div>
    </c:if>

    <%-- ── Filter & Product Layout ─────────────────────────────────────── --%>
    <div class="browse-layout">
        <%-- Sidebar Filters --%>
        <aside class="browse-sidebar">
            <div class="filter-section">
                <div class="filter-header">
                    <h3><i class="fas fa-filter"></i> Filters</h3>
                    <c:if test="${not empty param.category or not empty param.minPrice or not empty param.maxPrice or not empty param.inStock}">
                        <a href="${pageContext.request.contextPath}/browse" class="filter-clear-all">Clear All</a>
                    </c:if>
                </div>

                <form action="${pageContext.request.contextPath}/browse" method="get" id="filterForm">
                    <%-- Preserve search keyword --%>
                    <c:if test="${not empty keyword}">
                        <input type="hidden" name="keyword" value="${keyword}">
                    </c:if>

                    <%-- Category Filter --%>
                    <div class="filter-group">
                        <h4 class="filter-title"><i class="fas fa-tags"></i> Category</h4>
                        <div class="filter-options">
                            <c:forEach var="cat" items="${categories}">
                                <label class="filter-checkbox">
                                    <input type="radio" name="category" value="${cat.id}" 
                                           ${param.category == cat.id ? 'checked' : ''}
                                           onchange="document.getElementById('filterForm').submit()">
                                    <span>${cat.name}</span>
                                </label>
                            </c:forEach>
                            <c:if test="${not empty param.category}">
                                <button type="button" class="filter-clear-btn" onclick="clearCategory()">
                                    <i class="fas fa-times"></i> Clear Category
                                </button>
                            </c:if>
                        </div>
                    </div>

                    <%-- Price Range Filter --%>
                    <div class="filter-group">
                        <h4 class="filter-title"><i class="fas fa-rupee-sign"></i> Price Range</h4>
                        <div class="filter-price-inputs-vertical">
                            <input type="number" name="minPrice" placeholder="Min Price" 
                                   value="${param.minPrice}" class="filter-price-input" min="0" step="1000">
                            <input type="number" name="maxPrice" placeholder="Max Price" 
                                   value="${param.maxPrice}" class="filter-price-input" min="0" step="1000">
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm btn-block" style="margin-top:0.75rem">
                            Apply Price
                        </button>
                    </div>

                    <%-- Stock Availability Filter --%>
                    <div class="filter-group">
                        <h4 class="filter-title"><i class="fas fa-box"></i> Availability</h4>
                        <div class="filter-options">
                            <label class="filter-checkbox">
                                <input type="checkbox" name="inStock" value="true" 
                                       ${param.inStock == 'true' ? 'checked' : ''}
                                       onchange="document.getElementById('filterForm').submit()">
                                <span>In Stock Only</span>
                            </label>
                        </div>
                    </div>
                </form>
            </div>

            <%-- Active Filters Display --%>
            <c:if test="${not empty param.category or not empty param.minPrice or not empty param.maxPrice or not empty param.inStock}">
                <div class="active-filters">
                    <h4>Active Filters:</h4>
                    <div class="filter-tags">
                        <c:if test="${not empty param.category}">
                            <c:forEach var="cat" items="${categories}">
                                <c:if test="${cat.id == param.category}">
                                    <span class="filter-tag">
                                        ${cat.name}
                                        <a href="${pageContext.request.contextPath}/browse?${not empty keyword ? 'keyword='.concat(keyword).concat('&') : ''}${not empty param.minPrice ? 'minPrice='.concat(param.minPrice).concat('&') : ''}${not empty param.maxPrice ? 'maxPrice='.concat(param.maxPrice).concat('&') : ''}${param.inStock == 'true' ? 'inStock=true' : ''}" 
                                           class="filter-tag-remove">×</a>
                                    </span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not empty param.minPrice or not empty param.maxPrice}">
                            <span class="filter-tag">
                                Rs. ${not empty param.minPrice ? param.minPrice : '0'} - ${not empty param.maxPrice ? param.maxPrice : '∞'}
                                <a href="${pageContext.request.contextPath}/browse?${not empty keyword ? 'keyword='.concat(keyword).concat('&') : ''}${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${param.inStock == 'true' ? 'inStock=true' : ''}" 
                                   class="filter-tag-remove">×</a>
                            </span>
                        </c:if>
                        <c:if test="${param.inStock == 'true'}">
                            <span class="filter-tag">
                                In Stock
                                <a href="${pageContext.request.contextPath}/browse?${not empty keyword ? 'keyword='.concat(keyword).concat('&') : ''}${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.minPrice ? 'minPrice='.concat(param.minPrice).concat('&') : ''}${not empty param.maxPrice ? 'maxPrice='.concat(param.maxPrice) : ''}" 
                                   class="filter-tag-remove">×</a>
                            </span>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </aside>

        <%-- Product Grid --%>
        <div class="browse-content">
            <div class="browse-grid">
                <c:forEach var="p" items="${products}" varStatus="status">
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
                                <%-- Featured Badge for featured products only --%>
                                <c:if test="${featuredProductIds.contains(p.id)}">
                                    <span class="product-featured-badge">
                                        <i class="fas fa-star" aria-hidden="true"></i> Featured
                                    </span>
                                </c:if>
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
                                <a href="${pageContext.request.contextPath}/wishlist?action=add&productId=${p.id}&from=browse"
                                   class="product-wishlist-icon" title="Add to Wishlist">
                                    <i class="fas fa-heart"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login?redirect=browse"
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
        </div>
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

<script>
function clearCategory() {
    const form = document.getElementById('filterForm');
    const categoryInputs = form.querySelectorAll('input[name="category"]');
    categoryInputs.forEach(input => input.checked = false);
    form.submit();
}
</script>
</body>
</html>