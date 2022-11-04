-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Nov 04, 2022 at 07:49 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `main`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_subscribers`
--

CREATE TABLE `audit_subscribers` (
                                     `id` int UNSIGNED NOT NULL,
                                     `subscriber_name` text NOT NULL,
                                     `action_performed` text NOT NULL,
                                     `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `audit_subscribers`
--

INSERT INTO `audit_subscribers` (`id`, `subscriber_name`, `action_performed`, `date_added`) VALUES
                                                                                                (1, 'jadzia', 'Inser new subscriber', '2022-10-31 20:44:32'),
                                                                                                (2, 'jadzia', 'Deleted a subscriber', '2022-11-03 16:24:47'),
                                                                                                (3, 'jadzia', 'Inser new subscriber', '2022-11-03 16:27:13'),
                                                                                                (4, 'jadzia2', 'Updated a subscriber', '2022-11-03 16:27:22'),
                                                                                                (5, 'xsa', 'Inser new subscriber', '2022-11-03 17:30:00'),
                                                                                                (6, 'xsaxa', 'Inser new subscriber', '2022-11-03 17:30:47'),
                                                                                                (7, 'jadzia22', 'Updated a subscriber', '2022-11-03 17:41:52'),
                                                                                                (8, 'jadzia223', 'Updated a subscriber', '2022-11-03 17:42:42'),
                                                                                                (9, 'xsaxsa', 'Updated a subscriber', '2022-11-03 17:42:55'),
                                                                                                (10, 'xsaxa', 'Updated a subscriber', '2022-11-03 17:47:32'),
                                                                                                (11, 'xsaxa', 'Deleted a subscriber', '2022-11-03 17:54:09'),
                                                                                                (12, 'wafel', 'Inser new subscriber', '2022-11-03 17:54:22'),
                                                                                                (13, 'wafel', 'Deleted a subscriber', '2022-11-03 17:55:04'),
                                                                                                (14, 'Piotr', 'Inser new subscriber', '2022-11-03 17:55:09'),
                                                                                                (15, 'nowy', 'Inser new subscriber', '2022-11-04 07:17:15');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
                               `id` int UNSIGNED NOT NULL,
                               `fname` text NOT NULL,
                               `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `fname`, `email`) VALUES
                                                       (2, 'jadzia223', 'jadzia@op.pl'),
                                                       (3, 'xsaxsa', 'cos@p.pl'),
                                                       (6, 'Piotr', 'piotr@pakulski.net'),
                                                       (7, 'nowy', 'nowy@op.pl');

--
-- Triggers `subscribers`
--
DELIMITER $$
CREATE TRIGGER `after_subscriber_delete` AFTER DELETE ON `subscribers` FOR EACH ROW INSERT INTO audit_subscribers(subscriber_name, action_performed)
                                                                                    VALUES(old.fname, 'Deleted a subscriber')
                                                                                        $$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_subscriber_edit` AFTER UPDATE ON `subscribers` FOR EACH ROW INSERT INTO audit_subscribers(subscriber_name, action_performed)
                                                                                  VALUES(new.fname, 'Updated a subscriber')
                                                                                      $$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_subscriber_insert` BEFORE INSERT ON `subscribers` FOR EACH ROW INSERT INTO audit_subscribers(subscriber_name, action_performed)
                                                                                      VALUES(new.fname, 'Inser new subscriber')
                                                                                          $$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscribers_added`
-- (See below for the actual view)
--
CREATE TABLE `subscribers_added` (
                                     `id` int unsigned
    ,`name` text
    ,`email` text
    ,`date_added` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscribers_all`
-- (See below for the actual view)
--
CREATE TABLE `subscribers_all` (
                                   `id` int unsigned
    ,`name` text
    ,`email` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscribers_deleted`
-- (See below for the actual view)
--
CREATE TABLE `subscribers_deleted` (
                                       `id` int unsigned
    ,`name` text
    ,`date_deleted` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscribers_deleted_added`
-- (See below for the actual view)
--
CREATE TABLE `subscribers_deleted_added` (
                                             `id` int unsigned
    ,`name` text
    ,`deleted` timestamp
    ,`added` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscribers_edited`
-- (See below for the actual view)
--
CREATE TABLE `subscribers_edited` (
                                      `id` int unsigned
    ,`name` text
    ,`email` text
    ,`date_edited` timestamp
);

-- --------------------------------------------------------

--
-- Structure for view `subscribers_added`
--
DROP TABLE IF EXISTS `subscribers_added`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `subscribers_added` (`id`, `name`, `email`, `date_added`) AS    select `t1`.`id` AS `id`,`t1`.`fname` AS `fname`,`t1`.`email` AS `email`,`t2`.`date_added` AS `date_added` from (`subscribers` `t1` join `audit_subscribers` `t2` on(((`t2`.`subscriber_name` = `t1`.`fname`) and (`t2`.`action_performed` = 'Inser new subscriber'))))   ;

-- --------------------------------------------------------

--
-- Structure for view `subscribers_all`
--
DROP TABLE IF EXISTS `subscribers_all`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `subscribers_all` (`id`, `name`, `email`) AS    select `subscribers`.`id` AS `id`,`subscribers`.`fname` AS `fname`,`subscribers`.`email` AS `email` from `subscribers`   ;

-- --------------------------------------------------------

--
-- Structure for view `subscribers_deleted`
--
DROP TABLE IF EXISTS `subscribers_deleted`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `subscribers_deleted` (`id`, `name`, `date_deleted`) AS    select `audit_subscribers`.`id` AS `id`,`audit_subscribers`.`subscriber_name` AS `subscriber_name`,`audit_subscribers`.`date_added` AS `date_added` from `audit_subscribers` where (`audit_subscribers`.`action_performed` = 'Deleted a subscriber')   ;

-- --------------------------------------------------------

--
-- Structure for view `subscribers_deleted_added`
--
DROP TABLE IF EXISTS `subscribers_deleted_added`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `subscribers_deleted_added` (`id`, `name`, `deleted`, `added`) AS    select `t1`.`id` AS `id`,`t1`.`subscriber_name` AS `subscriber_name`,`t1`.`date_added` AS `deleted`,`t2`.`date_added` AS `added` from (`audit_subscribers` `t1` left join `audit_subscribers` `t2` on(((`t2`.`subscriber_name` = `t1`.`subscriber_name`) and (`t2`.`action_performed` = 'Inser new subscriber')))) where (`t1`.`action_performed` = 'Deleted a subscriber')   ;

-- --------------------------------------------------------

--
-- Structure for view `subscribers_edited`
--
DROP TABLE IF EXISTS `subscribers_edited`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `subscribers_edited` (`id`, `name`, `email`, `date_edited`) AS    select `t1`.`id` AS `id`,`t1`.`fname` AS `fname`,`t1`.`email` AS `email`,`t2`.`date_added` AS `date_added` from (`subscribers` `t1` join `audit_subscribers` `t2` on(((`t2`.`subscriber_name` = `t1`.`fname`) and (`t2`.`action_performed` = 'Updated a subscriber'))))   ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_subscribers`
--
ALTER TABLE `audit_subscribers`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_subscribers`
--
ALTER TABLE `audit_subscribers`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;
