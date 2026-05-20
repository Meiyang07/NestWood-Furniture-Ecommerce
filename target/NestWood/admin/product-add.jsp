<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product — NestWood Admin</title>
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
            <h1 class="page-title">Add New Product</h1>
        </div>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline">← Back to Products</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">⚠ ${error}</div>
    </c:if>

    <div class="admin-form-layout">

        <%-- Main Form Card --%>
        <div class="admin-form-main">
            <form action="${pageContext.request.contextPath}/admin/products"
                  method="post" enctype="multipart/form-data" id="addProductForm">
                <input type="hidden" name="action" value="add">

                <%-- Basic Info Section --%>
                <div class="form-section">
                    <div class="form-section-header">
                        <span class="form-section-icon" style="color: #C8A96E;"><i class="fas fa-info-circle" aria-hidden="true"></i></span>
                        <h3>Basic Information</h3>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Product Name <span class="required">*</span></label>
                            <input type="text" name="name" class="form-input"
                                   placeholder="e.g. Luxury 3-Seater Sofa" required>
                        </div>
                        <div class="form-group" style="max-width: 250px;">
                            <label class="form-label">Category <span class="required">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">— Select Category —</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-textarea" rows="5"
                                  placeholder="Describe the product — materials, dimensions, features..."></textarea>
                    </div>
                </div>

                <%-- Pricing & Stock Section --%>
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
                                <input type="number" name="price" class="form-input form-input--prefixed" style="padding-left: 48px;"
                                       step="1000" min="1000" placeholder="1000.00" required>
                            </div>
                        </div>
                        <div class="form-group" style="margin-bottom: 0;">
                            <label class="form-label">Stock Quantity <span class="required">*</span></label>
                            <input type="number" name="stock" class="form-input"
                                   min="0" placeholder="0" required>
                        </div>
                    </div>
                    <div class="form-group" style="max-width: 250px;">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </div>

                <%-- Image Upload Section --%>
                <div class="form-section">
                    <div class="form-section-header">
                        <span class="form-section-icon" style="color: #C8A96E;"><i class="fas fa-images" aria-hidden="true"></i></span>
                        <h3>Product Image</h3>
                    </div>
                    <div class="image-upload-area" id="imageUploadArea">
                        <input type="file" name="image" accept="image/*"
                               id="productImageInput" class="image-upload-input">
                        <div class="image-upload-placeholder" id="uploadPlaceholder">
                            <p class="image-upload-icon"><i class="fas fa-cloud-upload-alt" aria-hidden="true"></i></p>
                            <p class="image-upload-text">Click or drag to upload an image</p>
                            <p class="image-upload-hint">JPG, PNG, WEBP — Max 2MB</p>
                        </div>
                        <img id="imagePreview" class="image-preview-thumb" style="display:none" alt="Preview">
                    </div>
                </div>

                <%-- Form Actions --%>
                <div class="form-actions-bar">
                    <a href="${pageContext.request.contextPath}/admin/products"
                       class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-gold btn-lg">
                        <i class="fas fa-save" aria-hidden="true"></i> Save Product
                    </button>
                </div>

            </form>
        </div>

        <%-- Side Tips Card --%>
        <div class="admin-form-side">
            <div class="form-tips-card">
                <h4 class="form-tips-title"><i class="fas fa-question-circle" aria-hidden="true" style="color: #C8A96E;"></i> Tips</h4>
                <ul class="form-tips-list">
                    <li>Use a clear, descriptive product name</li>
                    <li>Write a detailed description with dimensions and materials</li>
                    <li>Upload a high-quality image (min 800×800px)</li>
                    <li>Set an accurate stock count to avoid overselling</li>
                    <li>Set status to <strong>Inactive</strong> if not ready to sell</li>
                </ul>
            </div>
        </div>

    </div><%-- end admin-form-layout --%>

</main>

<script>
    // Image preview on file select
    const imageInput   = document.getElementById('productImageInput');
    const imagePreview = document.getElementById('imagePreview');
    const placeholder  = document.getElementById('uploadPlaceholder');
    const uploadArea   = document.getElementById('imageUploadArea');

    imageInput.addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
                placeholder.style.display  = 'none';
            };
            reader.readAsDataURL(file);
        }
    });

    uploadArea.addEventListener('click', function () {
        imageInput.click();
    });

    // Drag and drop
    uploadArea.addEventListener('dragover', function (e) {
        e.preventDefault();
        this.classList.add('drag-over');
    });
    uploadArea.addEventListener('dragleave', function () {
        this.classList.remove('drag-over');
    });
    uploadArea.addEventListener('drop', function (e) {
        e.preventDefault();
        this.classList.remove('drag-over');
        const file = e.dataTransfer.files[0];
        if (file && file.type.startsWith('image/')) {
            imageInput.files = e.dataTransfer.files;
            const reader = new FileReader();
            reader.onload = function (ev) {
                imagePreview.src = ev.target.result;
                imagePreview.style.display = 'block';
                placeholder.style.display  = 'none';
            };
            reader.readAsDataURL(file);
        }
    });
    
    // Format price input to always show two decimal places
    const priceInput = document.querySelector('input[name="price"]');
    if (priceInput) {
        // Set initial value to 1000.00
        priceInput.value = '1000.00';
        
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