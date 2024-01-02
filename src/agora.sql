-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-01-2024 a las 15:51:22
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `event`
--

INSERT INTO `event` (`idEvent`, `idUser`, `idLocation`, `name`, `dateTime`, `description`) VALUES
(16, 8, 3, 'Juegos de mesa', '2024-01-07 11:30:00', 'Juegos de mesa en el bar del pueblo'),
(18, 9, 1, 'Patinaje sobre hielo', '2024-01-09 18:30:00', 'Patinar en la nueva pista del poli'),
(19, 7, 6, 'Plan bolera', '2024-01-02 20:09:00', 'Ir a la bolera con los colegas'),
(20, 10, 7, 'Chocolate', '2024-01-19 17:30:00', 'Tomar chocolate con churros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `idLocation` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`idLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `location`
--

INSERT INTO `location` (`idLocation`, `name`) VALUES
(1, 'Alcobendas'),
(2, 'San Sebastián de los Reyes'),
(3, 'Alcorcón'),
(4, 'Getafe'),
(5, 'Torrejón de Ardoz'),
(6, 'Algete'),
(7, 'Barajas'),
(8, 'Madrid Capital'),
(9, 'Villaverde'),
(10, 'Parla'),
(11, 'Tres Cantos');

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `participants`
--

INSERT INTO `participants` (`idParticipants`, `idUser`, `idEvent`) VALUES
(22, 8, 16),
(25, 9, 16),
(27, 9, 18),
(28, 7, 18),
(29, 7, 19),
(30, 10, 19),
(31, 10, 20);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`idUser`, `name`, `password`, `age`, `secretToken`, `idLocation`) VALUES
(7, 'eva', 'eva', '28', '45dc0136-2e6d-441c-ba13-e4835cea2fcf', 1),
(8, 'bob', 'bob', '24', '05a0d3bc-4384-435a-9a22-ad954fe1e6d3', 3),
(9, 'ana', 'ana', '30', '9709a420-a1f1-4d87-a0a6-f357bda9a039', 5),
(10, 'nuria', 'nuria', '20', '61a3e226-9908-4881-ba02-9eae96ca0174', 7);

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
