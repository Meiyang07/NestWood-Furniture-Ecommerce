package model;

/**
 * DashboardStats — holds aggregated data for the admin dashboard.
 * Populated by DashboardDAO using SQL COUNT, SUM, AVG queries.
 */
public class DashboardStats {

    private int    totalUsers;
    private int    totalProducts;
    private int    totalOrders;
    private double totalRevenue;    // SUM of delivered order totals
    private int    pendingOrders;
    private int    activeProducts;

    // Getters and Setters
    public int    getTotalUsers()               { return totalUsers; }
    public void   setTotalUsers(int t)          { this.totalUsers = t; }

    public int    getTotalProducts()            { return totalProducts; }
    public void   setTotalProducts(int t)       { this.totalProducts = t; }

    public int    getTotalOrders()              { return totalOrders; }
    public void   setTotalOrders(int t)         { this.totalOrders = t; }

    public double getTotalRevenue()             { return totalRevenue; }
    public void   setTotalRevenue(double t)     { this.totalRevenue = t; }

    public int    getPendingOrders()            { return pendingOrders; }
    public void   setPendingOrders(int p)       { this.pendingOrders = p; }

    public int    getActiveProducts()           { return activeProducts; }
    public void   setActiveProducts(int a)      { this.activeProducts = a; }
}