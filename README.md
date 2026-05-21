# NestWood – Furniture E-Commerce System
A full-stack furniture e-commerce web application built using Java, Java EE (Servlets & JSP), MySQL, and custom CSS. Developed as part of the CS5054NP Advanced Programming and Technologies coursework.

## Project Overview
NestWood is a dynamic, role-based e-commerce system that allows customers to browse furniture products, manage a cart and wishlist, place orders, and track their order history. Administrators can manage products, orders, and user accounts through a dedicated admin dashboard.

##  Features

### Public / Guest
- Browse all active furniture products
- View product details (image, description, price, stock, category)
- Filter products by category, price range, and stock availability
- Search products by keyword
- View About and Contact pages

### Registered Users
- Register and log in securely (BCrypt password hashing)
- Remember Me cookie support
- Personal dashboard with recent orders and featured products
- Add products to cart (session-based)
- Add products to wishlist (session-based)
- Place orders with delivery address
- View order history and cancel pending orders
- Update profile details and change password

### Admin
- Admin dashboard with statistics (total users, products, orders, revenue)
- Full product CRUD (add, edit, delete, toggle active/inactive status)
- Product image upload
- View and update order status (pending → confirmed → shipped → delivered → cancelled)
- View and approve/reject registered user accounts
- Low stock alerts

---

## Technologies Used

| Layer | Technology |
|---|---|
| Backend | Java, Java EE, Servlets, JSP |
| Database | MySQL 8.0, JDBC |
| Frontend | JSP, Custom CSS, Flexbox, Media Queries |
| Security | BCrypt, HttpSession, Servlet Filters |
| Server | Apache Tomcat 10 |
| Tools | Apache NetBeans / IntelliJ IDEA, XAMPP, phpMyAdmin, GitHub |

> No external CSS frameworks (Bootstrap etc.) were used. All styling is custom.

---

## Project Architecture

The project follows the **MVC (Model-View-Controller)** design pattern:
- **Model:** Business logic and data objects (POJOs)
- **View:** JSP pages (user and admin)
- **Controller:** Servlets handling HTTP requests

## Database
- **Database name:** `nestwood_db`
- **Tables:** `users`, `categories`, `products`, `orders`
- The cart and wishlist are session-based (no separate database tables needed)

### Setup the Database

1. Open **phpMyAdmin** or your MySQL client
2. Create a new database named `nestwood_db`
3. Import the schema file:

```sql
source nestwood_db.sql
```
Or open `nestwood_db.sql` and run it directly in phpMyAdmin.

## How to Run the Project

### Prerequisites

- Java JDK 17 or above
- Apache Tomcat 10
- MySQL 8.0
- XAMPP (or any MySQL server)
- Apache NetBeans or IntelliJ IDEA

### Steps
1. **Clone the repository**
```bash
   git clone https://github.com/Meiyang07/NestWood-Furniture-Ecommerce.git
```
2. **Set up the database**
    - Start MySQL via XAMPP
    - Create a database named `nestwood_db`
    - Import `nestwood_db.sql`

3. **Update database credentials**
   Open `src/main/java/util/DBConnection.java` and update:
```java
   private static final String URL = "jdbc:mysql://localhost:3306/nestwood_db";
   private static final String USER = "root";       // your MySQL username
   private static final String PASSWORD = "";        // your MySQL password
```
4. **Open the project in your IDE**
    - Open as a Maven project
    - Let dependencies download automatically
5. **Deploy to Tomcat**
    - Add Apache Tomcat 10 as the server in your IDE
    - Run/deploy the project
    - Open your browser and go to: `http://localhost:8080/NestWood/`

## Default Admin Account
Email: admin@nestwood.com
Password: Admin@123

> You can change these credentials after logging in, or update them directly in the `users` table.

## Folder Structure

NestWood-Furniture-Ecommerce/
│
├── database/
│   └── schema.sql                  → Full database schema with sample data
│
├── src/
│   └── main/
│       ├── java/                   → All Java source files
│       └── webapp/
│           ├── assets/
│           │   ├── css/            → Stylesheet files
│           │   ├── js/             → JavaScript files
│           │   └── images/         → Static and uploaded images
│           ├── WEB-INF/
│           │   └── web.xml         → Deployment descriptor
│           └── *.jsp               → All JSP view pages
│
├── pom.xml                         → Maven dependencies
└── README.md

## Security Features

- Passwords hashed using **BCrypt** (12 rounds)
- SQL injection prevented using **PreparedStatement**
- Session-based authentication with **HttpSession**
- **HttpOnly** remember-me cookie
- Role-based access control via **Servlet Filters**
- Admin and user pages fully protected from unauthorised access

## Responsive Design

The UI is fully responsive without any CSS framework:
- **Flexbox** used for layout
- **CSS Media Queries** at 768px and 480px breakpoints
- Mobile navigation with hamburger menu toggle
- Single-column layout on small screens

## Module Information
| Field | Details                                                                     |
|---|-----------------------------------------------------------------------------|
| Module | CS5054NP – Advanced Programming and Technologies                            |
| Project | NestWood – Furniture E-Commerce System                                      |
| Student | Mayank Gurung, Krish Shahi, Abinash Lamgade, Sarthak Ghimire, Madan Sapkota |
| Institution | Informatics College, Pokhara                                                |

## License
This project was developed for academic purposes as part of LondonMet University coursework.