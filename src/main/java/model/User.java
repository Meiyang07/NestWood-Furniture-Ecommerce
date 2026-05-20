package model;

import java.sql.Timestamp;

/**
 * User model — maps to the 'users' table.
 */
public class User {

    private int       id;
    private String    fullName;
    private String    email;
    private String    phone;
    private String    password;
    private String    role;       // "admin" or "user"
    private String    status;     // "pending", "approved", "rejected"
    private String    avatar;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public User() {}

    // Convenience constructor for registration
    public User(String fullName, String email, String phone, String password, String role) {
        this.fullName = fullName;
        this.email    = email;
        this.phone    = phone;
        this.password = password;
        this.role     = role;
    }

    // Getters and Setters
    public int       getId()        { return id; }
    public void      setId(int id)  { this.id = id; }

    public String    getFullName()              { return fullName; }
    public void      setFullName(String n)      { this.fullName = n; }

    public String    getEmail()                 { return email; }
    public void      setEmail(String e)         { this.email = e; }

    public String    getPhone()                 { return phone; }
    public void      setPhone(String p)         { this.phone = p; }

    public String    getPassword()              { return password; }
    public void      setPassword(String p)      { this.password = p; }

    public String    getRole()                  { return role; }
    public void      setRole(String r)          { this.role = r; }

    public String    getStatus()                { return status; }
    public void      setStatus(String s)        { this.status = s; }

    public String    getAvatar()                { return avatar; }
    public void      setAvatar(String a)        { this.avatar = a; }

    public Timestamp getCreatedAt()             { return createdAt; }
    public void      setCreatedAt(Timestamp t)  { this.createdAt = t; }

    public Timestamp getUpdatedAt()             { return updatedAt; }
    public void      setUpdatedAt(Timestamp t)  { this.updatedAt = t; }
}