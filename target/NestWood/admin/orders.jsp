<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders — NestWood Admin</title>
    <!-- Font Awesome 6.5.1 CDN -->
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-layout">

<jsp:include page="/WEB-INF/includes/admin-header.jsp"/>

<main class="admin-main">

    <div class="page-header">
        <div>
            <p class="section-label">Order Management</p>
            <h1 class="page-title">All Orders</h1>
        </div>
    </div>

    <c:if test="${param.updated == 'true'}">
        <div class="alert alert-success"><i class="fas fa-check" aria-hidden="true"></i> Order status updated successfully!</div>
    </c:if>

    <div class="card">
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Total</th>
                    <th>Delivery Address</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Update Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${allOrders}">
                    <tr>
                        <td class="order-id-cell">${o.id}</td>
                        <td><strong>${o.userName}</strong></td>
                        <td>${o.productName}</td>
                        <td>${o.quantity}</td>
                        <td class="price-cell">Rs. <fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/></td>
                        <td class="address-cell" title="${o.address}">${o.address}</td>
                        <td><span class="badge badge-${o.status}">${o.status}</span></td>
                        <td class="text-muted" style="font-size:0.82rem">${o.createdAt}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/order"
                                  method="get" class="inline-status-form">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="id" value="${o.id}">
                                <div class="inline-form-row">
                                    <select name="status" class="form-select-sm">
                                        <option value="pending"   ${o.status=='pending'   ? 'selected':''}>Pending</option>
                                        <option value="confirmed" ${o.status=='confirmed' ? 'selected':''}>Confirmed</option>
                                        <option value="shipped"   ${o.status=='shipped'   ? 'selected':''}>Shipped</option>
                                        <option value="delivered" ${o.status=='delivered' ? 'selected':''}>Delivered</option>
                                        <option value="cancelled" ${o.status=='cancelled' ? 'selected':''}>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty allOrders}">
                    <tr>
                        <td colspan="9" class="text-center" style="padding:3rem;color:var(--text-muted)">
                            No orders found.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>