-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2021 at 08:58 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `larp`
--

-- --------------------------------------------------------

--
-- Table structure for table `la_users`
--

CREATE TABLE `la_users` (
  `ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Pass` varchar(100) NOT NULL,
  `Discord` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Age` int(11) NOT NULL,
  `RP` varchar(100) NOT NULL,
  `dRP` varchar(200) NOT NULL,
  `dMG` varchar(200) NOT NULL,
  `dPG` varchar(200) NOT NULL,
  `QuizCorrect` int(11) NOT NULL,
  `QuizFalse` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `la_users`
--
ALTER TABLE `la_users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `la_users`
--
ALTER TABLE `la_users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
