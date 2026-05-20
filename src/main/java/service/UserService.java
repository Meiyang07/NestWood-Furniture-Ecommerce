package service;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

/**
 * Business logic for user accounts - handles registration, login, and profile updates
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    // Register a new user
    public boolean registerUser(User user, String plainPassword) throws SQLException {
        // Check basic fields
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required.");
        }
        if (user.getEmail() == null || !user.getEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            throw new IllegalArgumentException("Please enter a valid email address.");
        }
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) {
            throw new IllegalArgumentException("Phone number is required.");
        }
        if (plainPassword == null || plainPassword.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters.");
        }

        // Make sure email and phone aren't already taken
        if (userDAO.emailExists(user.getEmail())) {
            throw new IllegalArgumentException("An account with this email already exists.");
        }
        if (userDAO.phoneExists(user.getPhone())) {
            throw new IllegalArgumentException("An account with this phone number already exists.");
        }

        // Hash password and set default role
        user.setPassword(PasswordUtil.hashPassword(plainPassword));
        user.setRole("user");

        return userDAO.insertUser(user);
    }

    // Login with email and password
    public User login(String email, String plainPassword) throws SQLException {
        if (email == null || plainPassword == null) return null;

        User user = userDAO.findByEmail(email.trim().toLowerCase());
        if (user == null) return null;

        // Check if password matches
        if (!PasswordUtil.verifyPassword(plainPassword, user.getPassword())) return null;

        return user;
    }

    // Get user by ID
    public User getUserById(int id) throws SQLException {
        return userDAO.findById(id);
    }

    // Update user profile (name, phone, avatar)
    public boolean updateProfile(User user) throws SQLException {
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be empty.");
        }
        return userDAO.updateProfile(user);
    }

    // Change user password
    public boolean changePassword(int userId, String currentPlain, String newPlain) throws SQLException {
        if (newPlain == null || newPlain.length() < 6) {
            throw new IllegalArgumentException("New password must be at least 6 characters.");
        }

        User user = userDAO.findById(userId);
        if (user == null) throw new IllegalArgumentException("User not found.");

        // Verify current password is correct
        if (!PasswordUtil.verifyPassword(currentPlain, user.getPassword())) {
            throw new IllegalArgumentException("Current password is incorrect.");
        }

        // Hash new password and update
        return userDAO.updatePassword(userId, PasswordUtil.hashPassword(newPlain));
    }

    // Get all users (admin only)
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }
}
