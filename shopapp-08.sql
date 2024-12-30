-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql8-container
-- Generation Time: Dec 09, 2023 at 10:01 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.8
DROP DATABASE IF EXISTS shopapp;
-- Nếu cơ sở dữ liệu ShopApp chưa tồn tại, thực hiện câu lệnh CREATE DATABASE
CREATE DATABASE IF NOT EXISTS shopapp;

-- Sử dụng cơ sở dữ liệu ShopApp
USE shopapp;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ShopApp`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
                              `id` int NOT NULL,
                              `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
                                            (3, 'Bánh kẹo'),
                                            (5, 'Chăn ga gối đệm'),
                                            (7, 'Phụ kiện'),
                                            (6, 'Quần áo'),
                                            (4, 'Đồ gia dụng'),
                                            (2, 'Đồ điện tử');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
                            `id` int NOT NULL,
                            `product_id` int DEFAULT NULL,
                            `user_id` int DEFAULT NULL,
                            `content` varchar(255) DEFAULT NULL,
                            `created_at` datetime DEFAULT NULL,
                            `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
                           `id` int NOT NULL,
                           `code` varchar(50) NOT NULL,
                           `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_conditions`
--

CREATE TABLE `coupon_conditions` (
                                     `id` int NOT NULL,
                                     `coupon_id` int NOT NULL,
                                     `attribute` varchar(255) NOT NULL,
                                     `operator` varchar(10) NOT NULL,
                                     `value` varchar(255) NOT NULL,
                                     `discount_amount` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
                             `id` int NOT NULL,
                             `user_id` int DEFAULT NULL,
                             `product_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `product_id`) VALUES
    (1, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `flyway_schema_history`
--

CREATE TABLE `flyway_schema_history` (
                                         `installed_rank` int NOT NULL,
                                         `version` varchar(50) DEFAULT NULL,
                                         `description` varchar(200) NOT NULL,
                                         `type` varchar(20) NOT NULL,
                                         `script` varchar(1000) NOT NULL,
                                         `checksum` int DEFAULT NULL,
                                         `installed_by` varchar(100) NOT NULL,
                                         `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         `execution_time` int NOT NULL,
                                         `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `flyway_schema_history`
--

INSERT INTO `flyway_schema_history` (`installed_rank`, `version`, `description`, `type`, `script`, `checksum`, `installed_by`, `installed_on`, `execution_time`, `success`) VALUES
                                                                                                                                                                                (2, '1', 'alter some tables', 'SQL', 'V1__alter_some_tables.sql', 670188877, 'root', '2023-12-01 10:05:58', 605, 1),
                                                                                                                                                                                (3, '2', 'change tokens', 'SQL', 'V2__change_tokens.sql', 1468721430, 'root', '2023-12-01 10:05:58', 27, 1),
                                                                                                                                                                                (4, '3', 'refresh tokens', 'SQL', 'V3__refresh_tokens.sql', 1847335528, 'root', '2023-12-03 04:50:25', 36, 1),
                                                                                                                                                                                (5, '4', 'create comments table', 'SQL', 'V4__create_comments_table.sql', -16394321, 'root', '2024-04-01 15:28:05', 31, 1),
                                                                                                                                                                                (6, '5', 'create coupon table', 'SQL', 'V5__create_coupon_table.sql', 1588630482, 'root', '2024-04-01 15:28:05', 182, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
                          `id` int NOT NULL,
                          `user_id` int DEFAULT NULL,
                          `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                          `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                          `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                          `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
                          `status` enum('pending','processing','shipped','delivered','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
                          `total_money` float DEFAULT NULL,
                          `shipping_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
                          `shipping_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
                          `shipping_date` date DEFAULT NULL,
                          `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
                          `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
                          `active` tinyint(1) DEFAULT NULL,
                          `coupon_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone_number`, `address`, `note`, `order_date`, `status`, `total_money`, `shipping_method`, `shipping_address`, `shipping_date`, `tracking_number`, `payment_method`, `active`, `coupon_id`) VALUES
                                                                                                                                                                                                                                                              (14, 2, 'John Smith', 'john@example.com', '1234567890', '123 Main St', 'Note 1', NULL, 'shipped', 500, NULL, NULL, NULL, NULL, NULL, 0, NULL),
                                                                                                                                                                                                                                                              (15, 5, 'Eric Thompson', 'eric@example.com', '9876543210', '456 Elm St', 'Note 2', '2023-10-08 00:43:21', 'pending', 400, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (16, 2, 'Hans', 'hans@example.com', '5555555555', '789 Oak St', 'Note 3', '2023-10-08 00:43:21', 'pending', 300, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (17, 5, 'Alice Johnson', 'alice@example.com', '5551234567', '789 Cherry Ave', 'Note 4', '2023-10-08 00:43:21', 'pending', 200, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (18, 2, 'Robert Williams', 'robert@example.com', '5559876543', '321 Maple Rd', 'Note 5', '2023-10-08 00:43:21', 'pending', 100, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (19, 2, 'Sarah Davis', 'sarah@example.com', '5554445555', '987 Elm St', 'Note 6', '2023-10-08 00:43:21', 'pending', 250, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (20, 5, 'Michael Anderson', 'michael@example.com', '5556667777', '654 Oak Ave', 'Note 7', '2023-10-08 00:43:21', 'pending', 350, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (21, 2, 'Emma Wilson', 'emma@example.com', '5558889999', '789 Maple Ln', 'Note 8', '2023-10-08 00:43:21', 'pending', 450, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (22, 2, 'Olivia Brown', 'olivia@example.com', '5551112222', '987 Pine St', 'Note 47', '2023-10-08 00:43:21', 'pending', 350, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (23, 5, 'William Davis', 'william@example.com', '5553334444', '654 Elm Ave', 'Note 48', '2023-10-08 00:43:21', 'pending', 250, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (24, 2, 'Sophia Wilson', 'sophia@example.com', '5555556666', '789 Oak Ln', 'Note 49', '2023-10-08 00:43:21', 'pending', 150, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (25, 5, 'Alexander Anderson', 'alexander@example.com', '5557778888', '456 Maple Lane', 'Note 50', '2023-10-08 00:43:21', 'pending', 450, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (26, 2, 'Ava Thompson', 'ava@example.com', '5559990000', '987 Walnut Rd', 'Note 51', '2023-10-08 00:43:21', 'pending', 550, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (27, 5, 'Daniel Johnson', 'daniel@example.com', '5552223333', '654 Pine Ave', 'Note 52', '2023-10-08 00:43:21', 'pending', 650, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (28, 2, 'Mia Williams', 'mia@example.com', '5554445555', '789 Elm St', 'Note 53', '2023-10-08 00:43:21', 'pending', 750, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (29, 5, 'James Davis', 'james@example.com', '5556667777', '456 Oak Ave', 'Note 54', '2023-10-08 00:43:21', 'pending', 850, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (30, 5, 'Benjamin Thompson', 'benjamin@example.com', '5550001111', '654 Walnut Rd', 'Note 56', '2023-10-08 00:43:21', 'pending', 550, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (31, 2, 'Sophia Anderson', 'sophia@example.com', '5551112222', '987 Pine St', 'Note 57', '2023-10-08 00:43:21', 'pending', 350, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (32, 5, 'Elijah Davis', 'elijah@example.com', '5553334444', '654 Elm Ave', 'Note 58', '2023-10-08 00:43:21', 'pending', 250, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (33, 2, 'Ava Wilson', 'ava@example.com', '5555556666', '789 Oak Ln', 'Note 59', '2023-10-08 00:43:21', 'pending', 150, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (34, 5, 'Oliver Thompson', 'oliver@example.com', '5557778888', '456 Maple Lane', 'Note 60', '2023-10-08 00:43:21', 'pending', 450, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (35, 2, 'Mia Johnson', 'mia@example.com', '5559990000', '987 Walnut Rd', 'Note 61', '2023-10-08 00:43:21', 'pending', 550, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (36, 5, 'James Williams', 'james@example.com', '5552223333', '654 Pine Ave', 'Note 62', '2023-10-08 00:43:21', 'pending', 650, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (37, 2, 'Charlotte Davis', 'charlotte@example.com', '5554445555', '789 Elm St', 'Note 63', '2023-10-08 00:43:21', 'pending', 750, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (38, 5, 'Benjamin Wilson', 'benjamin@example.com', '5556667777', '456 Oak Ave', 'Note 64', '2023-10-08 00:43:21', 'pending', 850, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (39, 2, 'Amelia Thompson', 'amelia@example.com', '5558889999', '321 Maple Ln', 'Note 65', '2023-10-08 00:43:21', 'pending', 950, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (40, 5, 'Henry Johnson', 'henry@example.com', '5550001111', '654 Walnut Rd', 'Note 66', '2023-10-08 00:43:21', 'pending', 550, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (41, 5, 'Emily Davis', 'emily@example.com', '5552223333', '456 Walnut Lane', 'Note 46', '2023-10-08 00:43:21', 'pending', 150, NULL, NULL, NULL, NULL, NULL, 1, NULL),
                                                                                                                                                                                                                                                              (42, 5, 'Nguyễn Văn X', 'nvxx@yahoo.com', '1234456', 'Nhà a ngõ B, ngách D', 'Hàng dễ vỡ xin nhẹ tay', '2023-11-16 00:00:00', 'pending', 123.45, 'express', NULL, '2023-11-16', NULL, 'cod', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
                                 `id` int NOT NULL,
                                 `order_id` int DEFAULT NULL,
                                 `product_id` int DEFAULT NULL,
                                 `price` decimal(10,2) DEFAULT NULL,
                                 `number_of_products` int DEFAULT '1',
                                 `total_money` decimal(10,2) DEFAULT '0.00',
                                 `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                                 `coupon_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `number_of_products`, `total_money`, `color`, `coupon_id`) VALUES
                                                                                                                                     (14, 14, 1, 10.99, 2, 21.98, 'Red', NULL),
                                                                                                                                     (15, 14, 2, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (16, 14, 3, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (17, 15, 1, 10.99, 2, 21.98, 'Red', NULL),
                                                                                                                                     (18, 15, 2, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (19, 15, 3, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (20, 16, 6, 12.99, 3, 38.97, 'Purple', NULL),
                                                                                                                                     (21, 17, 7, 6.99, 1, 6.99, 'Pink', NULL),
                                                                                                                                     (22, 18, 8, 14.99, 2, 29.98, 'Gray', NULL),
                                                                                                                                     (23, 19, 9, 11.49, 1, 11.49, 'Brown', NULL),
                                                                                                                                     (24, 20, 10, 8.99, 3, 26.97, 'Black', NULL),
                                                                                                                                     (25, 21, 11, 13.99, 2, 27.98, 'Silver', NULL),
                                                                                                                                     (26, 22, 12, 10.49, 1, 10.49, 'Gold', NULL),
                                                                                                                                     (27, 23, 13, 7.49, 2, 14.98, 'White', NULL),
                                                                                                                                     (28, 38, 1, 10.99, 2, 21.98, 'Red', NULL),
                                                                                                                                     (29, 38, 2, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (30, 38, 3, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (31, 24, 14, 9.99, 2, 19.98, 'Red', NULL),
                                                                                                                                     (32, 24, 15, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (33, 24, 16, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (34, 25, 17, 10.99, 2, 21.98, 'Yellow', NULL),
                                                                                                                                     (35, 25, 18, 5.99, 3, 17.97, 'Orange', NULL),
                                                                                                                                     (36, 25, 19, 8.49, 1, 8.49, 'Purple', NULL),
                                                                                                                                     (37, 26, 20, 6.99, 2, 13.98, 'Pink', NULL),
                                                                                                                                     (38, 26, 21, 14.99, 1, 14.99, 'Gray', NULL),
                                                                                                                                     (39, 26, 22, 11.49, 3, 34.47, 'Brown', NULL),
                                                                                                                                     (40, 27, 23, 8.99, 2, 17.98, 'Black', NULL),
                                                                                                                                     (41, 27, 24, 13.99, 1, 13.99, 'Silver', NULL),
                                                                                                                                     (42, 27, 25, 10.49, 3, 31.47, 'Gold', NULL),
                                                                                                                                     (43, 28, 26, 7.49, 2, 14.98, 'White', NULL),
                                                                                                                                     (44, 28, 27, 9.99, 1, 9.99, 'Red', NULL),
                                                                                                                                     (45, 28, 28, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (46, 29, 29, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (47, 29, 30, 10.99, 2, 21.98, 'Yellow', NULL),
                                                                                                                                     (48, 29, 31, 5.99, 3, 17.97, 'Orange', NULL),
                                                                                                                                     (49, 30, 32, 8.49, 1, 8.49, 'Purple', NULL),
                                                                                                                                     (50, 30, 33, 6.99, 2, 13.98, 'Pink', NULL),
                                                                                                                                     (51, 30, 34, 14.99, 1, 14.99, 'Gray', NULL),
                                                                                                                                     (52, 31, 35, 11.49, 3, 34.47, 'Brown', NULL),
                                                                                                                                     (53, 31, 36, 8.99, 2, 17.98, 'Black', NULL),
                                                                                                                                     (54, 31, 37, 13.99, 1, 13.99, 'Silver', NULL),
                                                                                                                                     (55, 32, 38, 10.49, 3, 31.47, 'Gold', NULL),
                                                                                                                                     (56, 32, 39, 7.49, 2, 14.98, 'White', NULL),
                                                                                                                                     (57, 32, 40, 9.99, 1, 9.99, 'Red', NULL),
                                                                                                                                     (58, 33, 41, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (59, 33, 42, 8.49, 1, 8.49, 'Green', NULL),
                                                                                                                                     (60, 33, 43, 10.99, 2, 21.98, 'Yellow', NULL),
                                                                                                                                     (61, 34, 44, 5.99, 3, 17.97, 'Orange', NULL),
                                                                                                                                     (62, 34, 45, 8.49, 1, 8.49, 'Purple', NULL),
                                                                                                                                     (63, 34, 46, 6.99, 2, 13.98, 'Pink', NULL),
                                                                                                                                     (64, 35, 47, 14.99, 1, 14.99, 'Gray', NULL),
                                                                                                                                     (65, 35, 48, 11.49, 3, 34.47, 'Brown', NULL),
                                                                                                                                     (66, 35, 49, 8.99, 2, 17.98, 'Black', NULL),
                                                                                                                                     (67, 36, 50, 13.99, 1, 13.99, 'Silver', NULL),
                                                                                                                                     (68, 36, 51, 10.49, 3, 31.47, 'Gold', NULL),
                                                                                                                                     (69, 36, 52, 7.49, 2, 14.98, 'White', NULL),
                                                                                                                                     (70, 37, 53, 9.99, 1, 9.99, 'Red', NULL),
                                                                                                                                     (71, 37, 54, 5.99, 3, 17.97, 'Blue', NULL),
                                                                                                                                     (72, 42, 5, 32.85, 7, NULL, NULL, NULL),
                                                                                                                                     (73, 42, 7, 32.94, 2, NULL, NULL, NULL),
                                                                                                                                     (74, 42, 9, 45.88, 3, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
                            `id` int NOT NULL,
                            `name` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Tên sản phẩm',
                            `price` decimal(10,2) DEFAULT NULL,
                            `thumbnail` varchar(255) DEFAULT NULL,
                            `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
                            `created_at` datetime DEFAULT NULL,
                            `updated_at` datetime DEFAULT NULL,
                            `category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `thumbnail`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
                                                                                                                          (1, 'Awesome Steel Lamp', 70.07, 'f2fcda26-8304-48bc-9472-ead1c297770f_001.jpg', 'Provident similique voluptate et voluptas at corrupti nobis.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (2, 'Fantastic Bronze Watch33', 89.99, '34823684-2d69-4e22-8ad6-aa2bc1ccbaf6_006.jpg', 'Voluptas nemo quis doloribus nisi optio culpa.33', '2023-07-31 08:28:28', '2023-11-10 09:27:31', 4),
                                                                                                                          (3, 'Rustic Marble Knife', 12.87, 'c4bd25e4-620c-44fc-9f69-22edde299a8f_011.jpg', 'Quia recusandae delectus dolor cumque.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (5, 'Synergistic Linen Hat', 32.85, '6ba6318c-ed8b-4f6d-9a9b-d8ca1c6e1afc_016.jpg', 'Minus aliquid quibusdam doloribus aut.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (6, 'Gorgeous Bronze Table', 91.24, 'd436afbc-c96c-4676-9b4f-91f8a597b61f_3680642999530', 'Qui voluptatem quia maiores ratione in.', '2023-07-31 08:28:28', '2024-04-01 23:41:28', 2),
                                                                                                                          (7, 'Incredible Wooden Coat', 32.94, '3036dff0-72cd-48d4-9efd-7221f41fc61d_022.jpg', 'Excepturi recusandae maxime est voluptates iste nesciunt ea.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (8, 'Mediocre Wooden Bench', 25.76, '36bf6016-4eff-4864-bf27-1de57e7d6589_027.jpg', 'Dignissimos qui eos et officia ut sed.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (9, 'Fantastic Paper Clock', 45.88, '326235eb-015b-4176-8977-fb96df932557_032.jpg', 'Consequatur voluptas omnis veritatis.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (10, 'Lightweight Wool Shoes', 42.91, '3d3097a5-38dc-45b7-81be-7300816ab4b9_037.jpg', 'Magni nisi sunt.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (11, 'Rustic Paper Bag', 76.33, '67dedbd7-d14a-4db0-801f-3ab18fdca6d3_038.jpg', 'Fuga assumenda omnis autem.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (12, 'Enormous Linen Wallet', 16.09, 'cf00f484-f8a4-4b9a-8a9f-ef74bfd7ebcf_045.jpg', 'Ut cupiditate quia dolorem placeat unde cum quo.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (13, 'Heavy Duty Concrete Hat', 30.82, '862e0948-8961-4c2a-b76a-f2322c846a4b_050.jpg', 'Ipsum beatae beatae.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (14, 'Enormous Aluminum Table', 32.83, 'd152fdfd-6c49-440c-a249-8fdc08646333_055.jpg', 'Non reprehenderit omnis.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (15, 'Small Iron Shirt', 21.25, '904a9f1c-207c-4df6-bb49-c954656a8c06_059.jpg', 'Reiciendis et nemo.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (16, 'Heavy Duty Steel Clock', 56.38, 'c86bb69d-e5a2-4c93-8f0a-87504a8966ea_064.jpg', 'Voluptates et veritatis ut saepe dolorem.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (17, 'Rustic Steel Knife', 94.99, 'dafed832-a59c-41ad-bc60-011fadaf8020_069.jpg', 'Autem iure quia atque.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (18, 'Incredible Wooden Plate', 75.35, 'a98c6339-a19f-4dfe-a230-9a0ea1236192_083.jpg', 'Aut beatae voluptatibus excepturi.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (19, 'Rustic Linen Watch', 70.74, '699080d6-5b3c-4153-b3cb-140ee06f23f9_088.jpg', 'Et rerum aut accusamus numquam exercitationem minus voluptas.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (20, 'Durable Concrete Gloves', 71.88, 'a8dbe441-3db0-44d5-9b87-baf5b932683e_093.jpg', 'Aut hic officiis.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (21, 'Small Cotton Clock', 41.02, '3399c072-8c9b-4206-94fd-c411ff5339b4_093.jpg', 'Hic ea qui dicta.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (22, 'Ergonomic Concrete Shirt', 84.58, '79e8b5ff-8635-4416-8b4a-461f06ea0c03_096.jpg', 'Tempora amet sed omnis est aut est.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (23, 'Practical Plastic Clock', 11.74, '742f6cfb-8fdf-4fdf-9bee-68b31a70a470_099.jpg', 'Quo minus ea impedit et aut.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (24, 'Sleek Steel Car', 37.95, '52f4e6a0-d342-4bf4-b7d9-bc7bcf564014_102.jpg', 'Dolorem enim et nihil enim unde voluptas aspernatur.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 4),
                                                                                                                          (25, 'Aerodynamic Marble Shoes', 31.30, '6b4e1d1f-1bc2-4f4a-a1a8-567ed652b9bc_104.jpg', 'Labore quia sit praesentium assumenda cumque voluptatem accusantium.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
                                                                                                                          (26, 'Awesome Marble Computer', 23.14, '8ecbe322-1e99-400c-a11f-faafdf136092_109.jpg', 'Ea sed dolor est occaecati nihil.', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 7),
                                                                                                                          (27, 'Synergistic Silk Pants', 18.06, '68b52bd4-c6b5-41bf-88f2-8471e90b1f14_113.jpg', 'Sed cumque sit aut perferendis autem.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 7),
                                                                                                                          (28, 'Ergonomic Plastic Table', 80.87, '1575726c-6bec-4e9c-a063-fc3ed7589a32_118.jpg', 'A voluptas deserunt.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 7),
                                                                                                                          (29, 'Lightweight Wool Chair', 57.00, '9dd25e0b-b962-4f5c-b798-378998f2c8a8_122.jpg', 'Sunt qui eos nemo reiciendis itaque facere.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (30, 'Sleek Iron Car', 35.10, 'ea27dc6a-c7f9-467f-971e-26e7c136249e_17131387649445', 'Nulla porro qui non id temporibus labore qui.', '2023-07-31 08:28:29', '2024-04-01 16:13:20', 7),
                                                                                                                          (31, 'Sleek Marble Computer', 19.98, 'd40a5b86-a736-4bec-8b80-78dd33928ddd_126.jpg', 'Voluptatem mollitia quidem ad impedit non.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 7),
                                                                                                                          (32, 'Heavy Duty Iron Clock', 6.67, '0172df63-6c6c-4565-bf5f-c9ac847e77e9_128.jpg', 'Et ducimus illum.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (33, 'Aerodynamic Bronze Bottle', 72.89, '4bde7c98-7e06-4e20-9081-8aa2c345da02_131.jpg', 'Ratione optio nobis esse veritatis.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (34, 'Rustic Iron Coat', 89.88, NULL, 'Accusamus sed distinctio.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (35, 'Mediocre Aluminum Bag', 10.63, 'e6c66ba0-bc30-4db5-a8e3-3a023690fe66_17316560704483', 'Officia asperiores nihil omnis sed praesentium quod delectus.', '2023-07-31 08:28:29', '2024-04-03 15:21:15', 4),
                                                                                                                          (36, 'Heavy Duty Silk Bottle', 64.09, '8b1b9394-bacd-42d7-beda-52ef8110446b_16583760185134', 'Et in amet impedit inventore.', '2023-07-31 08:28:29', '2024-04-01 16:04:12', 7),
                                                                                                                          (37, 'Mediocre Marble Wallet', 66.09, '43c69151-895c-49e0-be8b-2f22b1c28f3d_16461126008689', 'Rerum ab vel non.', '2023-07-31 08:28:29', '2024-04-01 16:02:10', 3),
                                                                                                                          (38, 'Intelligent Marble Keyboard', 85.81, '54a9ff3c-32a5-4858-a9a4-78f190fdf19a_14645378220100', 'Fuga nesciunt in culpa.', '2023-07-31 08:28:29', '2024-04-01 15:31:54', 3),
                                                                                                                          (39, 'Synergistic Granite Car', 73.61, NULL, 'Totam ut voluptate dolor est.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (40, 'Mediocre Cotton Shirt', 28.38, NULL, 'Mollitia modi quia distinctio molestiae facere adipisci.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (41, 'Enormous Marble Wallet', 16.78, 'c5e6a686-70cf-4172-9ed8-139a0cef0da0_14593941271931', 'Molestiae minima natus eligendi illum optio eos.', '2023-07-31 08:28:29', '2024-04-01 15:31:03', 3),
                                                                                                                          (42, 'Mediocre Silk Gloves', 18.40, 'c3dfc400-6b66-4023-84b7-6f22bae927ea_17337381203629', 'Ullam autem iure in similique vitae.', '2023-07-31 08:28:29', '2024-04-03 15:21:36', 4),
                                                                                                                          (43, 'Awesome Copper Wallet', 56.61, 'b84be7b8-1a0d-431d-8959-a1ebb96a3ae3___opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2014__11__BakedOccasions_BirthdayCake-02af7038d93647d9a7339f0802b03079.jpg', 'Minus aut possimus aliquam est.', '2023-07-31 08:28:29', '2024-04-01 15:24:18', 3),
                                                                                                                          (44, 'Enormous Wool Table', 39.05, '3038afbf-f027-4f9d-9589-f2cbf7cfaf05_9251416664517', 'Aut quis consequatur ab ipsam illum corrupti nesciunt.', '2023-07-31 08:28:29', '2024-04-03 13:06:50', 3),
                                                                                                                          (45, 'Gorgeous Granite Keyboard', 83.44, 'ee2e7ef1-c2ac-4759-a8f6-2270287477a3_9270462817861', 'Pariatur enim non error.', '2023-07-31 08:28:29', '2024-04-03 13:07:09', 3),
                                                                                                                          (46, 'Small Copper Pants', 8.83, NULL, 'Non rerum laboriosam quos eos est.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (47, 'Practical Copper Car', 7.76, NULL, 'Provident minus ut temporibus non mollitia deserunt.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (48, 'Incredible Marble Coat', 17.05, 'cb09684e-81a0-4501-a886-c5cf6fe758a8_9291821864787', 'Odio aliquid sequi.', '2023-07-31 08:28:29', '2024-04-03 13:07:30', 3),
                                                                                                                          (49, 'Awesome Concrete Table', 25.02, 'fb02fe08-f929-4b6a-9bf5-1300192cf822_9327809183395', 'Et laboriosam eum quos eveniet dolor quaerat provident.', '2023-07-31 08:28:29', '2024-04-03 13:08:06', 3),
                                                                                                                          (50, 'Ergonomic Wooden Pants', 96.05, '222cdf94-c657-4940-bebd-9adbf66b7dd0_9310777893960', 'Vel maiores enim officia.', '2023-07-31 08:28:29', '2024-04-03 13:07:49', 3),
                                                                                                                          (51, 'Lightweight Concrete Bag', 89.77, '1cfca236-6f0f-4e4f-b4dd-5e616b475b3c_17351966896420', 'Laborum consequatur maiores omnis consequuntur.', '2023-07-31 08:28:29', '2024-04-03 15:21:51', 4),
                                                                                                                          (52, 'Mediocre Concrete Pants', 57.11, 'ff452ff4-cd77-401f-b779-93bbfb3ebef3_9351107771295', 'Omnis molestiae laudantium consequatur non doloribus dicta.', '2023-07-31 08:28:29', '2024-04-03 13:08:30', 3),
                                                                                                                          (53, 'Heavy Duty Plastic Wallet', 54.09, '102de590-2a90-4876-9a10-a0fecc708925_9364827251631', 'Et est enim nesciunt.', '2023-07-31 08:28:29', '2024-04-03 13:08:43', 3),
                                                                                                                          (54, 'Incredible Aluminum Bottle', 90.84, '48722045-42b8-4f9b-b1a5-9fc186b1a308_9403627893532', 'Neque neque debitis.', '2023-07-31 08:28:29', '2024-04-03 13:09:22', 3),
                                                                                                                          (55, 'Heavy Duty Concrete Table', 93.11, '9b59faea-8633-402f-ba9a-e7f716029254_9418181124601', 'Voluptatem deleniti voluptas voluptatem accusantium quos reiciendis et.', '2023-07-31 08:28:29', '2024-04-03 13:09:37', 3),
                                                                                                                          (56, 'Awesome Silk Shirt', 78.62, NULL, 'Quidem sint et nihil vero.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (57, 'Practical Linen Wallet', 69.70, 'cc6a500a-a4e4-4216-81f8-d4883b448cb6_11234793927128', 'Voluptas aut autem quod aut ipsam.', '2023-07-31 08:28:29', '2024-04-03 13:39:53', 3),
                                                                                                                          (58, 'Rustic Cotton Car', 12.71, NULL, 'Ut eum ut aliquid.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (59, 'Practical Wooden Car', 16.29, NULL, 'Veniam sequi dignissimos aut ea quis.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (60, 'Mediocre Marble Pants', 49.15, NULL, 'Error veniam quam repudiandae.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (61, 'Mediocre Iron Wallet', 14.27, '3830b82d-a393-457e-9c25-63045540afd4_11219246349279', 'Et omnis sequi dolorem.', '2023-07-31 08:28:29', '2024-04-03 13:39:38', 3),
                                                                                                                          (62, 'Rustic Leather Lamp', 43.70, NULL, 'Et voluptate voluptas dignissimos veniam consequatur ab.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (63, 'Gorgeous Wool Bench', 22.97, '3c34921d-444d-435a-963e-0a92f3158570_16588711951108', 'Quia eligendi ratione inventore cum.', '2023-07-31 08:28:29', '2024-04-03 15:09:07', 3),
                                                                                                                          (64, 'Gorgeous Iron Watch', 90.13, NULL, 'Doloremque nisi aspernatur nihil quae veritatis.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (65, 'Intelligent Iron Computer', 90.67, '704e218f-70f9-4a32-9c2f-23c70b41f305_16605924654919', 'Pariatur hic excepturi cumque quidem et ea.', '2023-07-31 08:28:29', '2024-04-03 15:09:25', 3),
                                                                                                                          (66, 'Incredible Wool Table', 39.56, '783a6e69-75a6-4927-906a-e2dc5b4234ca_11018156835712', 'Qui in maxime nihil quis.', '2023-07-31 08:28:29', '2024-04-03 13:36:17', 3),
                                                                                                                          (67, 'Enormous Cotton Lamp', 60.61, '6dca2b02-8749-4593-86b4-7c17cbdc8036_10998343458698', 'Voluptatibus voluptatem reiciendis ea nemo eveniet praesentium minus.', '2023-07-31 08:28:29', '2024-04-03 13:35:57', 3),
                                                                                                                          (68, 'Fantastic Concrete Lamp', 27.61, NULL, 'In rem temporibus corrupti molestiae maxime molestiae.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (69, 'Lightweight Plastic Watch', 17.10, 'e4059e78-3f7b-4b75-9d2d-6d53c3c84a3c_10977193467006', 'Voluptatem porro in.', '2023-07-31 08:28:29', '2024-04-03 13:35:36', 3),
                                                                                                                          (70, 'Sleek Granite Bottle', 19.36, NULL, 'Repellat animi corrupti nulla eos voluptatem doloribus.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (71, 'Fantastic Copper Car', 84.91, NULL, 'Quae qui est sed nam.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
                                                                                                                          (72, 'Fantastic Rubber Table', 27.04, NULL, 'In at et.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
                                                                                                                          (73, 'Incredible Concrete Hat', 58.65, NULL, 'Aliquam harum explicabo animi ducimus.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
                                                                                                                          (74, 'Rustic Iron Hat', 86.93, NULL, 'Consequuntur sed reprehenderit iste.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (75, 'Ergonomic Cotton Knife', 73.87, NULL, 'Rerum maiores voluptatum beatae animi voluptatem odio dolorem.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (76, 'Small Paper Keyboard', 24.11, NULL, 'Quaerat autem exercitationem et impedit.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (77, 'Practical Paper Bench', 10.22, NULL, 'Culpa temporibus voluptatibus.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
                                                                                                                          (78, 'Incredible Copper Shoes', 23.28, NULL, 'Voluptatem qui reprehenderit pariatur provident voluptate.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
                                                                                                                          (79, 'Rustic Linen Hat', 26.26, NULL, 'Ut quasi blanditiis blanditiis.', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
                                                                                                                          (80, 'Enormous Bronze Lamp', 59.38, '7ce55779-2500-40b6-a13c-d1884b8e02be_17369820517619', 'Totam itaque laborum rem et reprehenderit.', '2023-07-31 08:28:29', '2024-04-03 15:22:08', 4),
                                                                                                                          (81, 'Small Steel Bag', 20.97, 'efb4bf84-23c6-4079-a7d2-e8725ceeb21f_17384358587905', 'Nisi qui libero non maxime voluptatem non et.', '2023-07-31 08:28:29', '2024-04-03 15:22:23', 4);
-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
                                  `id` int NOT NULL,
                                  `product_id` int DEFAULT NULL,
                                  `image_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`) VALUES
                                                                   (8, 1, 'f2fcda26-8304-48bc-9472-ead1c297770f_001.jpg'),
                                                                   (9, 1, '0d83d40d-78e9-4c7d-80ee-3b5b68003104_002.jpg'),
                                                                   (10, 1, 'cbef6f33-b6b7-45e0-ac44-f1a0b5fe1d4c_003.jpg'),
                                                                   (11, 1, 'f0a765f0-4d20-4067-b7d7-fa32439deb1a_004.jpg'),
                                                                   (12, 1, '31dee6df-712c-4fc4-82bb-b9edd48df24b_005.jpg'),
                                                                   (13, 1, 'aabdceb6-c8de-43aa-9d3f-c2fe6d113ef2_006.jpg'),
                                                                   (14, 2, '34823684-2d69-4e22-8ad6-aa2bc1ccbaf6_006.jpg'),
                                                                   (15, 2, '5815f773-c836-464e-a857-ef03d465390e_007.jpg'),
                                                                   (16, 2, 'e0dc71cb-b492-4aad-a9da-5b864eb9419d_008.jpg'),
                                                                   (17, 2, 'a1846d28-2fa2-41a6-bcc3-59585be39d78_009.jpg'),
                                                                   (18, 2, '77c00c01-9f8e-40cc-882c-a1f8e6d30368_010.jpg'),
                                                                   (19, 3, 'c4bd25e4-620c-44fc-9f69-22edde299a8f_011.jpg'),
                                                                   (20, 3, '5f0bdbc4-64d5-4114-b590-7c85503a9174_012.jpg'),
                                                                   (21, 3, 'f139045a-ef18-4aa3-9484-e06721d9150c_013.jpg'),
                                                                   (22, 3, 'b83bafb2-81b2-45be-a07f-fe610b7be9b8_014.jpg'),
                                                                   (23, 3, '4619bde9-9395-4850-a43a-6ed958714e03_015.jpg'),
                                                                   (24, 5, '6ba6318c-ed8b-4f6d-9a9b-d8ca1c6e1afc_016.jpg'),
                                                                   (25, 5, 'b5d21126-2dd3-42bb-80dd-8f79d999d29c_017.jpg'),
                                                                   (26, 5, 'f8a83202-74a6-4386-99db-3ef713a26471_016.jpg'),
                                                                   (27, 5, '0661c814-b39c-47ab-958f-9465679eeb9b_017.jpg'),
                                                                   (28, 7, '3036dff0-72cd-48d4-9efd-7221f41fc61d_022.jpg'),
                                                                   (29, 7, 'cb6259db-e46d-48a5-8b7a-6c46a3b55446_023.jpg'),
                                                                   (30, 7, 'bf379bbd-9e69-4cd6-bc03-d6db54b780b7_024.jpg'),
                                                                   (31, 7, 'e2856261-99af-4494-82fe-bccb1befb22b_025.jpg'),
                                                                   (32, 7, 'ccd11465-f64c-444d-90e1-8862ab71a62c_026.jpg'),
                                                                   (33, 8, '36bf6016-4eff-4864-bf27-1de57e7d6589_027.jpg'),
                                                                   (34, 8, '07175991-c161-48ce-8e66-a0ec093eea50_028.jpg'),
                                                                   (35, 8, 'f92c0523-1b77-4233-bdc9-b8dab47536ed_029.jpg'),
                                                                   (36, 8, 'cd3814e3-0918-440a-bab5-1db67ca4574f_030.jpg'),
                                                                   (37, 8, '35dda624-858d-499d-867e-0260c358e591_031.jpg'),
                                                                   (38, 9, '326235eb-015b-4176-8977-fb96df932557_032.jpg'),
                                                                   (39, 9, 'e950378b-a6ff-40c6-a6b5-b469d841b282_033.jpg'),
                                                                   (40, 9, '4e8a2b84-96b2-49c4-bbcf-2805934a8076_034.jpg'),
                                                                   (41, 9, '95251a5e-7eaa-45e9-9571-04b3247ccfab_035.jpg'),
                                                                   (42, 9, '1178bd64-484b-4e34-84cf-86881d1f8948_036.jpg'),
                                                                   (43, 10, '3d3097a5-38dc-45b7-81be-7300816ab4b9_037.jpg'),
                                                                   (44, 10, '390bbdba-c579-4f5a-a455-59d7dbda9c72_038.jpg'),
                                                                   (45, 10, '29925120-5403-49cc-b85c-922673a0d5ed_039.jpg'),
                                                                   (46, 10, 'd1fef884-a4c1-471b-8fc9-400195436564_040.jpg'),
                                                                   (47, 11, '67dedbd7-d14a-4db0-801f-3ab18fdca6d3_038.jpg'),
                                                                   (48, 11, '3175fef9-b080-4eca-8bc7-e9cc5947c642_039.jpg'),
                                                                   (49, 11, '2c899f27-f467-4ad2-a52e-6e307d8bdfda_040.jpg'),
                                                                   (50, 11, '0e32e381-4cb5-4771-a008-1354a612e763_041.jpg'),
                                                                   (51, 11, 'cad35cbc-fd56-4f4c-b2db-77d04f63a149_042.jpg'),
                                                                   (52, 12, 'cf00f484-f8a4-4b9a-8a9f-ef74bfd7ebcf_045.jpg'),
                                                                   (53, 12, '09443def-0c28-40e1-b18d-f1cc8be05464_046.jpg'),
                                                                   (54, 12, '9fc08b21-eb95-474e-b9c8-9de7bc6360e0_047.jpg'),
                                                                   (55, 12, '813ad44a-a7bd-432a-bddc-b8f9a32b0039_048.jpg'),
                                                                   (56, 12, '356a89f7-ef4d-454d-b2ad-da9f4fdaf6d6_049.jpg'),
                                                                   (57, 13, '862e0948-8961-4c2a-b76a-f2322c846a4b_050.jpg'),
                                                                   (58, 13, '8db6fb15-d24b-4c7f-b61d-c9d3452dd2fe_051.jpg'),
                                                                   (59, 13, 'fbf2c23a-a2c3-48fb-ac69-c8ac4913bfb2_052.jpg'),
                                                                   (60, 13, '25cefd9a-e306-422e-9fbf-8c98141dc81a_053.jpg'),
                                                                   (61, 13, 'ab864e03-25f0-4537-9ca3-1d2bd431a535_054.jpg'),
                                                                   (62, 14, 'd152fdfd-6c49-440c-a249-8fdc08646333_055.jpg'),
                                                                   (63, 14, 'e29ac0a0-8c1f-493f-a66b-6f170de48f94_056.jpg'),
                                                                   (64, 14, '1a384d85-a6a5-47a7-861d-5fb56054829c_057.jpg'),
                                                                   (65, 14, '2cf23264-4685-44d8-a371-41c3e5ad9563_058.jpg'),
                                                                   (66, 14, 'a8a30554-51c9-4a99-9ff4-e25169edc713_059.jpg'),
                                                                   (67, 15, '904a9f1c-207c-4df6-bb49-c954656a8c06_059.jpg'),
                                                                   (68, 15, '5d8fd37f-06a5-4906-9252-61ba564723c1_060.jpg'),
                                                                   (69, 15, '95a13b88-919f-49af-b868-e2bfed0bb98e_061.jpg'),
                                                                   (70, 15, '0ca19870-50b7-4719-82ae-b6b8272d45cd_062.jpg'),
                                                                   (71, 15, '26365791-3978-4df8-b6fd-f2f516b1e7e3_063.jpg'),
                                                                   (72, 16, 'c86bb69d-e5a2-4c93-8f0a-87504a8966ea_064.jpg'),
                                                                   (73, 16, '93b29ad3-b5ab-40c1-ace8-ec069cba2db1_065.jpg'),
                                                                   (74, 16, 'd832472c-856a-4243-bc98-531af0b1a1a5_066.jpg'),
                                                                   (75, 16, '05b3bc62-c8f1-41c3-abd0-3515a1f19ed3_067.jpg'),
                                                                   (76, 16, 'ee6f30dc-68de-4c8a-bfd7-62df2ed20d22_068.jpg'),
                                                                   (77, 17, 'dafed832-a59c-41ad-bc60-011fadaf8020_069.jpg'),
                                                                   (78, 17, '65cf789d-ed86-4fd7-8030-2a79af81a88b_070.jpg'),
                                                                   (79, 17, 'a2ac276a-5384-4646-ad52-ad00b731cc9b_080.jpg'),
                                                                   (80, 17, '665a59de-01f1-4a4f-870e-4fc64a43f384_081.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
                         `id` int NOT NULL,
                         `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
                                       (1, 'user'),
                                       (2, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `social_accounts`
--

CREATE TABLE `social_accounts` (
                                   `id` int NOT NULL,
                                   `provider` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tên nhà social network',
                                   `provider_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Email tài khoản',
                                   `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tên người dùng',
                                   `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
                          `id` int NOT NULL,
                          `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `token_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `expiration_date` datetime DEFAULT NULL,
                          `revoked` tinyint(1) NOT NULL,
                          `expired` tinyint(1) NOT NULL,
                          `user_id` int DEFAULT NULL,
                          `is_mobile` tinyint(1) DEFAULT '0',
                          `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                          `refresh_expiration_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `token`, `token_type`, `expiration_date`, `revoked`, `expired`, `user_id`, `is_mobile`, `refresh_token`, `refresh_expiration_date`) VALUES
                                                                                                                                                                    (7, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDAxODIzMX0.mA1bofNECAkMWbZqK0h_WJgVqlTOjfd5XoAiDAqAy7w', 'Bearer', '2023-12-31 10:23:51', 0, 0, 5, 1, '', NULL),
                                                                                                                                                                    (16, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcwNDI1NjM2MH0.U6A4ed5dxRAzMxwHluiR0-_Rxm0ngXfZ1RN-VaW_OpY', 'Bearer', '2024-01-03 04:32:40', 0, 0, 3, 0, '8caf32df-69e8-4489-9716-4e2a2944a1a8', '2024-02-02 04:32:40'),
                                                                                                                                                                    (29, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc1MTR9.B3iHckT44zN8zG3clXsURaemqWvfz7HJkR-e9b9VCo0', 'Bearer', '2024-01-08 09:51:55', 0, 0, 8, 0, '9cd17548-6634-43c4-a0a6-376266413e68', '2024-02-07 09:51:55'),
                                                                                                                                                                    (32, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc2MTV9.CkOUQe1k7XFjLfiMJgB7VLvVnZnEfkASP0cc7eVAJtQ', 'Bearer', '2024-01-08 09:53:35', 0, 0, 8, 0, '94ac5e7b-abaa-40d7-90df-0a044b7c705c', '2024-02-07 09:53:35'),
                                                                                                                                                                    (34, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc4NzN9.NzGHRwdw9f1mK6OTe4a8Jsg6xdedeqoAQRb1FZO19Vo', 'Bearer', '2024-01-08 09:57:53', 0, 0, 8, 0, 'c9544702-4ea7-403a-9914-4159f952287a', '2024-02-07 09:57:53'),
                                                                                                                                                                    (36, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcxNDU3NzAzOX0.kUc3YxjaqapBxQPkkIypt1Gf7bXPtdSzDxgXm8eChAk', 'Bearer', '2024-05-01 15:23:59', 0, 0, 3, 0, '5f2b69da-c916-4996-8076-d4ccce4d4e47', '2024-05-31 15:23:59'),
                                                                                                                                                                    (39, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcxNDc4NDU1MH0.HZBuTKqBLEh2rweZisJUK9HFVFr2F37cgnm7i7rS8L4', 'Bearer', '2024-05-04 01:02:30', 0, 0, 5, 0, '2c4d8068-ba94-4a76-adfb-e4bd8ffc6f62', '2024-06-03 01:02:30'),
                                                                                                                                                                    (40, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcxNDc4NzE1M30.WepQFV6lcT92A1fvg2dlPsVW5MP_CY0rwQOcWVnNNHE', 'Bearer', '2024-05-04 01:45:54', 0, 0, 5, 0, '286231b8-4101-4cb7-9d4f-3e1aa0a2cfa2', '2024-06-03 01:45:55'),
                                                                                                                                                                    (41, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcxNDc5MjMzNn0.dH98q5AEWZ7O1Q1SwyJuoh0a_j8WUBODNjsx8YZJLwY', 'Bearer', '2024-05-04 03:12:17', 0, 0, 3, 0, 'fe8496c5-ac15-4e36-ae8c-b073d12440b7', '2024-06-03 03:12:17'),
                                                                                                                                                                    (42, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjIyMzQ1Njc4OSIsInVzZXJJZCI6OSwic3ViIjoiMjIzNDU2Nzg5IiwiZXhwIjoxNzE1MTMzMjQyfQ.6xCbsNB32uG1B8DcZgNdWmhdSs5yR2ES20VY-NQGqZY', 'Bearer', '2024-05-08 01:54:37', 0, 0, 9, 0, '13877d61-2e2c-4ff0-bfcb-e69fd07445f1', '2024-06-07 01:54:40'),
                                                                                                                                                                    (43, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjIyMzQ1Njc4OSIsInVzZXJJZCI6OSwic3ViIjoiMjIzNDU2Nzg5IiwiZXhwIjoxNzE1MTMzNjE0fQ.14D1r9SD6w0i6yOfZusswA1UcelifIiauY3A5sBAQQI', 'Bearer', '2024-05-08 02:00:19', 0, 0, 9, 0, 'e553f265-72b0-4166-8000-97415562a7b9', '2024-06-07 02:00:19'),
                                                                                                                                                                    (44, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IiIsInVzZXJJZCI6MTAsInN1YiI6IiIsImV4cCI6MTcxNTEzMzg4NX0.ovc4JV7LWNyMNbpzgzJ9I0UQNjEBrfgtvcbNr5aJ_w0', 'Bearer', '2024-05-08 02:04:45', 0, 0, 10, 0, '72db5faf-dd9d-4cca-896f-8e5d3b187808', '2024-06-07 02:04:45'),
                                                                                                                                                                    (45, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5MTIzMTU0NjMiLCJ1c2VySWQiOjExLCJzdWIiOiIwOTEyMzE1NDYzIiwiZXhwIjoxNzE1MTMzOTA3fQ.XT8LCwssGPxi0Liv5IS_c1v630gWhRstT1A0T6u68xY', 'Bearer', '2024-05-08 02:05:07', 0, 0, 11, 0, '592b1b94-3801-481f-8135-8b9cf507eca9', '2024-06-07 02:05:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
                         `id` int NOT NULL,
                         `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                         `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
                         `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                         `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `created_at` datetime DEFAULT NULL,
                         `updated_at` datetime DEFAULT NULL,
                         `is_active` tinyint(1) DEFAULT '1',
                         `date_of_birth` date DEFAULT NULL,
                         `facebook_account_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                         `google_account_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                         `role_id` int DEFAULT '1',
                         `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
                         `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `fullname`, `phone_number`, `address`, `password`, `created_at`, `updated_at`, `is_active`, `date_of_birth`, `facebook_account_id`, `google_account_id`, `role_id`, `email`, `profile_image`) VALUES
                                                                                                                                                                                                                             (2, 'Nguyễn Văn A', '012456878', 'Nhà a ngõ b', '$2a$10$WdSf5UuyxQMAHcO502qXredzcc8OZQo4XQZNp3UxeT6/bKbuJx/6y', '2023-08-03 05:36:11', '2023-08-03 05:36:11', 1, '1999-10-25', '0', '0', 2, '', ''),
                                                                                                                                                                                                                             (3, 'Tài khoản admin 1', '11223344', 'Đây là admin nhé', '$2a$10$JFQT3HeFUKDl7c/l.iNFAeybFr7Wi3krwgVVR7ieif.2De5p9LGAG', '2023-08-06 00:34:35', '2023-08-06 00:34:35', 1, '1993-10-25', '0', '0', 2, '', ''),
                                                                                                                                                                                                                             (5, 'Nguyễn Văn test 11', '33445566', 'Nhà a ngõ b 11', '$2a$10$e95NOMrOFFpfhWibOpAw/uJrqfsBuJ9O3xNgZAP6vnHTh5QHvgliu', '2023-08-08 03:02:48', '2023-11-16 01:05:34', 1, '2000-10-25', '2', '3', 1, '', ''),
                                                                                                                                                                                                                             (7, 'Nguyen Van Y', '123456789', 'Đây là user', '$2a$10$oZwu2RA2iiNVIaQZgdi7bueKc5YNWr39yu.gXdsavBzo5AOb1kP5e', '2023-11-16 00:52:29', '2023-11-16 00:52:29', 1, '2000-10-25', '0', '0', 1, '', ''),
                                                                                                                                                                                                                             (8, 'Nguyen Duc Hoang-user', '0964896239', 'Bach mai, hanoi, vietnam', '$2a$10$cGkVz4/65tDn2M33Gx3GYOC3DKrRni4SK/m1So0rpIXQFiG/ltM5G', '2023-12-09 08:27:38', '2023-12-09 08:27:38', 1, '1979-10-25', '0', '0', 1, '', ''),
                                                                                                                                                                                                                             (9, 'John Smith', '223456789', 'This is John\'s address', '$2a$10$D2oH8EXb6EQE.fqqLJIgp.HAmrRuye7zAGE6ZZba.vMoqeB07Ck92', '2024-04-08 01:46:39', '2024-04-08 01:46:39', 1, '1999-10-23', '0', '0', 1, 'johnsmith23@gmail.com', ''),
                                                                                                                                                                                                                             (10, 'Sataya Nadella', '', 'This is an address somewhere in the world', '$2a$10$YwKrw4jnYBV0q6qO6tFLaOVCXze1xhQmmNaLAd.EHrWTgb5bezB5.', '2024-04-08 02:02:12', '2024-04-08 02:02:12', 1, '1994-12-23', '0', '0', 1, 'sndadella@yahoo.com', ''),
                                                                                                                                                                                                                             (11, 'Steve Karen', '0912315463', 'This is also an address', '$2a$10$0ox5U8d5oiiKPbwNxNpIVOmvjwPAa3L/gTTedxZUhNrjLgFEqApoa', '2024-04-08 02:03:47', '2024-04-08 02:03:47', 1, '2000-02-23', '0', '0', 1, '', ''),
                                                                                                                                                                                                                             (12, 'Anna Almira', '', 'This is Almira\'s address', '$2a$10$o4MhIuw4l4VreLhK1dMjPeMnPW9SLpnABLE.VhlUFXg0gQ/WvrW/u', '2024-04-10 00:14:34', '2024-04-10 00:14:34', 1, '1998-05-11', '0', '0', 2, 'almira11@gmail.com', ''),
                                                                                                                                                                                                                             (13, 'Nguyen Duc Hoang', NULL, NULL, '', '2024-10-21 12:12:20', '2024-10-21 12:12:20', 1, NULL, NULL, '109206896373059398029', 1, 'sunlight4d@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJk8mHN-yp09zEIC9SooVoMVW8DuYxpKtziw7WOpXwHrsYT0IfzVA=s96-c');
ALTER TABLE `categories`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
    ADD PRIMARY KEY (`id`),
    ADD KEY `product_id` (`product_id`),
    ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupon_conditions`
--
ALTER TABLE `coupon_conditions`
    ADD PRIMARY KEY (`id`),
    ADD KEY `coupon_id` (`coupon_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
    ADD PRIMARY KEY (`id`),
    ADD KEY `user_id` (`user_id`),
    ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `flyway_schema_history`
--
ALTER TABLE `flyway_schema_history`
    ADD PRIMARY KEY (`installed_rank`),
    ADD KEY `flyway_schema_history_s_idx` (`success`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
    ADD PRIMARY KEY (`id`),
    ADD KEY `user_id` (`user_id`),
    ADD KEY `fk_orders_coupon` (`coupon_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
    ADD PRIMARY KEY (`id`),
    ADD KEY `order_id` (`order_id`),
    ADD KEY `product_id` (`product_id`),
    ADD KEY `fk_order_details_coupon` (`coupon_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
    ADD PRIMARY KEY (`id`),
    ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
    ADD PRIMARY KEY (`id`),
    ADD KEY `fk_product_images_product_id` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_accounts`
--
ALTER TABLE `social_accounts`
    ADD PRIMARY KEY (`id`),
    ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `token` (`token`),
    ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`),
    ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_conditions`
--
ALTER TABLE `coupon_conditions`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5781;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=637;

--
-- AUTO_INCREMENT for table `social_accounts`
--
ALTER TABLE `social_accounts`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
    ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
    ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `coupon_conditions`
--
ALTER TABLE `coupon_conditions`
    ADD CONSTRAINT `coupon_conditions_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`);

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
    ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
    ADD CONSTRAINT `fk_orders_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
    ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
    ADD CONSTRAINT `fk_order_details_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
    ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
    ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
    ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
    ADD CONSTRAINT `fk_product_images_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `social_accounts`
--
ALTER TABLE `social_accounts`
    ADD CONSTRAINT `social_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
    ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
    ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
