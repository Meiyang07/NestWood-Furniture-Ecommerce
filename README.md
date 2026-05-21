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
### Backend Architecture
src/main/java

model – Contains POJO/entity classes such as User, Product, Order, Category, and DashboardStats. These classes represent the main data objects used in the system.

dao – Contains database access classes such as UserDAO, ProductDAO, OrderDAO, and DashboardDAO. These classes communicate with the MySQL database and perform insert, update, delete, and retrieve operations.

service – Contains business logic classes such as UserService, ProductService, and OrderService. This layer works between the controller and DAO layer. It helps keep business rules separate from direct database code.

controller – Contains servlet classes that handle HTTP requests and responses. Controllers receive requests from JSP pages, call service or DAO methods, and forward users to the correct JSP page.

filter – Contains authentication and role-based access filters such as AuthFilter, GuestFilter, and RoleFilter. These filters protect restricted pages and manage access based on login session and user role.

util – Contains reusable helper classes such as DBConnection, SessionUtil, PasswordUtil, ValidationUtil, FileUploadUtil, and CookieUtil. These classes support database connection, session handling, password processing, validation, file upload, and cookie management.

### Frontend Architecture
src/main/webapp

WEB-INF – Contains the web.xml deployment descriptor and protected configuration files.

assets – Contains frontend resources such as CSS files, JavaScript files, images, and uploaded product images.

admin – Contains admin-side JSP pages such as dashboard, product management, add product, order management, and user management.

auth – Contains authentication pages such as login and registration.

user – Contains user-side JSP pages such as profile, wishlist, my orders, and user dashboard.

JSP View Pages – JSP pages are used as the View layer of the MVC architecture. These pages display dynamic data received from servlets and DAO/service classes.

### Architecture Flow
User Request

↓

JSP Page / Browser

↓

Controller Servlet

↓

Service Layer

↓

DAO Layer

↓

MySQL Database

↓

DAO Layer returns data

↓

Service Layer processes result

↓

Controller forwards response

↓

JSP displays output

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
- database/
    - nestwood_db.sql: SQL dump file with schema and sample data

- src/main/java/
    - controller/: Servlet/controller classes
    - dao/: Database operation classes
    - model/: Model/entity classes
    - util/: Utility classes
    - filter/: Authentication and role-based access filters

- src/main/webapp/
    - admin/: Admin JSP pages
    - auth/: Login and registration pages
    - user/: User dashboard, profile, wishlist, and orders
    - assets/css/: CSS files
    - assets/js/: JavaScript files
    - assets/images/: Static and uploaded images
    - WEB-INF/web.xml: Deployment descriptor
    - index.jsp: Main landing page

- pom.xml: Maven dependencies and project configuration
- README.md: Project setup and usage instructions
- .gitignore: Files/folders ignored by Git

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