package model;

import java.sql.Timestamp;

/**
 * Order model — maps to the 'orders' table.
 * A user places an order for a product.
 */
public class Order {

    private int       id;
    private int       userId;
    private int       productId;
    private String    productName;   // for display (joined from products)
    private String    productImage;  // for display
    private String    userName;      // for admin display
    private int       quantity;
    private double    totalPrice;
    private String    address;
    private String    status;        // pending, confirmed, shipped, delivered, cancelled
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Order() {}

    // Getters and Setters
    public int       getId()                   { return id; }
    public void      setId(int id)             { this.id = id; }

    public int       getUserId()               { return userId; }
    public void      setUserId(int u)          { this.userId = u; }

    public int       getProductId()            { return productId; }
    public void      setProductId(int p)       { this.productId = p; }

    public String    getProductName()          { return productName; }
    public void      setProductName(String p)  { this.productName = p; }

    public String    getProductImage()         { return productImage; }
    public void      setProductImage(String p) { this.productImage = p; }

    public String    getUserName()             { return userName; }
    public void      setUserName(String u)     { this.userName = u; }

    public int       getQuantity()             { return quantity; }
    public void      setQuantity(int q)        { this.quantity = q; }

    public double    getTotalPrice()           { return totalPrice; }
    public void      setTotalPrice(double t)   { this.totalPrice = t; }

    public String    getAddress()              { return address; }
    public void      setAddress(String a)      { this.address = a; }

    public String    getStatus()               { return status; }
    public void      setStatus(String s)       { this.status = s; }

    public Timestamp getCreatedAt()            { return createdAt; }
    public void      setCreatedAt(Timestamp t) { this.createdAt = t; }

    public Timestamp getUpdatedAt()            { return updatedAt; }
    public void      setUpdatedAt(Timestamp t) { this.updatedAt = t; }
}