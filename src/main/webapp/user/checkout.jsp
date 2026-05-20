<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout — NestWood</title>
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
            <p class="section-label">Almost There</p>
            <h1 class="page-title">Checkout</h1>
        </div>
        <a href="${pageContext.request.contextPath}/user/browse" class="btn btn-outline">← Continue Shopping</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="checkout-layout">

        <%-- ── Order Summary Card ─────────────────────────────── --%>
        <div class="checkout-summary-card">
            <h2 class="checkout-section-title">Order Summary</h2>

            <div class="checkout-product-row">
                <div class="checkout-product-img-wrap">
                    <img src="${pageContext.request.contextPath}/assets/images/uploads/${product.image}"
                         alt="${product.name}" class="checkout-product-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="checkout-product-meta">
                    <span class="category-tag">${product.categoryName}</span>
                    <h3 class="checkout-product-name">${product.name}</h3>
                    <p class="checkout-unit-price">
                        Unit Price: <strong>Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></strong>
                    </p>
                    <p class="checkout-stock-info">
                        <c:choose>
                            <c:when test="${product.stock > 0}">
                                <span class="stock-dot stock-dot--in"></span>&nbsp;${product.stock} in stock
                            </c:when>
                            <c:otherwise>
                                <span class="stock-dot stock-dot--out"></span>&nbsp;Out of stock
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <div class="checkout-total-row">
                <span>Total Amount</span>
                <span class="checkout-total-price" id="totalDisplay">
                    Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                </span>
            </div>

            <div class="checkout-trust-badges">
                <span class="trust-badge"><i class="fas fa-shield-alt" aria-hidden="true" style="color: var(--gold);"></i> Secure Checkout</span>
                <span class="trust-badge"><i class="fas fa-truck" aria-hidden="true" style="color: var(--gold);"></i> Fast Delivery</span>
                <span class="trust-badge"><i class="fas fa-award" aria-hidden="true" style="color: var(--gold);"></i> Quality Guarantee</span>
            </div>
        </div>

        <%-- ── Order Form Card ────────────────────────────────── --%>
        <div class="checkout-form-card">
            <h2 class="checkout-section-title">Delivery Details</h2>

            <form action="${pageContext.request.contextPath}/order" method="post" id="checkoutForm">
                <input type="hidden" name="productId" value="${product.id}">

                <div class="form-group">
                    <label class="form-label">Quantity</label>
                    <div class="qty-stepper">
                        <button type="button" class="qty-btn" id="qtyMinus">−</button>
                        <input type="number" name="quantity" id="qtyInput"
                               min="1" max="${product.stock}" value="1"
                               class="qty-field" required>
                        <button type="button" class="qty-btn" id="qtyPlus">+</button>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Delivery Address <span class="required">*</span></label>
                    <textarea name="address" rows="4"
                              placeholder="Enter your full delivery address — street, city, district..."
                              class="form-textarea" required></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Customer Name</label>
                    <input type="text" value="${sessionScope.loggedUser.fullName}"
                           class="form-input" disabled>
                </div>

                <div class="checkout-form-actions">
                    <button type="submit" class="btn btn-gold btn-lg btn-block">
                        <i class="fas fa-check-circle" aria-hidden="true"></i> Place Order
                    </button>
                    <a href="${pageContext.request.contextPath}/user/browse"
                       class="btn btn-outline btn-block" style="margin-top:0.75rem">Cancel</a>
                </div>
            </form>
        </div>
    </div>

</main>

<footer class="site-footer">
    <div class="footer-inner">
        <p class="footer-brand"><i class="fas fa-tree" aria-hidden="true"></i> NestWood</p>
        <p>© 2025 NestWood · Premium Furniture E-Commerce · Nepal</p>
    </div>
</footer>

<script>
    const pricePerUnit = ${product.price};
    const qtyInput     = document.getElementById('qtyInput');
    const totalDisplay = document.getElementById('totalDisplay');
    const maxStock     = ${product.stock};
    const qtyMinus     = document.getElementById('qtyMinus');
    const qtyPlus      = document.getElementById('qtyPlus');

    function updateTotal() {
        const qty   = Math.max(1, Math.min(parseInt(qtyInput.value) || 1, maxStock));
        qtyInput.value = qty;
        const total = (pricePerUnit * qty).toLocaleString('en-IN', { minimumFractionDigits: 2 });
        totalDisplay.textContent = 'Rs. ' + total;
    }

    qtyInput.addEventListener('input', updateTotal);
    qtyMinus.addEventListener('click', function () {
        qtyInput.value = Math.max(1, parseInt(qtyInput.value) - 1);
        updateTotal();
    });
    qtyPlus.addEventListener('click', function () {
        qtyInput.value = Math.min(maxStock, parseInt(qtyInput.value) + 1);
        updateTotal();
    });
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>