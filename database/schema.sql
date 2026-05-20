-- ============================================================
-- NestWood Furniture E-Commerce Database
-- Database: nestwood_db
-- ============================================================

DROP DATABASE IF EXISTS nestwood_db;
CREATE DATABASE nestwood_db;
USE nestwood_db;

-- ============================================================
-- TABLE: users
-- Stores both admin and regular user accounts
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
                                     id          INT AUTO_INCREMENT PRIMARY KEY,
                                     full_name   VARCHAR(100)        NOT NULL,
    email       VARCHAR(100)        NOT NULL UNIQUE,
    phone       VARCHAR(20)         NOT NULL UNIQUE,
    password    VARCHAR(255)        NOT NULL,       -- BCrypt hashed
    role        ENUM('admin','user') NOT NULL DEFAULT 'user',
    status      ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
    avatar      VARCHAR(255)        DEFAULT 'default.png',
    created_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- ============================================================
-- TABLE: categories
-- Furniture categories (Sofa, Bed, Table, Chair, etc.)
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
                                          id          INT AUTO_INCREMENT PRIMARY KEY,
                                          name        VARCHAR(100)  NOT NULL UNIQUE,
    created_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
    );

-- ============================================================
-- TABLE: products
-- Main CRUD entity — furniture items managed by admin
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
                                        id            INT AUTO_INCREMENT PRIMARY KEY,
                                        category_id   INT            NOT NULL,
                                        name          VARCHAR(150)   NOT NULL,
    description   TEXT,
    price         DECIMAL(10,2)  NOT NULL,
    stock         INT            NOT NULL DEFAULT 0,
    image         VARCHAR(255)   DEFAULT 'product_default.png',
    status        ENUM('active','inactive') NOT NULL DEFAULT 'active',
    created_at    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
    );

-- ============================================================
-- TABLE: orders
-- User places orders for products
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
                                      id           INT AUTO_INCREMENT PRIMARY KEY,
                                      user_id      INT              NOT NULL,
                                      product_id   INT              NOT NULL,
                                      quantity     INT              NOT NULL DEFAULT 1,
                                      total_price  DECIMAL(10,2)   NOT NULL,
    address      VARCHAR(255)    NOT NULL,
    status       ENUM('pending','confirmed','shipped','delivered','cancelled')
    NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
    );

-- ============================================================
-- SAMPLE DATA — Categories
-- ============================================================
INSERT INTO categories (name) VALUES
                                  ('Sofa'),
                                  ('Bed'),
                                  ('Dining Table'),
                                  ('Chair'),
                                  ('Wardrobe'),
                                  ('Bookshelf');

-- ============================================================
-- SAMPLE DATA — Admin account
-- Password: Admin@123  (BCrypt hash below)
-- Status: approved (admins are auto-approved)
-- ============================================================
INSERT INTO users (full_name, email, phone, password, role, status) VALUES
    ('NestWood Admin',
     'admin@nestwood.com',
     '9800000000',
     '$2a$12$kjCSHj1e0F6YiFNyD9bB2edCuJTCcNQSmpM85Q77md9wJ6LgG2S0m',
     'admin',
     'approved');

-- ============================================================
-- SAMPLE DATA — Regular users
-- Password for both: User@123
-- Status: approved (for testing purposes)
-- ============================================================
INSERT INTO users (full_name, email, phone, password, role, status) VALUES
                                                                ('Ram Sharma', 'ram@gmail.com', '9811111111',
                                                                 '$2a$12$GpGBj76oXUMqjcEtGEDwDOMDPmCjsmlUerT.wZsE7U3q8McGDpmba', 'user', 'approved'),
                                                                ('Sita Thapa', 'sita@gmail.com', '9822222222',
                                                                 '$2a$12$GpGBj76oXUMqjcEtGEDwDOMDPmCjsmlUerT.wZsE7U3q8McGDpmba', 'user', 'approved');

-- ============================================================
-- SAMPLE DATA — Products
-- ============================================================
INSERT INTO products (category_id, name, description, price, stock, image) VALUES
                                                                        (1, 'Luxury 3-Seater Sofa',   'Premium velvet sofa with wooden frame',  25000.00, 10, 'luxury-3-seater-sofa.jpg'),
                                                                        (1, 'L-Shape Corner Sofa',    'Modern L-shaped sofa for living room',   35000.00,  5, 'l-shape-corner-sofa.jpg'),
                                                                        (2, 'King Size Wooden Bed',   'Solid sheesham wood king bed',           45000.00,  8, 'king-size-wooden-bed.jpg'),
                                                                        (2, 'Queen Bed with Storage', 'Queen bed with hydraulic storage',       38000.00,  6, 'queen-bed-with-storage.jpg'),
                                                                        (3, 'Dining Table 6-Seater',  '6 seater teak dining table with chairs', 32000.00,  4, 'dining-table-6-seater.jpg'),
                                                                        (4, 'Office Ergonomic Chair', 'Adjustable office chair with lumbar support', 8500.00, 20, 'office-ergonomic-chair.jpg'),
                                                                        (5, 'Sliding Wardrobe 3-Door','3 door sliding mirror wardrobe',         28000.00,  7, 'sliding-wardrobe-3-door.jpg'),
                                                                        (6, 'Wall Bookshelf 5-Tier',  '5 tier wall mounted bookshelf',          6500.00,  15, 'wall-bookshelf-5-tier.jpg');

-- ============================================================
-- SAMPLE DATA — Orders
-- ============================================================
INSERT INTO orders (user_id, product_id, quantity, total_price, address, status) VALUES
                                                                                     (2, 1, 1, 25000.00, 'Lakeside, Pokhara', 'delivered'),
                                                                                     (2, 6, 2, 17000.00, 'Lakeside, Pokhara', 'shipped'),
                                                                                     (3, 3, 1, 45000.00, 'Newroad, Kathmandu', 'confirmed'),
                                                                                     (3, 5, 1, 32000.00, 'Newroad, Kathmandu', 'pending');