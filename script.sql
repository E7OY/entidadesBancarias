/*
Crear la base de datos entidadesBancarias, Un banco debe tener como minimo mas de un cliente y los clientes tendrán mínimo un banco o varios como máximo, De los bancos interesa guardar el id, nombre, la ciudad de la sucursal central, el numero de clientes que tiene y si tiene sucursales físicas o no.

Cada cliente tiene un id, un nombre, un apellido, una edad y un estado que puede ser; dado de alta o de baja. A parte de esto, interesará guardar la fecha de alta de cada cliente y la fecha de baja en caso de que exista.

Los clientes podrán pedir como mucho un préstamo pero estos pueden ser pedidos por varios clientes que sean titulares de la mima cuenta.

De los prestamos interesará guardar el id, el dia limite del plazo para pagar dicho préstamo, la cantidad y el id del cliente que solicite dicho préstamo.

Cada cliente tiene que abrir una cuenta aunque podrá abrir varias, mientras que las cuentas pueden ser abiertas por varios  clientes ya que mas de un cliente puede ser titular de una misma cuenta. De las cuentas guardaremos el código de cuenta, la cantidad de la que dispondrá la cuenta,, si la cuenta tiene tarjeta física o no y el PIN de la tarjeta en caso de que esta exista.

Los clientes pueden realizar transacciones desde sus cuentas, de las que interesa guardar el id, el tipo de transacción( pudiendo ser solamente transacciones de prestamos, activos, intereses o alquiler) y la cantidad de la transacción. Además interesa guardar la fecha en la que se realiza dicha transacción
*/

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 08-02-2024 a las 11:31:09
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
-- Base de datos: `entidadesbancarias`
--
CREATE DATABASE IF NOT EXISTS `entidadesbancarias` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `entidadesbancarias`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bancos`
--

DROP TABLE IF EXISTS `bancos`;
CREATE TABLE IF NOT EXISTS `bancos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(55) COLLATE utf8mb4_general_ci NOT NULL,
  `ciudad` varchar(55) COLLATE utf8mb4_general_ci NOT NULL,
  `numClientes` int NOT NULL,
  `sucursalFisica` enum('SI','NO') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bancos`
--

INSERT INTO `bancos` (`id`, `nombre`, `ciudad`, `numClientes`, `sucursalFisica`) VALUES
(1, 'Santander', 'Madrid', 159000000, 'SI'),
(2, 'Abanca', 'A Coruña', 100000000, 'SI'),
(3, 'BBVA', 'Madrid', 28000000, 'SI'),
(4, 'Revolut', 'Madrid', 800000, 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bancosclientes`
--

DROP TABLE IF EXISTS `bancosclientes`;
CREATE TABLE IF NOT EXISTS `bancosclientes` (
  `idCliente` int NOT NULL,
  `idBanco` int NOT NULL,
  `fechaAlta` date NOT NULL,
  `fechaBaja` date DEFAULT NULL,
  PRIMARY KEY (`idCliente`,`idBanco`),
  KEY `idBancosTObancosFK` (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bancosclientes`
--

INSERT INTO `bancosclientes` (`idCliente`, `idBanco`, `fechaAlta`, `fechaBaja`) VALUES
(1, 2, '2023-10-03', NULL),
(2, 2, '2024-01-01', NULL),
(3, 4, '2023-03-14', '2024-02-05'),
(4, 1, '2022-07-05', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(55) COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(55) COLLATE utf8mb4_general_ci NOT NULL,
  `edad` int NOT NULL,
  `estado` enum('ALTA','BAJA') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `edad`, `estado`) VALUES
(1, 'Pepe', 'Gomez', 22, 'ALTA'),
(2, 'Luis', 'Mendez', 49, 'ALTA'),
(3, 'Maria', 'Gonzalez', 92, 'BAJA'),
(4, 'Lucia', 'Fernandez', 41, 'ALTA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientescuentas`
--

DROP TABLE IF EXISTS `clientescuentas`;
CREATE TABLE IF NOT EXISTS `clientescuentas` (
  `idCliente` int NOT NULL,
  `codigoCuenta` int NOT NULL,
  `fechaRegistroCuenta` date NOT NULL,
  PRIMARY KEY (`idCliente`,`codigoCuenta`),
  KEY `codigoCuentaTOcuentasFK` (`codigoCuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientescuentas`
--

INSERT INTO `clientescuentas` (`idCliente`, `codigoCuenta`, `fechaRegistroCuenta`) VALUES
(1, 1548, '2023-08-15'),
(1, 2358, '2024-02-01'),
(2, 18936, '2023-12-12'),
(3, 11439, '2022-03-16'),
(4, 5702, '2023-07-31'),
(4, 11439, '2022-03-16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
CREATE TABLE IF NOT EXISTS `cuentas` (
  `codigo` int NOT NULL,
  `cantidad` decimal(14,2) NOT NULL,
  `tarjeta` enum('SI','NO') COLLATE utf8mb4_general_ci NOT NULL,
  `PIN` int DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`codigo`, `cantidad`, `tarjeta`, `PIN`) VALUES
(1548, '129.00', 'SI', 765),
(2358, '3214.00', 'NO', NULL),
(5702, '2154.00', 'SI', 432),
(11439, '18644.00', 'NO', NULL),
(16557, '128796.00', 'SI', 987),
(18936, '3879.00', 'SI', 123);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentastransacciones`
--

DROP TABLE IF EXISTS `cuentastransacciones`;
CREATE TABLE IF NOT EXISTS `cuentastransacciones` (
  `codigoCuenta` int NOT NULL,
  `idTransaccion` int NOT NULL,
  `fechaTransaccion` date NOT NULL,
  PRIMARY KEY (`codigoCuenta`,`idTransaccion`),
  KEY `idTransaccionTOtransaccion` (`idTransaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentastransacciones`
--

INSERT INTO `cuentastransacciones` (`codigoCuenta`, `idTransaccion`, `fechaTransaccion`) VALUES
(2358, 3, '2024-01-01'),
(5702, 2, '2024-02-06'),
(11439, 1, '2024-01-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE IF NOT EXISTS `prestamos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plazoLimite` date NOT NULL,
  `cantidad` decimal(14,2) NOT NULL,
  `idCliente` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idClienteTOclientesFK` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id`, `plazoLimite`, `cantidad`, `idCliente`) VALUES
(1, '2024-02-22', '30000.00', 3),
(2, '2024-05-15', '2000.00', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
CREATE TABLE IF NOT EXISTS `transacciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoTransaccion` enum('PRESTAMOS','ACTIVOS','INTERESES','ALQUILER') COLLATE utf8mb4_general_ci NOT NULL,
  `cantidad` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id`, `tipoTransaccion`, `cantidad`) VALUES
(1, 'ALQUILER', '415.38'),
(2, 'ACTIVOS', '1300.23'),
(3, 'INTERESES', '512.20');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bancosclientes`
--
ALTER TABLE `bancosclientes`
  ADD CONSTRAINT `idBancosTObancosFK` FOREIGN KEY (`idBanco`) REFERENCES `bancos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `idClientesTOclientesFK` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `clientescuentas`
--
ALTER TABLE `clientescuentas`
  ADD CONSTRAINT `codigoCuentaTOcuentasFK` FOREIGN KEY (`codigoCuenta`) REFERENCES `cuentas` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `idCliente1TOclientesFK` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `cuentastransacciones`
--
ALTER TABLE `cuentastransacciones`
  ADD CONSTRAINT `codigoCuentaTOcuenta` FOREIGN KEY (`codigoCuenta`) REFERENCES `cuentas` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `idTransaccionTOtransaccion` FOREIGN KEY (`idTransaccion`) REFERENCES `transacciones` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `idClienteTOclientesFK` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
