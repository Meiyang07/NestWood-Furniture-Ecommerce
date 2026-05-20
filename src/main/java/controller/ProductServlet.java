package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import util.FileUploadUtil;
import util.ValidationUtil;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Admin CRUD operations for furniture products
 */
@WebServlet("/admin/products")
@MultipartConfig(maxFileSize = 2097152)
public class ProductServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ProductServlet.class.getName());

    private final ProductDAO productDAO = new ProductDAO();

    // GET - list, add form, edit form, delete, search

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add" -> {
                    req.setAttribute("categories", productDAO.getAllCategories());
                    req.getRequestDispatcher("/admin/product-add.jsp").forward(req, resp);
                }
                case "edit" -> {
                    String idStr = req.getParameter("id");
                    if (ValidationUtil.isEmpty(idStr)) {
                        resp.sendRedirect(req.getContextPath() + "/admin/products?action=list");
                        return;
                    }
                    int id = Integer.parseInt(idStr.trim());
                    Product product = productDAO.findById(id);
                    if (product == null) {
                        req.setAttribute("error", "Product not found.");
                        req.setAttribute("products", productDAO.getAllProducts());
                        req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
                        return;
                    }
                    req.setAttribute("product",    product);
                    req.setAttribute("categories", productDAO.getAllCategories());
                    req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
                }
                case "delete" -> {
                    String idStr = req.getParameter("id");
                    if (ValidationUtil.isEmpty(idStr)) {
                        resp.sendRedirect(req.getContextPath() + "/admin/products?action=list");
                        return;
                    }
                    productDAO.deleteProduct(Integer.parseInt(idStr.trim()));
                    resp.sendRedirect(req.getContextPath() + "/admin/products?action=list&deleted=true");
                }
                case "search" -> {
                    String keyword = req.getParameter("keyword");
                    if (ValidationUtil.isEmpty(keyword)) {
                        resp.sendRedirect(req.getContextPath() + "/admin/products?action=list");
                        return;
                    }
                    List<Product> results = productDAO.searchProducts(keyword.trim());
                    req.setAttribute("products", results);
                    req.setAttribute("keyword",  ValidationUtil.escapeHtml(keyword));
                    req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
                }
                default -> {
                    String searchQuery = req.getParameter("search");
                    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                        // Search products by name
                        List<Product> results = productDAO.searchProducts(searchQuery.trim());
                        req.setAttribute("products", results);
                        req.setAttribute("searchQuery", ValidationUtil.escapeHtml(searchQuery));
                    } else {
                        // Show all products
                        req.setAttribute("products", productDAO.getAllProducts());
                    }
                    req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
                }
            }
        } catch (NumberFormatException e) {
            // Invalid product ID
            req.setAttribute("error", "Invalid product ID.");
            try {
                req.setAttribute("products", productDAO.getAllProducts());
            } catch (Exception dbEx) {
                LOG.log(Level.WARNING, "Could not reload product list after NumberFormatException", dbEx);
            }
            req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);

        } catch (Exception e) {
            // Log error and show error page
            LOG.log(Level.SEVERE, "Unexpected error in ProductServlet.doGet", e);
            req.setAttribute("error", "A server error occurred. Please try again.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    // POST - add or edit product

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                handleAdd(req, resp);
            } else if ("edit".equals(action)) {
                handleEdit(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?action=list");
            }
        } catch (Exception e) {
            // Log error and show error page
            LOG.log(Level.SEVERE, "Unexpected error in ProductServlet.doPost", e);
            req.setAttribute("error", "A server error occurred. Please try again.");
            req.getRequestDispatcher("/error/500.jsp").forward(req, resp);
        }
    }

    // Handle adding a new product

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        String name        = ValidationUtil.sanitize(req.getParameter("name"));
        String categoryId  = req.getParameter("categoryId");
        String description = ValidationUtil.sanitize(req.getParameter("description"));
        String price       = req.getParameter("price");
        String stock       = req.getParameter("stock");
        String status      = req.getParameter("status");

        String validationError = validateProductFields(name, categoryId, price, stock);
        if (validationError != null) {
            // Show error on add form
            forwardAddError(req, resp, validationError);
            return;
        }

        // Validate and save uploaded image
        String imageFileName = validateAndSaveImage(req, null);
        if (imageFileName == null) {
            forwardAddError(req, resp, "Product image must be an image file (JPG, PNG, etc.).");
            return;
        }

        Product p = new Product();
        p.setCategoryId(Integer.parseInt(categoryId.trim()));
        p.setName(name);
        p.setDescription(description);
        p.setPrice(Double.parseDouble(price.trim()));
        p.setStock(Integer.parseInt(stock.trim()));
        p.setImage(imageFileName);
        p.setStatus(status != null ? status : "active");

        productDAO.insertProduct(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products?action=list&added=true");
    }

    // Handle editing an existing product

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        String idStr       = req.getParameter("id");
        String name        = ValidationUtil.sanitize(req.getParameter("name"));
        String categoryId  = req.getParameter("categoryId");
        String description = ValidationUtil.sanitize(req.getParameter("description"));
        String price       = req.getParameter("price");
        String stock       = req.getParameter("stock");
        String status      = req.getParameter("status");
        String existingImg = req.getParameter("existingImage");

        if (ValidationUtil.isEmpty(idStr)) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=list");
            return;
        }
        int id = Integer.parseInt(idStr.trim());

        String validationError = validateProductFields(name, categoryId, price, stock);
        if (validationError != null) {
            // Show error on edit form
            forwardEditError(req, resp, id, validationError);
            return;
        }

        // Validate and save uploaded image (or keep existing)
        String imageFileName = validateAndSaveImage(req, existingImg);
        if (imageFileName == null) {
            forwardEditError(req, resp, id, "Product image must be an image file (JPG, PNG, etc.).");
            return;
        }

        Product p = new Product();
        p.setId(id);
        p.setCategoryId(Integer.parseInt(categoryId.trim()));
        p.setName(name);
        p.setDescription(description);
        p.setPrice(Double.parseDouble(price.trim()));
        p.setStock(Integer.parseInt(stock.trim()));
        p.setImage(imageFileName);
        p.setStatus(status != null ? status : "active");

        productDAO.updateProduct(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products?action=list&updated=true");
    }

    // Validate product fields
    private String validateProductFields(String name, String categoryId,
                                         String price, String stock) {
        if (ValidationUtil.isEmpty(name)) {
            return "Product name is required.";
        }
        if (!ValidationUtil.maxLength(name, 150)) {
            return "Product name must be 150 characters or fewer.";
        }
        if (ValidationUtil.isEmpty(categoryId)) {
            return "Please select a category.";
        }
        if (!ValidationUtil.isValidPrice(price)) {
            return "Price must be a positive number (e.g. 4999.99).";
        }
        if (!ValidationUtil.isValidStock(stock)) {
            return "Stock must be a whole number between 0 and 99,999.";
        }
        return null;
    }

    // Validate and save uploaded image file
    private String validateAndSaveImage(HttpServletRequest req, String fallback)
            throws Exception {

        String defaultFallback = (fallback != null) ? fallback : "product_default.png";

        Part imagePart = req.getPart("image");
        if (imagePart == null || imagePart.getSize() == 0) {
            return defaultFallback;   // no file uploaded
        }

        String contentType = imagePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return null;              // invalid file type
        }

        String uploadFolder = getServletContext().getRealPath("/assets/images/uploads/");
        return FileUploadUtil.saveFile(imagePart, uploadFolder);
    }

    // Forward to add form with error
    private void forwardAddError(HttpServletRequest req, HttpServletResponse resp,
                                 String errorMsg)
            throws Exception {
        req.setAttribute("error", errorMsg);
        req.setAttribute("categories", productDAO.getAllCategories());
        req.getRequestDispatcher("/admin/product-add.jsp").forward(req, resp);
    }

    // Forward to edit form with error
    private void forwardEditError(HttpServletRequest req, HttpServletResponse resp,
                                  int productId, String errorMsg)
            throws Exception {
        req.setAttribute("error", errorMsg);
        req.setAttribute("product",    productDAO.findById(productId));
        req.setAttribute("categories", productDAO.getAllCategories());
        req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
    }
}
