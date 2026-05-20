package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection — provides a MySQL connection using JDBC.
 * Uses a static method so every DAO can call DBConnection.getConnection()
 */
public class DBConnection {

    // Change these if your MySQL settings are different
    private static final String URL      = "jdbc:mysql://localhost:3306/nestwood_db?useSSL=false&serverTimezone=UTC";
    private static final String USER     = "root";
    private static final String PASSWORD = "";

    static {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        }
    }

    /**
     * Returns a new Connection to the database.
     * Always close the connection after use (try-with-resources recommended).
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}