package dao;

import model.Order;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Database operations for orders table
 */
public class OrderDAO {

    // Place a new order

    public boolean placeOrder(Order o) throws SQLException {
        String sql = "INSERT INTO orders (user_id, product_id, quantity, total_price, address, status) VALUES (?,?,?,?,?,'pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, o.getUserId());
            ps.setInt(2, o.getProductId());
            ps.setInt(3, o.getQuantity());
            ps.setDouble(4, o.getTotalPrice());
            ps.setString(5, o.getAddress());
            return ps.executeUpdate() > 0;
        }
    }

    // Get all orders for a specific user
    public List<Order> getOrdersByUser(int userId) throws SQLException {
        String sql = """
            SELECT o.*, p.name AS product_name, p.image AS product_image
            FROM orders o JOIN products p ON o.product_id=p.id
            WHERE o.user_id=?
            ORDER BY o.created_at DESC
            """;
        return fetchOrders(sql, userId);
    }

    // Get all orders with user and product info (admin view)
    public List<Order> getAllOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = """
            SELECT o.*, p.name AS product_name, u.full_name AS user_name
            FROM orders o
            JOIN products p ON o.product_id=p.id
            JOIN users u    ON o.user_id=u.id
            ORDER BY o.id ASC
            """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setProductName(rs.getString("product_name"));
                o.setUserName(rs.getString("user_name"));
                o.setQuantity(rs.getInt("quantity"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setAddress(rs.getString("address"));
                o.setStatus(rs.getString("status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(o);
            }
        }
        return list;
    }

    // Update order status (admin only)

    public boolean updateStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    // Cancel order (user can only cancel their own pending orders)

    public boolean cancelOrder(int orderId, int userId) throws SQLException {
        // Only pending orders can be cancelled by the user themselves
        String sql = "UPDATE orders SET status='cancelled' WHERE id=? AND user_id=? AND status='pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // Helper method to fetch orders with product info

    private List<Order> fetchOrders(String sql, int param) throws SQLException {
        List<Order> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt("id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setProductId(rs.getInt("product_id"));
                    o.setProductName(rs.getString("product_name"));
                    o.setProductImage(rs.getString("product_image"));
                    o.setQuantity(rs.getInt("quantity"));
                    o.setTotalPrice(rs.getDouble("total_price"));
                    o.setAddress(rs.getString("address"));
                    o.setStatus(rs.getString("status"));
                    o.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(o);
                }
            }
        }
        return list;
    }
}