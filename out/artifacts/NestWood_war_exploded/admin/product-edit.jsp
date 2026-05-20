<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product — NestWood Admin</title>
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
            <h1 class="page-title">Edit Product</h1>
        </div>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">← Back to Products</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">⚠ ${error}</div>
    </c:if>

    <div class="admin-form-layout">

        <div class="admin-form-main">
            <form action="${pageContext.request.contextPath}/admin/products"
                  method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="${product.id}">
                <input type="hidden" name="existingImage" value="${product.image}">

                <%-- Basic Info --%>
                <div class="form-section">
                    <div class="form-section-header">
                        <span class="form-section-icon" style="color: #C8A96E;"><i class="fas fa-info-circle" aria-hidden="true"></i></span>
                        <h3>Basic Information</h3>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Product Name <span class="required">*</span></label>
                            <input type="text" name="name" value="${product.name}"
                                   class="form-input" required>
                        </div>
                        <div class="form-group" style="max-width: 250px;">
                            <label class="form-label">Category <span class="required">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}"
                                        ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-textarea" rows="5">${product.description}</textarea>
                    </div>
                </div>

                <%-- Pricing & Stock --%>
                <div class="form-section">
                    <div class="form-section-header">
                        <span class="form-section-icon" style="color: #C8A96E;"><i class="fas fa-tags" aria-hidden="true"></i></span>
                        <h3>Pricing & Inventory</h3>
                    </div>
                    <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group" style="margin-bottom: 0;">
                            <label class="form-label">Price (Rs.) <span class="required">*</span></label>
                            <div class="input-prefix-wrap" style="position: relative;">
                                <span class="input-prefix" style="position: absolute; left: 14px; top: 50%; transform: translateY(-50%); font-weight: 600; color: #5A4A3A; pointer-events: none; z-index: 1;">Rs.</span>
                                <input type="number" name="price" value="${product.price}"
                                       class="form-input form-input--prefixed" style="padding-left: 48px;" step="1000" min="1000" required>
                            </div>
                        </div>
                        <div class="form-group" style="margin-bottom: 0;">
                            <label class="form-label">Stock Quantity <span class="required">*</span></label>
                            <input type="number" name="stock" value="${product.stock}"
                                   class="form-input" min="0" required>
                        </div>
                    </div>
                    <div class="form-group" style="max-width: 250px;">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="active"   ${product.status == 'active'   ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${product.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                </div>

                <%-- Image --%>
                <div class="form-section">
                    <div class="form-section-header">
                        <span class="form-section-icon" style="color: #C8A96E;"><i class="fas fa-images" aria-hidden="true"></i></span>
                        <h3>Product Image</h3>
                    </div>

                    <div class="edit-image-row">
                        <div class="edit-current-image">
                            <p class="form-label" style="margin-bottom:0.5rem">Current Image</p>
                            <img src="${pageContext.request.contextPath}/assets/images/uploads/${product.image}"
                                 alt="Current" class="edit-preview-img" id="currentImagePreview"
                                 onerror="this.style.display='none'">
                        </div>
                        <div class="edit-new-image">
                            <p class="form-label" style="margin-bottom:0.5rem">Replace Image</p>
                            <div class="image-upload-area image-upload-area--sm" id="editUploadArea">
                                <input type="file" name="image" accept="image/*"
                                       id="editImageInput" class="image-upload-input">
                                <div class="image-upload-placeholder" id="editPlaceholder">
                                    <p class="image-upload-icon" style="font-size:1.5rem"><i class="fas fa-cloud-upload-alt" aria-hidden="true"></i></p>
                                    <p class="image-upload-text" style="font-size:0.85rem">Click to replace</p>
                                    <p class="image-upload-hint">Leave blank to keep current</p>
                                </div>
                                <img id="editPreview" class="image-preview-thumb" style="display:none" alt="New">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions-bar">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-gold btn-lg"><i class="fas fa-save" aria-hidden="true"></i> Update Product</button>
                </div>

            </form>
        </div>

        <%-- Side info --%>
        <div class="admin-form-side">
            <div class="form-tips-card">
                <h4 class="form-tips-title"><i class="fas fa-info-circle" aria-hidden="true" style="color: #C8A96E;"></i> Product Info</h4>
                <div class="product-info-summary">
                    <p><span class="info-label">ID:</span> <strong>${product.id}</strong></p>
                    <p><span class="info-label">Name:</span> ${product.name}</p>
                    <p><span class="info-label">Category:</span> ${product.categoryName}</p>
                    <p><span class="info-label">Status:</span>
                        <span class="badge badge-${product.status}">${product.status}</span>
                    </p>
                </div>
            </div>
        </div>

    </div>

</main>

<script>
    const editInput   = document.getElementById('editImageInput');
    const editPreview = document.getElementById('editPreview');
    const editPlaceholder = document.getElementById('editPlaceholder');
    const editArea    = document.getElementById('editUploadArea');

    editInput.addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                editPreview.src = e.target.result;
                editPreview.style.display = 'block';
                editPlaceholder.style.display = 'none';
                document.getElementById('currentImagePreview').style.opacity = '0.4';
            };
            reader.readAsDataURL(file);
        }
    });

    editArea.addEventListener('click', function () {
        editInput.click();
    });
    
    // Format price input to always show two decimal places
    const priceInput = document.querySelector('input[name="price"]');
    if (priceInput) {
        // Format on page load
        if (priceInput.value) {
            priceInput.value = parseFloat(priceInput.value).toFixed(2);
        }
        // Format on change
        priceInput.addEventListener('change', function() {
            if (this.value) {
                this.value = parseFloat(this.value).toFixed(2);
            }
        });
    }
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>