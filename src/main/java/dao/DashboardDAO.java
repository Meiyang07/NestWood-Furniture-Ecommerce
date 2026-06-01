package dao;

import model.DashboardStats;
import model.Order;
import util.DBConnection;

import java.sql.*;
import java.util.*;

public class DashboardDAO {

    /** Existing: summary stats for stat cards */
    public DashboardStats getStats() throws SQLException {
        DashboardStats stats = new DashboardStats();
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE role='user'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setTotalUsers(rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM products");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setTotalProducts(rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM products WHERE status='active'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setActiveProducts(rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM orders");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setTotalOrders(rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM orders WHERE status='pending'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setPendingOrders(rs.getInt(1));
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COALESCE(SUM(total_price),0) FROM orders WHERE status='delivered'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.setTotalRevenue(rs.getDouble(1));
            }
        }
        return stats;
    }

    /** Existing: 5 most recent orders */
    public List<Order> getRecentOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = """
            SELECT o.id, u.full_name AS user_name, p.name AS product_name,
                   o.total_price, o.status, o.created_at
            FROM orders o
            JOIN users u    ON o.user_id    = u.id
            JOIN products p ON o.product_id = p.id
            ORDER BY o.created_at ASC
            LIMIT 5
            """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserName(rs.getString("user_name"));
                o.setProductName(rs.getString("product_name"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setStatus(rs.getString("status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(o);
            }
        }
        return list;
    }

    /** Chart 1: product count per category */
    public Map<String, Integer> getProductsByCategory() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT c.name, COUNT(p.id) AS cnt " +
                "FROM categories c " +
                "LEFT JOIN products p ON p.category_id = c.id " +
                "GROUP BY c.id, c.name ORDER BY cnt DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("name"), rs.getInt("cnt"));
        }
        return map;
    }

    /** Chart 2: order count per status */
    public Map<String, Integer> getOrdersByStatus() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT status, COUNT(*) AS cnt FROM orders GROUP BY status ORDER BY cnt DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("status"), rs.getInt("cnt"));
        }
        return map;
    }

    /** Chart 3: delivered revenue per month, last 6 months */
    public Map<String, Double> getMonthlySales() throws SQLException {
        Map<String, Double> map = new LinkedHashMap<>();
        String sql = "SELECT DATE_FORMAT(created_at, '%b %Y') AS month, " +
                "COALESCE(SUM(total_price), 0) AS revenue " +
                "FROM orders WHERE status = 'delivered' " +
                "AND created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH) " +
                "GROUP BY DATE_FORMAT(created_at, '%Y-%m') " +
                "ORDER BY MIN(created_at) ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("month"), rs.getDouble("revenue"));
        }
        return map;
    }

    /** Chart 4: products with stock <= 5 */
    public Map<String, Integer> getLowStockProducts() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT name, stock FROM products WHERE stock <= 5 ORDER BY stock ASC LIMIT 8";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getString("name"), rs.getInt("stock"));
        }
        return map;
    }
}