-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 24-12-2023 a las 14:32:11
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agora`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `idEvent` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idLocation` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `dateTime` datetime NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`idEvent`),
  KEY `idUser` (`idUser`),
  KEY `idLocation` (`idLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Volcado de datos para la tabla `event`
--

INSERT INTO `event` (`idEvent`, `idUser`, `idLocation`, `name`, `dateTime`, `description`) VALUES
(1, 2, 2, 'Patinar', '2023-12-16 16:29:41', 'Ir al polideportivo a patinar'),
(2, 2, 3, 'Cine', '2023-12-21 18:00:00', 'Ir al cine a ver la peli Wonka'),
(4, 2, 1, 'comer con la familia', '2024-01-05 13:29:00', 'comer con la familia'),
(6, 2, 2, 'Leer en cafetería', '2023-12-21 16:13:00', 'Leer en la cafeteria\r\n'),
(7, 2, 1, 'Juegos de mesa', '2023-12-30 21:18:00', 'Jugar a juegos de mensa'),
(8, 2, 2, 'Taller de poesía', '2023-12-18 16:21:00', 'Taller de poesia al aire libre'),
(9, 2, 1, 'Cena de Navidad', '2023-12-24 18:01:00', 'Cenar para Navidad'),
(10, 2, 1, 'Pipas', '2023-12-26 12:48:00', 'Quedar para comer pipas'),
(11, 2, 2, 'Comer', '2024-01-05 15:43:00', 'comer con la familia'),
(12, 2, 1, 'Alpinismo', '2023-12-27 08:48:00', 'alpinismo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `idLocation` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`idLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Volcado de datos para la tabla `location`
--

INSERT INTO `location` (`idLocation`, `name`) VALUES
(1, 'Alcobendas'),
(2, 'San Sebastián de los Reyes'),
(3, 'Alcorcón');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participants`
--

DROP TABLE IF EXISTS `participants`;
CREATE TABLE IF NOT EXISTS `participants` (
  `idParticipants` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idEvent` int NOT NULL,
  PRIMARY KEY (`idParticipants`),
  KEY `idUser` (`idUser`),
  KEY `idEvent` (`idEvent`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Volcado de datos para la tabla `participants`
--

INSERT INTO `participants` (`idParticipants`, `idUser`, `idEvent`) VALUES
(1, 2, 10),
(2, 3, 10),
(3, 3, 10),
(4, 3, 10),
(5, 3, 9),
(6, 3, 1),
(7, 2, 2),
(8, 2, 12),
(9, 2, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `age` varchar(50) NOT NULL,
  `secretToken` varchar(100) NOT NULL,
  `idLocation` int NOT NULL,
  PRIMARY KEY (`idUser`),
  KEY `idLocation` (`idLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`idUser`, `name`, `password`, `age`, `secretToken`, `idLocation`) VALUES
(2, 'eva', 'eva', '28', '12345679076', 1),
(3, 'Axel', 'axel', '26', 'asdfg', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  ADD CONSTRAINT `event_ibfk_2` FOREIGN KEY (`idLocation`) REFERENCES `location` (`idLocation`);

--
-- Filtros para la tabla `participants`
--
ALTER TABLE `participants`
  ADD CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  ADD CONSTRAINT `participants_ibfk_2` FOREIGN KEY (`idEvent`) REFERENCES `event` (`idEvent`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`idLocation`) REFERENCES `location` (`idLocation`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
