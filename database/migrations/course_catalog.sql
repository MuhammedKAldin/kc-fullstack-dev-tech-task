-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Dec 01, 2024 at 08:52 AM
-- Server version: 8.4.3
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `course_catalog`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `parent`) VALUES
('0c1d2e3f-4a5b-6c7d-8e9f-0a1b2c3d4e5f', 'Destinations', '9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e'),
('0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 'Arts & Entertainment', NULL),
('1c2a3b4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'Technology', NULL),
('1d2e3f4a-5b6c-7d8e-9f0a-1b2c3d4e5f6a', 'Travel Tips', '9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e'),
('1f2a3b4c-5d6e-7f8a-9b0c-1d2e3f4a5b6c', 'Visual Arts', '0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b'),
('2a3b4c5d-6e7f-8a9b-0c1d-2e3f4a5b6c7d', 'Performing Arts', '0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b'),
('2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'Software Development', '1c2a3b4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d'),
('3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e', 'Science & Nature', NULL),
('3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f82', 'Hardware Engineering 3', '3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a'),
('3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a', 'Hardware Engineering 2', '2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f'),
('4c5d6e7f-8a9b-0c1d-2e3f-4a5b6c7d8e9f', 'Biology', '3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e'),
('4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b', 'Education', NULL),
('5d6e7f8a-9b0c-1d2e-3f4a-5b6c7d8e9f0a', 'Physics', '3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e'),
('5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f8a9b0c', 'Higher Education', '4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b'),
('6a7b8c9d-0e1f-2a3b-4c5d-6e7f8a9b0c1d', 'K-12 Education', '4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b'),
('6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b', 'Food & Cooking', NULL),
('7b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e', 'Health & Wellness', NULL),
('7f8a9b0c-1d2e-3f4a-5b6c-7d8e9f0a1b2c', 'Recipes', '6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b'),
('8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d', 'Culinary Techniques', '6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b'),
('8c9d0e1f-2a3b-4c5d-6e7f-8a9b0c1d2e3f', 'Fitness & Nutrition', '7b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e'),
('9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e', 'Travel & Tourism', NULL),
('9d0e1f2a-3b4c-5d6e-7f8a-9b0c1d2e3f4a', 'Mental Health', '7b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `image_preview` varchar(255) NOT NULL,
  `category_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `title`, `description`, `image_preview`, `category_id`) VALUES
('L373312762', 'Finance and Accounting Basics for Nonfinancial Executives', 'Financial knowledge is vital to an executive’s role in a business, but the systems within a business can be extremely complex. Without a strong foundation of financial analytics, it can be difficult to interpret, report, or even understand a business’s financial standing. A lack of understanding can impede your ability to make educated decisions. By understanding where the data comes from and how accounting operates, you can manage your business with greater efficiency and interpret business systems more accurately.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373312762/800--v112243.jpg', '4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b'),
('L373319845', 'Financial Statements and Reporting for Nonfinancial Executives', 'Financial statements are a critical part of attracting investors. Financial reports like income statements are the hard proof of how your business is doing. Properly interpreting these statements can provide a stronger understanding of your business’s performance. This can also assist your company when acquiring new investments and making strategic business decisions. Your reliable and precise numbers may encourage shareholders and investors to feel more confident when working with you.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373319845/800--v112244.jpg', '5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f8a9b0c'),
('L373324687', 'Applying Yourself to Diverse and Inclusive Leadership', 'Improving diversity in the workplace requires strategic planning and mindful consideration from everyone involved because inclusion in the workplace is a team effort. When a leader is a participant in change rather than a director, the culture is able to transform with them. Strategies such as improved communication, modeling positivity and adaptability, and building relationships can help make the transition smoother. Effectively changing the culture of a business requires commitment and determination, which is why it’s important to know of leadership strategies that you can use to help you build and maintain a sustainable culture of diversity and equity.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373324687/800--v112241.jpg', '3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f82'),
('L373327593', 'Financial Planning and Analysis for Nonfinancial Executives', 'With constant market fluctuation and an unpredictable supply chain, sometimes it can be difficult to project where your business will be tomorrow. That’s where financial forecasting comes in. The data you have today can be used in various ratios and equations to create helpful financial estimates for your business.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373327593/800--v112245.jpg', '5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f8a9b0c'),
('L373349028', 'Diversity and Inclusion for a Better Business', 'Diversity can seem like a difficult concept to incorporate into the culture of a business. Leaders often view diversity initiatives as important but see them as secondary to the day-to-day operations of a successful business. You may ask yourself, where and how do I start? In this course, we’ll look at many strategies that can help jumpstart diversity and inclusion initiatives. Through these initiatives, we can build stronger relationships that improve the overall business environment and how it functions. These relationships can drive stability, sustainability, and profitability for years to come.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373349028/800--v112240.jpg', '3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a'),
('L373371072', 'Leadership for Identity Diversity', 'As a leader, people of many different backgrounds will look to you for guidance and security in the workplace. The individual identities within a workplace can include individuals from different racial and ethnic backgrounds, individuals with different gender and sexual identities, and individuals with different disabilities. One of the goals of a leader is to create a safe and inclusive environment for all employees. When creating an inclusive environment, it’s important to be aware of who you\'re creating it for and what their individual needs are. Recognizing individuality and implementing inclusion practices benefit everyone and improve your business’s culture.', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373371072/800--v112239.jpg', '3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `category` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
