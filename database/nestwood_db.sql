-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 21, 2026 at 07:24 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nestwood_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1, 'Sofa', '2026-05-02 14:58:45'),
(2, 'Bed', '2026-05-02 14:58:45'),
(3, 'Dining Table', '2026-05-02 14:58:45'),
(4, 'Chair', '2026-05-02 14:58:45'),
(5, 'Wardrobe', '2026-05-02 14:58:45'),
(6, 'Bookshelf', '2026-05-02 14:58:45');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `total_price` decimal(10,2) NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` enum('pending','confirmed','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `quantity`, `total_price`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, 25000.00, 'forestry campus', 'pending', '2026-05-20 14:54:51', '2026-05-20 14:54:51');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT 'product_default.png',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Luxury 3-Seater Sofa', 'Premium velvet sofa with wooden frame', 25000.00, 10, 'luxury-3-seater-sofa.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(2, 1, 'L-Shape Corner Sofa', 'Modern L-shaped sofa for living room', 35000.00, 5, 'l-shape-corner-sofa.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(3, 2, 'King Size Wooden Bed', 'Solid sheesham wood king bed', 45000.00, 8, 'king-size-wooden-bed.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(4, 2, 'Queen Bed with Storage', 'Queen bed with hydraulic storage', 38000.00, 6, 'queen-bed-with-storage.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(5, 3, 'Dining Table 6-Seater', '6 seater teak dining table with chairs', 32000.00, 4, 'dining-table-6-seater.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(6, 4, 'Office Ergonomic Chair', 'Adjustable office chair with lumbar support', 8500.00, 20, 'office-ergonomic-chair.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(7, 5, 'Sliding Wardrobe 3-Door', '3 door sliding mirror wardrobe', 28000.00, 7, 'sliding-wardrobe-3-door.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05'),
(8, 6, 'Wall Bookshelf 5-Tier', '5 tier wall mounted bookshelf', 6500.00, 15, 'wall-bookshelf-5-tier.jpg', 'active', '2026-05-02 14:58:45', '2026-05-19 17:40:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'approved',
  `avatar` varchar(255) DEFAULT 'default.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `role`, `status`, `avatar`, `created_at`, `updated_at`) VALUES
(1, 'NestWood Admin', 'admin@nestwood.com', '9800000000', '$2a$12$kjCSHj1e0F6YiFNyD9bB2edCuJTCcNQSmpM85Q77md9wJ6LgG2S0m', 'admin', 'approved', 'default.png', '2026-05-02 14:58:45', '2026-05-02 14:58:45'),
(2, 'Ram Sharma', 'ram@gmail.com', '9811111111', '$2a$12$GpGBj76oXUMqjcEtGEDwDOMDPmCjsmlUerT.wZsE7U3q8McGDpmba', 'user', 'approved', 'default.png', '2026-05-02 14:58:45', '2026-05-02 14:58:45'),
(3, 'Sita Thapa', 'sita@gmail.com', '9822222222', '$2a$12$GpGBj76oXUMqjcEtGEDwDOMDPmCjsmlUerT.wZsE7U3q8McGDpmba', 'user', 'approved', 'default.png', '2026-05-02 14:58:45', '2026-05-02 14:58:45'),
(4, 'krish', 'shaikrish05@gmail.com', '9814109890', '$2a$12$AFcY9aUZ.zSN60okutGNz.B56e3yYGuloITfFvgh.zeFO2d20Qn5G', 'user', 'approved', 'default.png', '2026-05-03 07:10:49', '2026-05-03 07:10:49'),
(5, 'Mayank Gurung', 'mayank@nestwood.com', '9812345678', '$2a$12$U4/R2krMrocpaOuKwUJJTOr9ztlVp5L6yHpEmIUOMe4PtNNnPfzca', 'admin', 'approved', 'default.png', '2026-05-20 14:12:04', '2026-05-20 14:14:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `orders_products_fk` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_products_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
