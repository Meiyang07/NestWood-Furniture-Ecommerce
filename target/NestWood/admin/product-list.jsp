<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products — NestWood Admin</title>
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
            <p class="section-label">Inventory</p>
            <h1 class="page-title">Product Management</h1>
        </div>
        <a href="${pageContext.request.contextPath}/admin/products?action=add"
           class="btn btn-gold">+ Add New Product</a>
    </div>

    <%-- Flash messages --%>
    <c:if test="${param.added == 'true'}">
        <div class="alert alert-success"><i class="fas fa-check" aria-hidden="true"></i> Product added successfully!</div>
    </c:if>
    <c:if test="${param.updated == 'true'}">
        <div class="alert alert-success"><i class="fas fa-check" aria-hidden="true"></i> Product updated successfully!</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert alert-info">Product has been deleted.</div>
    </c:if>

    <%-- Search bar --%>
    <div class="search-form">
        <form action="${pageContext.request.contextPath}/admin/products" method="get"
              style="display:flex;gap:0.75rem;flex:1;flex-wrap:wrap">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" value="${keyword}"
                   placeholder="Search by product name or category..."
                   style="flex:1;min-width:200px;padding:12px 16px;border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.9rem;background:var(--surface);font-family:var(--font)">
            <button type="submit" class="btn btn-primary">Search</button>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">Clear</a>
        </form>
    </div>

    <%-- Products Table --%>
    <div class="card">
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${products}" varStatus="s">
                    <tr>
                        <td class="text-muted">${p.id}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/assets/images/uploads/${p.image}"
                                 alt="${p.name}" class="table-thumb"
                                 onerror="this.style.display='none'">
                        </td>
                        <td><strong>${p.name}</strong></td>
                        <td>
                            <span class="category-tag">${p.categoryName}</span>
                        </td>
                        <td class="price-cell">Rs. <fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${p.stock > 10}">
                                    <span style="color:var(--success);font-weight:600">${p.stock}</span>
                                </c:when>
                                <c:when test="${p.stock > 0}">
                                    <span style="color:var(--warning-dark);font-weight:600">${p.stock}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:var(--danger);font-weight:600">0</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><span class="badge badge-${p.status}">${p.status}</span></td>
                        <td class="actions">
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}"
                               class="btn btn-sm btn-warning"><i class="fas fa-edit" aria-hidden="true"></i> Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Delete this product permanently?')"><i class="fas fa-trash" aria-hidden="true"></i> Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="8" class="text-center" style="padding:3rem;color:var(--text-muted)">
                            No products found.
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