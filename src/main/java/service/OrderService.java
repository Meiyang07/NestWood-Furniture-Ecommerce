package service;

import dao.OrderDAO;
import dao.ProductDAO;
import model.Order;
import model.Product;

import java.sql.SQLException;
import java.util.List;

/**
 * Business logic for orders - handles validation, pricing, and status updates
 */
public class OrderService {

    private final OrderDAO   orderDAO   = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();

    // Place a new order
    public boolean placeOrder(int userId, int productId, int quantity, String address)
            throws SQLException {

        // Check if address is valid
        if (address == null || address.trim().isEmpty()) {
            throw new IllegalArgumentException("Delivery address is required.");
        }
        if (address.trim().length() < 5) {
            throw new IllegalArgumentException("Please enter a complete delivery address.");
        }

        // Make sure product exists and is available
        Product product = productDAO.findById(productId);
        if (product == null || !"active".equalsIgnoreCase(product.getStatus())) {
            throw new IllegalArgumentException("This product is no longer available.");
        }

        // Check quantity is valid and in stock
        if (quantity < 1) {
            throw new IllegalArgumentException("Quantity must be at least 1.");
        }
        if (quantity > product.getStock()) {
            throw new IllegalArgumentException(
                    "Only " + product.getStock() + " item(s) left in stock.");
        }

        // Create the order - price comes from database, not user input
        Order order = new Order();
        order.setUserId(userId);
        order.setProductId(productId);
        order.setQuantity(quantity);
        order.setTotalPrice(product.getPrice() * quantity);
        order.setAddress(address.trim());

        return orderDAO.placeOrder(order);
    }

    // Get orders for a specific user
    public List<Order> getOrdersByUser(int userId) throws SQLException {
        return orderDAO.getOrdersByUser(userId);
    }

    // Cancel an order - only works if it's the user's order and status is pending
    public boolean cancelOrder(int orderId, int userId) throws SQLException {
        if (orderId <= 0 || userId <= 0) {
            throw new IllegalArgumentException("Invalid order or user.");
        }
        return orderDAO.cancelOrder(orderId, userId);
    }

    // Admin: get all orders
    public List<Order> getAllOrders() throws SQLException {
        return orderDAO.getAllOrders();
    }

    // Admin: update order status
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        if (orderId <= 0) {
            throw new IllegalArgumentException("Invalid order ID.");
        }

        // Only allow valid status values
        if (!isValidStatus(status)) {
            throw new IllegalArgumentException(
                    "Invalid status. Allowed: pending, confirmed, shipped, delivered, cancelled.");
        }

        return orderDAO.updateStatus(orderId, status);
    }

    // Helper to check if status is valid

    private boolean isValidStatus(String status) {
        if (status == null) return false;
        switch (status.toLowerCase()) {
            case "pending":
            case "confirmed":
            case "shipped":
            case "delivered":
            case "cancelled":
                return true;
            default:
                return false;
        }
    }
}
