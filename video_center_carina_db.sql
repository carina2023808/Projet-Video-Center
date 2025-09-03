-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 03, 2025 at 07:48 AM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `video_center_carina_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250730181600', '2025-07-30 18:16:50', 45),
('DoctrineMigrations\\Version20250730182711', '2025-07-30 18:27:31', 33),
('DoctrineMigrations\\Version20250731191409', '2025-07-31 19:14:27', 127),
('DoctrineMigrations\\Version20250731192041', '2025-07-31 19:20:52', 99),
('DoctrineMigrations\\Version20250812202645', '2025-08-12 20:28:37', 149),
('DoctrineMigrations\\Version20250812204516', '2025-08-12 20:45:30', 70),
('DoctrineMigrations\\Version20250827104235', '2025-08-27 10:43:18', 135),
('DoctrineMigrations\\Version20250828125822', '2025-08-28 12:59:02', 262);

-- --------------------------------------------------------

--
-- Table structure for table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reset_password_request`
--

INSERT INTO `reset_password_request` (`id`, `user_id`, `selector`, `hashed_token`, `requested_at`, `expires_at`) VALUES
(5, 6, 'owXSzA6otl05QcOLrpVi', '+YqkT5dTgyI89Pg0OkN6zn1/ZiSSRvnjaAjqrfo4z90=', '2025-09-03 07:24:07', '2025-09-03 08:24:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_size` int DEFAULT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `is_verified`, `image_name`, `image_size`, `created_at`, `updated_at`) VALUES
(1, 'carina@cfitech.be', '[]', '$2y$13$5Y3vdnsexLpNGeOeVSNUZ.sxOeyUkMMVTy5vNN2AUJSKv0N9FislG', 'Carina', 'José', 1, 'profil.png', NULL, '2025-08-14 13:35:35', '2025-08-14 13:35:35'),
(2, 'ericaR@cfitech.be', '[]', '$2y$13$shJCWRrRdQ88VXxppuiBpuspI3Um7ZeE7kH6xZeqZuBwpM81DaDd.', 'Erica', 'Rodrigues', 1, 'erica-68b141fdcb4d3711283622.avif', 42759, '2025-08-27 11:34:42', '2025-09-02 07:05:09'),
(3, 'mike@cfitech.be', '[]', '$2y$13$7eaXqi.7Ah0VYPJ5ApqAaOJUIpnnR5FnnC1riY572uKZRidKR1sLi', 'Cfiteh', 'Mike', 0, 'plateau-nicois-2-68b6a619bdde9861728338.jpg', 909027, '2025-08-28 10:54:50', '2025-09-02 08:08:57'),
(4, 'say@cfitech.be', '[]', '$2y$13$QVeUlF9dyH1z/4QY/rAsJe9N1fjKdSBspIlj1R61zqtUQ3Stba.cu', 'Cfiteh', 'Say', 0, 'profil.png', NULL, '2025-08-28 11:01:19', '2025-08-28 11:01:19'),
(5, 'alex@cfitech.com', '[]', '$2y$13$ZKAl4C1BwqJK3U4n9fH1ye5Kc6Zktx3LTztBBGmDE6zDiKlCjC73S', 'Alex', 'Sales', 1, 'say-68b1c9023f2b6033562219.jpg', 78237, '2025-08-29 09:57:36', '2025-08-29 15:36:34'),
(6, 'JUlien@cfitech.be', '[]', '$2y$13$IVnmVXOLmPxI0FmQ6O.dIOeyjylxptEXi8T6V.J96o7cLJQWt676S', 'Julien', 'Dunian', 0, '28-68b7edde2b10f331316090.jpg', 49504, '2025-09-03 07:20:02', '2025-09-03 07:27:26');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_link` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `premium_video` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29AA6432A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `premium_video`, `user_id`) VALUES
(1, 'My Play list', 'https://www.youtube.com/embed/tRZi1QJ-AfQ', 'Adele, Ed Sheeran, Maroon 5, Rihanna, Bruno Mars, The Weeknd, Dua Lipa,  Rihanna 🎧Top 100 songs 2025', '2025-08-27 10:52:42', '2025-08-27 12:01:09', 0, 1),
(2, 'Cours PHP', 'https://www.youtube.com/embed/TfsO0BGvGn0', '1er cours PHP pour débutants, introduction', '2025-08-29 12:10:09', '2025-08-29 12:10:53', 1, 1),
(3, 'cours débutant PHP #2', 'https://www.youtube.com/embed/F7KzJ7e6EAc', 'cours débutant #2', '2025-08-29 12:17:20', '2025-08-29 12:17:20', 0, 1),
(4, 'cours débutant #3', 'https://www.youtube.com/embed/3ltZBbKACh4', 'cours débutant #3', '2025-08-29 12:40:36', '2025-08-29 12:40:36', 0, 1),
(5, 'cours débutant #4', 'https://www.youtube.com/embed/Z3IynOovSik', 'cours débutant #4', '2025-08-29 12:47:51', '2025-08-29 12:47:51', 0, 1),
(6, 'Histoire Java', 'https://www.youtube.com/embed/sTX0UEplF54', 'cours débutant #1', '2025-08-29 12:53:51', '2025-08-29 12:53:51', 0, 5),
(7, 'Exercicies Java 01', 'https://www.youtube.com/embed/ZBKxhnqX-Q0', 'Exercices Java partie 1', '2025-08-29 12:55:30', '2025-08-29 12:55:30', 1, 5),
(8, 'Exercicies Java 02', 'https://www.youtube.com/embed/bIXDystGxj0', 'cours débutant Java Exercicies 02', '2025-08-29 12:56:55', '2025-08-29 12:56:55', 0, 5),
(9, 'Exercicies Java 03', 'https://www.youtube.com/embed/gsp1H0-FVGI', 'cours débutant Java Exercicies 03', '2025-08-29 12:58:02', '2025-08-29 12:58:02', 1, 5),
(11, 'TestVideo', 'https://www.youtube.com/embed/sTX0UEplF54', 'qsdfghjklpoç!uhb', '2025-08-29 15:34:59', '2025-08-29 15:34:59', 0, 5),
(12, 'Massacre dans un camps de scouts en Oklahoma', 'https://www.youtube.com/embed/wl9y8UdH9WY', 'qsfdfjkiomù^p^rezqchjkloà§èty', '2025-09-01 11:00:06', '2025-09-01 11:01:40', 1, 2),
(13, 'Le massacre de la famille Gruber sur la ferme Hint', 'https://www.youtube.com/embed/QOJlnMc3NSc', 'Le massacre de la famille Gruber sur la ferme Hinterkaifeck', '2025-09-01 11:02:25', '2025-09-01 11:02:25', 1, 2),
(14, 'Our encounter with poltergeist of the real  conjur', 'https://www.youtube.com/embed/QN6pjqEPmPY', 'Our encounter with poltergeist of the real  conjuring house', '2025-09-01 11:02:50', '2025-09-01 11:02:50', 0, 2),
(15, 'J’ai visitée l’île de Princesse Mononoké au Japon!', 'https://www.youtube.com/embed/W07bukS6xPc', 'J’ai visitée l’île de Princesse Mononoké au Japon! | EP.3', '2025-09-02 08:24:52', '2025-09-02 08:24:52', 1, 2),
(16, 'J\'ai dormi dans une maison HANTÉE au Japon | EP.2', 'https://www.youtube.com/embed/lF_2UEMVWIE', 'J\'ai dormi dans une maison HANTÉE au Japon | EP.2', '2025-09-02 08:25:35', '2025-09-02 08:25:35', 1, 2),
(17, 'Mon road trip au Japon tourne mal | EP.1', 'https://www.youtube.com/embed/hKAucSW1l7A', 'Mon road trip au Japon tourne mal | EP.1', '2025-09-02 08:26:00', '2025-09-02 08:26:00', 0, 2),
(18, 'Living in London | spring in the city, outfits of ', 'https://www.youtube.com/embed/4Lzhzl9E81U', 'Living in London | spring in the city, outfits of the week', '2025-09-02 08:26:30', '2025-09-02 08:26:30', 1, 2),
(19, 'My First Trip to Kauai, Hawaii (the most beautiful', 'https://www.youtube.com/embed/_ns9pSkMpU0', 'My First Trip to Kauai, Hawaii (the most beautiful island)', '2025-09-02 08:26:55', '2025-09-02 08:26:55', 1, 2),
(20, 'What Are People Wearing in New York?', 'https://www.youtube.com/embed/nygP5RV3jRI', 'What Are People Wearing in New York? (Fashion Trends 2025 NYC Summe...', '2025-09-02 08:27:36', '2025-09-02 08:27:36', 0, 2),
(21, 'Try On Fall Clothing Haul', 'https://www.youtube.com/embed/lRvxMbSCYYw', 'Try On Fall Clothing Haul | wardrobe essentials, accessories, shoes...', '2025-09-02 08:28:05', '2025-09-02 08:28:22', 0, 2),
(24, 'Symfony for beginners', 'https://www.youtube.com/embed/TfsO0BGvGn0', 'qsdfghjklmùpç!è§(\'', '2025-09-02 14:40:36', '2025-09-02 14:40:36', 1, 2);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_29AA6432A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
