-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2024 at 10:00 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'Nikhil', '9953300245', 'Hello, I am Nikhil Sharma', '2024-01-31 14:31:12', 'nikhilsharma.csgeek@gmail.com'),
(2, 'Aditya', '9988776655', 'Hi, My Name is Aditya Kacchvey', '2024-01-31 20:33:51', 'aditya@gmail.com'),
(3, 'Aditya', '9988776655', 'Hi, My Name is Aditya Kacchvey', '2024-01-31 20:33:58', 'aditya@gmail.com'),
(4, 'Binod', '8967869566', 'Hi I am Binod', '2024-01-31 21:13:25', 'binod@gmail.com'),
(5, 'Binod Test', '8967869566', 'Chala Ja bsdk', '2024-02-01 10:09:14', 'binod@gmail.com'),
(6, 'Binod Test', '8967869566', 'Chala Ja bsdk', '2024-02-01 10:29:08', 'binod@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` varchar(50) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'Lets learn about CyberSecurity ', 'Why Cybersecurity is a new Hype in the Market?', 'first-post', 'Cybersecurity is the practice of protecting systems, networks, and programs from digital attacks. These cyberattacks are usually aimed at accessing, changing, or destroying sensitive information; extorting money from users via ransomware; or interrupting normal business processes.\r\n\r\nImplementing effective cybersecurity measures is particularly challenging today because there are more devices than people, and attackers are becoming more innovative.', '2024-02-02 15:44:06', 'about-bg.jpg'),
(2, 'What is Python Flask?', 'Flask, a new emerging microwebserver.', 'second-post', 'Flask is a web framework that allows developers to build lightweight web applications quickly and easily with Flask Libraries. It was developed by Armin Ronacher, leader of the International Group of Python Enthusiasts(POCCO). It is basically based on the WSGI toolkit and Jinja2 templating engine.', '2024-02-01 12:50:34', 'home-bg.jpg'),
(3, 'What is SQLAlchemy?', 'Is it important to use SQLAlchemy with Flask? ', 'third-post', 'SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL.\r\nIt provides a full suite of well-known enterprise-level persistence patterns, designed for efficient and high-performing database access, adapted into a simple and Pythonic domain language.', '2024-02-01 13:07:18', ''),
(4, 'What is ReactJS?', 'Why every Organisation is switching with React.js?', 'post-4', 'React is a framework that employs Webpack to automatically compile React, JSX, and ES6 code while handling CSS file prefixes. React is a JavaScript-based UI development library. Although React is a library rather than a language, it is widely used in web development. The library first appeared in May 2013 and is now one of the most commonly used frontend libraries for web development.', '2024-02-04 00:07:53', ''),
(5, 'What is MySQL?', 'The First choice of every DB Developer', 'post-5', 'MySQL is the world’s most popular open-source database. According to DB-Engines, MySQL ranks as the second-most-popular database, behind Oracle Database. MySQL powers many of the most accessed applications, including Facebook, Twitter, Netflix, Uber, Airbnb, Shopify, and Booking.com,etc.\r\n\r\nSince MySQL is open source, it includes numerous features developed in close cooperation with users over more than 25 years. So it’s very likely that your favorite application or programming language is supported by MySQL Database.', '2024-02-04 00:07:20', ''),
(11, 'What is Tailwind CSS?', 'Why every UI Developer must Try Tailwind?', 'post-6', 'Tailwind CSS can be used to style websites in the fastest and easiest way. Tailwind CSS is basically a utility-first CSS framework for rapidly building custom user interfaces. It is a highly customizable, low-level CSS framework that gives you all of the building blocks you need to build bespoke designs without any annoying opinionated styles you have to fight to override.\r\n\r\nThe beauty of this thing called tailwind is it doesn’t impose design specifications or how your site should look, you simply bring tiny components together to construct a user interface that is unique. What Tailwind simply does is take a ‘raw’ CSS file, process this CSS file over a configuration file, and produce an output.', '2024-02-04 14:24:04', ''),
(12, 'What is Bootstrap?', 'The Best Frontend Library to Create Websites!!!', 'post-7', '\r\nBootstrap is a popular front-end framework used for designing and creating responsive and mobile-first websites and web applications. It provides a collection of pre-built design components, such as buttons, forms, navigation bars, and grids, along with CSS and JavaScript-based utilities for layout, typography, and interaction.', '2024-02-04 14:25:58', ''),
(13, 'What is Cloud Computing?', 'Every Software Product needs Cloud Service now. ', 'post-8', 'Cloud computing refers to the delivery of computing services over the internet, enabling users to access and use a wide range of resources and applications without the need for on-premises infrastructure or hardware. Instead of owning and managing physical servers and data centers, users can utilize cloud computing services provided by third-party providers, often referred to as cloud service providers (CSPs).', '2024-02-04 14:27:47', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
