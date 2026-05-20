package model;

import java.sql.Timestamp;

/**
 * Product model — maps to the 'products' table.
 * This is the main CRUD entity for NestWood.
 */
public class Product {

    private int       id;
    private int       categoryId;
    private String    categoryName;   // for display only (joined from categories)
    private String    name;
    private String    description;
    private double    price;
    private int       stock;
    private String    image;
    private String    status;         // "active" or "inactive"
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product() {}

    // Getters and Setters
    public int       getId()                  { return id; }
    public void      setId(int id)            { this.id = id; }

    public int       getCategoryId()          { return categoryId; }
    public void      setCategoryId(int c)     { this.categoryId = c; }

    public String    getCategoryName()        { return categoryName; }
    public void      setCategoryName(String c){ this.categoryName = c; }

    public String    getName()                { return name; }
    public void      setName(String n)        { this.name = n; }

    public String    getDescription()         { return description; }
    public void      setDescription(String d) { this.description = d; }

    public double    getPrice()               { return price; }
    public void      setPrice(double p)       { this.price = p; }

    public int       getStock()               { return stock; }
    public void      setStock(int s)          { this.stock = s; }

    public String    getImage()               { return image; }
    public void      setImage(String i)       { this.image = i; }

    public String    getStatus()              { return status; }
    public void      setStatus(String s)      { this.status = s; }

    public Timestamp getCreatedAt()           { return createdAt; }
    public void      setCreatedAt(Timestamp t){ this.createdAt = t; }

    public Timestamp getUpdatedAt()           { return updatedAt; }
    public void      setUpdatedAt(Timestamp t){ this.updatedAt = t; }
}