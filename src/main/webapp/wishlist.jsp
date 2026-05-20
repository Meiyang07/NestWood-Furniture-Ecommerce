<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5.4">
    <style>
        /* ── Wishlist page styles ── */
        .wishlist-hero {
            background: linear-gradient(135deg, #8A6840 0%, #B8933A 50%, #D4AF70 100%);
            color: #fff;
            padding: 3.5rem 2rem 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .wishlist-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.2) 0%, transparent 100%);
            pointer-events: none;
        }

        .wishlist-hero .section-label {
            color: #FFF8E7;
            letter-spacing: 0.12em;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0.6rem;
            position: relative;
            z-index: 1;
        }

        .wishlist-hero h1 {
            font-size: clamp(1.6rem, 4vw, 2.4rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
            text-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .wishlist-hero p {
            color: rgba(255,255,255,0.9);
            font-size: 0.95rem;
            position: relative;
            z-index: 1;
        }

        .wishlist-main {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2.5rem 2rem;
        }

        /* Toolbar */
        .wishlist-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .wishlist-count {
            font-size: 1rem;
            color: #555;
        }

        .wishlist-count strong {
            color: #1a1a2e;
        }

        .btn-clear {
            background: none;
            border: 1.5px solid #e0d5c8;
            color: #888;
            padding: 0.45rem 1.1rem;
            border-radius: 6px;
            font-size: 0.88rem;
            cursor: pointer;
            text-decoration: none;
            transition: border-color 0.2s, color 0.2s;
        }

        .btn-clear:hover {
            border-color: #c0392b;
            color: #c0392b;
        }

        /* Flash banners */
        .flash {
            padding: 0.8rem 1.2rem;
            border-radius: 7px;
            font-size: 0.93rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .flash-success {
            background: #eafaf1;
            border-left: 4px solid #27ae60;
            color: #1e8449;
        }

        .flash-info {
            background: #fef9f0;
            border-left: 4px solid #c8a96e;
            color: #7a5c2e;
        }

        /* Wishlist grid */
        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1.5rem;
        }

        .wishlist-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 14px rgba(0, 0, 0, 0.07);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .wishlist-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.11);
        }

        .wishlist-img-wrap {
            position: relative;
            background: #f5efe6;
            height: 200px;
            overflow: hidden;
        }

        .wishlist-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .wishlist-badge-oos {
            position: absolute;
            top: 0.6rem;
            left: 0.6rem;
            background: #c0392b;
            color: #fff;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.2rem 0.6rem;
            border-radius: 4px;
        }

        /* Remove button top-right of image */
        .wishlist-remove-btn {
            position: absolute;
            top: 0.6rem;
            right: 0.6rem;
            background: rgba(255, 255, 255, 0.92);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #c0392b;
            font-size: 0.85rem;
            text-decoration: none;
            transition: background 0.2s;
        }

        .wishlist-remove-btn:hover {
            background: #c0392b;
            color: #fff;
        }

        .wishlist-info {
            padding: 1.2rem;
            display: flex;
            flex-direction: column;
            flex: 1;
            gap: 0.4rem;
        }

        .wishlist-category {
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: #c8a96e;
            font-weight: 600;
        }

        .wishlist-name {
            font-size: 1rem;
            font-weight: 700;
            color: #1a1a2e;
            margin: 0;
        }

        .wishlist-desc {
            font-size: 0.87rem;
            color: #777;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .wishlist-price {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-top: 0.3rem;
        }

        .wishlist-stock {
            font-size: 0.82rem;
            color: #888;
        }

        .stock-in {
            color: #27ae60;
        }

        .stock-out {
            color: #c0392b;
        }

        .wishlist-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.8rem;
        }

        .wishlist-actions .btn {
            flex: 1;
            text-align: center;
            font-size: 0.88rem;
            padding: 0.55rem 0.5rem;
        }

        /* Empty state */
        .wishlist-empty {
            text-align: center;
            padding: 4rem 2rem;
            color: #999;
        }

        .wishlist-empty .empty-icon {
            font-size: 4rem;
            color: #e0d5c8;
            margin-bottom: 1rem;
        }

        .wishlist-empty h2 {
            color: #555;
            font-size: 1.4rem;
            margin-bottom: 0.75rem;
        }

        .wishlist-empty p {
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }

        /* Guest notice */
        .guest-notice {
            background: #fef9f0;
            border: 1.5px dashed #c8a96e;
            border-radius: 8px;
            padding: 1rem 1.4rem;
            margin-bottom: 1.5rem;
            font-size: 0.93rem;
            color: #7a5c2e;
        }

        .guest-notice a {
            color: #c8a96e;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .wishlist-actions {
                flex-direction: column;
            }
        }
    </style>
</head>

<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<%-- ── Hero ─────────────────────────────────────────────────────── --%>
<section class="wishlist-hero">
    <p class="section-label">Saved Items</p>
    <h1><i class="fas fa-heart" style="color:#c8a96e"></i> My Wishlist</h1>
    <p>Products you've saved for later.</p>
</section>

<div class="wishlist-main">

    <%-- Guest notice --%>
    <c:if test="${empty sessionScope.loggedUser}">
        <div class="guest-notice">
            <i class="fas fa-info-circle"></i>
            You're browsing as a guest. Your wishlist is saved in this browser session only.
            <a href="${pageContext.request.contextPath}/login">Log in</a> to keep it
            permanently.
        </div>
    </c:if>

    <%-- Flash messages --%>
    <c:if test="${param.added eq 'true'}">
        <div class="flash flash-success">
            <i class="fas fa-check-circle"></i> Product added to your wishlist!
        </div>
    </c:if>
    <c:if test="${param.removed eq 'true'}">
        <div class="flash flash-info">
            <i class="fas fa-info-circle"></i> Item removed from wishlist.
        </div>
    </c:if>
    <c:if test="${param.cleared eq 'true'}">
        <div class="flash flash-info">
            <i class="fas fa-info-circle"></i> Wishlist cleared.
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty wishlistProducts}">

            <%-- Toolbar --%>
            <div class="wishlist-toolbar">
                <p class="wishlist-count">
                    <strong>${wishlistCount}</strong> item<c:if
                        test="${wishlistCount != 1}">s</c:if> saved
                </p>
                <a href="${pageContext.request.contextPath}/wishlist?action=clear"
                   class="btn-clear"
                   onclick="return confirm('Clear your entire wishlist?')">
                    <i class="fas fa-trash-alt"></i> Clear All
                </a>
            </div>

            <%-- Product cards --%>
            <div class="wishlist-grid">
                <c:forEach var="p" items="${wishlistProducts}">
                    <div class="wishlist-card">
                        <div class="wishlist-img-wrap">
                            <img src="${pageContext.request.contextPath}/assets/images/uploads/${p.image}"
                                 alt="${p.name}" class="wishlist-img"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.jpg'">

                            <c:if test="${p.stock <= 0}">
                                                                        <span class="wishlist-badge-oos">Out of
                                                                            Stock</span>
                            </c:if>

                                <%-- Remove button overlaid on image --%>
                            <a href="${pageContext.request.contextPath}/wishlist?action=remove&productId=${p.id}"
                               class="wishlist-remove-btn"
                               title="Remove from wishlist"
                               aria-label="Remove ${p.name} from wishlist">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>

                        <div class="wishlist-info">
                                                                    <span
                                                                            class="wishlist-category">${p.categoryName}</span>
                            <h3 class="wishlist-name">${p.name}</h3>
                            <p class="wishlist-desc">${p.description}</p>

                            <p class="wishlist-price">
                                Rs.
                                <fmt:formatNumber value="${p.price}"
                                                  pattern="#,##0.00" />
                            </p>
                            <p class="wishlist-stock">
                                <c:choose>
                                    <c:when test="${p.stock > 0}">
                                        <span class="stock-in">● In Stock</span>
                                        <span>(${p.stock} left)</span>
                                    </c:when>
                                    <c:otherwise>
                                                                                <span class="stock-out">● Out of
                                                                                    Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <div class="wishlist-actions">
                                <c:choose>
                                    <c:when
                                            test="${p.stock > 0 && not empty sessionScope.loggedUser}">
                                        <a href="${pageContext.request.contextPath}/order?action=checkout&productId=${p.id}"
                                           class="btn btn-primary">Order
                                            Now</a>
                                    </c:when>
                                    <c:when
                                            test="${p.stock > 0 && empty sessionScope.loggedUser}">
                                        <a href="${pageContext.request.contextPath}/login?msg=login_to_order&redirect=checkout&productId=${p.id}"
                                           class="btn btn-primary">Login to
                                            Order</a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary"
                                                disabled>Unavailable</button>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/wishlist?action=remove&productId=${p.id}"
                                   class="btn btn-outline">Remove</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </c:when>
        <c:otherwise>
            <%-- Empty state --%>
            <div class="wishlist-empty">
                <div class="empty-icon"><i class="fas fa-heart-broken"></i></div>
                <h2>Your wishlist is empty</h2>
                <p>Browse our collection and save products you love — they'll appear
                    here.</p>
                <a href="${pageContext.request.contextPath}/browse"
                   class="btn btn-primary">
                    <i class="fas fa-couch"></i> Browse Furniture
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

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