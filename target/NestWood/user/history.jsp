<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders — NestWood</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=4.1">
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<main class="user-main">

    <div class="page-header">
        <div>
            <p class="section-label">Your Purchases</p>
            <h1 class="page-title">Order History</h1>
        </div>
        <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-primary">+ New Order</a>
    </div>

    <c:if test="${param.placed == 'true'}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle" aria-hidden="true" style="color: var(--gold);"></i> Your order has been placed successfully! We'll process it shortly.
        </div>
    </c:if>
    <c:if test="${param.cancelled == 'true'}">
        <div class="alert alert-info">
            <i class="fas fa-check-circle" aria-hidden="true" style="color: var(--gold);"></i> Your order has been cancelled.
        </div>
    </c:if>

    <c:if test="${empty orders}">
        <div class="empty-state card" style="padding:3.5rem 2rem">
            <p class="empty-state-icon"><i class="fas fa-receipt" aria-hidden="true" style="color: var(--gold);"></i></p>
            <h3 style="margin-bottom:0.5rem;color:var(--walnut)">No Orders Yet</h3>
            <p class="text-muted" style="margin-bottom:1.5rem">
                You haven't placed any orders. Start exploring our furniture collection!
            </p>
            <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-primary">Browse Products</a>
        </div>
    </c:if>

    <c:if test="${not empty orders}">
        <div class="order-list">
            <c:forEach var="o" items="${orders}">
                <div class="order-card">
                    <div class="order-card-img-wrap">
                        <img src="${pageContext.request.contextPath}/assets/images/uploads/${o.productImage}"
                             alt="${o.productName}" class="order-thumb"
                             onerror="this.style.display='none'">
                    </div>

                    <div class="order-card-body">
                        <div class="order-card-top">
                            <div>
                                <h3 class="order-product-name">${o.productName}</h3>
                                <p class="order-meta">Order #${o.id}</p>
                            </div>
                            <span class="badge badge-${o.status} badge-lg">${o.status}</span>
                        </div>

                        <div class="order-card-details">
                            <div class="order-detail-item">
                                <span class="order-detail-label">Quantity</span>
                                <span class="order-detail-value">${o.quantity} pcs</span>
                            </div>
                            <div class="order-detail-item">
                                <span class="order-detail-label">Total</span>
                                <span class="order-detail-value order-price">
                                    Rs. <fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/>
                                </span>
                            </div>
                            <div class="order-detail-item">
                                <span class="order-detail-label">Delivery Address</span>
                                <span class="order-detail-value">${o.address}</span>
                            </div>
                            <div class="order-detail-item">
                                <span class="order-detail-label">Ordered On</span>
                                <span class="order-detail-value text-muted">${o.createdAt}</span>
                            </div>
                        </div>

                        <c:if test="${o.status == 'pending'}">
                            <div class="order-card-actions">
                                <a href="${pageContext.request.contextPath}/order?action=cancel&id=${o.id}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to cancel this order?')">
                                    Cancel Order
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

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