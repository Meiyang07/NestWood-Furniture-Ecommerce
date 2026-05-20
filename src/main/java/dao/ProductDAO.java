package dao;

import model.Category;
import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Database operations for products table
 */
public class ProductDAO {

    // Add a new product

    public boolean insertProduct(Product p) throws SQLException {
        String sql = "INSERT INTO products (category_id, name, description, price, stock, image, status) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getImage() != null ? p.getImage() : "product_default.png");
            ps.setString(7, p.getStatus());
            return ps.executeUpdate() > 0;
        }
    }

    // Get all products with category names
    public List<Product> getAllProducts() throws SQLException {
        return queryProducts("SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id=c.id ORDER BY p.created_at DESC", null);
    }

    // Get only active products (for user browse page)
    public List<Product> getActiveProducts() throws SQLException {
        return queryProducts("SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id=c.id WHERE p.status='active' ORDER BY p.created_at DESC", null);
    }

    // Find product by ID

    public Product findById(int id) throws SQLException {
        String sql = "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id=c.id WHERE p.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // Search products by keyword in name, description, or category
    public List<Product> searchProducts(String keyword) throws SQLException {
        String sql = """
            SELECT p.*, c.name AS category_name
            FROM products p JOIN categories c ON p.category_id=c.id
            WHERE LOWER(p.name) LIKE LOWER(?) 
               OR LOWER(p.description) LIKE LOWER(?)
               OR LOWER(c.name) LIKE LOWER(?)
            ORDER BY 
                CASE 
                    WHEN LOWER(p.name) LIKE LOWER(?) THEN 1
                    WHEN LOWER(c.name) LIKE LOWER(?) THEN 2
                    ELSE 3
                END,
                p.created_at DESC
            """;
        
        List<Product> list = new ArrayList<>();
        String likePattern = "%" + keyword + "%";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Set parameters for WHERE clause
            ps.setString(1, likePattern);
            ps.setString(2, likePattern);
            ps.setString(3, likePattern);
            // Set parameters for ORDER BY clause (prioritize name matches)
            ps.setString(4, likePattern);
            ps.setString(5, likePattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // Update an existing product

    public boolean updateProduct(Product p) throws SQLException {
        String sql = "UPDATE products SET category_id=?, name=?, description=?, price=?, stock=?, image=?, status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getImage());
            ps.setString(7, p.getStatus());
            ps.setInt(8, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete a product

    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Get all categories for dropdown menus
    public List<Category> getAllCategories() throws SQLException {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name")));
            }
        }
        return list;
    }

    // Reusable query runner for product lists
    private List<Product> queryProducts(String sql, String likeParam) throws SQLException {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (likeParam != null) {
                ps.setString(1, likeParam);
                ps.setString(2, likeParam);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCategoryName(rs.getString("category_name"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setStock(rs.getInt("stock"));
        p.setImage(rs.getString("image"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    }
}