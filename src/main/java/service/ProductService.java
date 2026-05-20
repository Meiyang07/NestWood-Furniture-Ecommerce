package service;

import dao.ProductDAO;
import model.Category;
import model.Product;

import java.sql.SQLException;
import java.util.List;

/**
 * Business logic for products - handles CRUD operations and validation
 */
public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();

    // Get all active products for browse page
    public List<Product> getActiveProducts() throws SQLException {
        return productDAO.getActiveProducts();
    }

    // Get all products including inactive ones (admin only)
    public List<Product> getAllProducts() throws SQLException {
        return productDAO.getAllProducts();
    }

    // Get a single product by ID
    public Product getProductById(int id) throws SQLException {
        return productDAO.findById(id);
    }

    // Search products by keyword
    public List<Product> searchProducts(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return productDAO.getActiveProducts();
        }
        return productDAO.searchProducts(keyword.trim());
    }

    // Get all categories for dropdowns
    public List<Category> getAllCategories() throws SQLException {
        return productDAO.getAllCategories();
    }

    // Add a new product
    public boolean addProduct(Product p) throws SQLException {
        validateProduct(p);
        return productDAO.insertProduct(p);
    }

    // Update an existing product
    public boolean updateProduct(Product p) throws SQLException {
        validateProduct(p);
        return productDAO.updateProduct(p);
    }

    // Delete a product
    public boolean deleteProduct(int id) throws SQLException {
        if (id <= 0) throw new IllegalArgumentException("Invalid product ID.");
        return productDAO.deleteProduct(id);
    }

    // Validate product data before saving

    private void validateProduct(Product p) {
        if (p.getName() == null || p.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Product name is required.");
        }
        if (p.getPrice() <= 0) {
            throw new IllegalArgumentException("Price must be greater than zero.");
        }
        if (p.getStock() < 0) {
            throw new IllegalArgumentException("Stock cannot be negative.");
        }
        if (p.getCategoryId() <= 0) {
            throw new IllegalArgumentException("Please select a valid category.");
        }
    }
}
