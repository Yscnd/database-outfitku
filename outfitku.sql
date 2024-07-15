-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 06:12 PM
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
-- Database: `outfitku`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertDataProduct` (IN `variant` VARCHAR(100), IN `harga` INT)   BEGIN
DECLARE stock INT;
DECLARE status VARCHAR(50);
SELECT Stock INTO stock FROM Produk WHERE ProductName = variant;
IF harga >= 300000 THEN
SET status = 'Mahal';
ELSE
SET status = 'Murah';
END IF;
UPDATE Produk SET Status = status WHERE ProductName = variant;
SELECT * FROM Produk WHERE ProductName = variant;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_produkMahal` ()   BEGIN
SELECT * FROM Produk WHERE Harga >= 300000;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetOrdersByDateAndQuantity` (`minDate` DATE, `minQuantity` INT) RETURNS INT(11)  BEGIN
DECLARE Hitungorder INT;
SELECT COUNT(*) INTO Hitungorder FROM Pesanan 
WHERE OrderDate >= minDate AND Quantity >= minQuantity;
RETURN Hitungorder;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Hitungproduct` () RETURNS INT(11)  BEGIN
DECLARE Hitung INT;
SELECT COUNT(*) INTO Hitung FROM Produk;
RETURN Hitung;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `highpriceproducts`
-- (See below for the actual view)
--
CREATE TABLE `highpriceproducts` (
`ProductID` int(11)
,`ProductName` varchar(100)
,`Harga` int(11)
,`Stock` int(11)
,`SupplierID` int(11)
,`Status` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`CategoryID`, `CategoryName`) VALUES
(1, 'Top'),
(2, 'Bottom'),
(3, 'Outerwear'),
(4, 'Dress'),
(5, 'Shorts');

-- --------------------------------------------------------

--
-- Stand-in structure for view `limitedstockhighpriceproducts`
-- (See below for the actual view)
--
CREATE TABLE `limitedstockhighpriceproducts` (
`ProductID` int(11)
,`ProductName` varchar(100)
,`Harga` int(11)
,`Stock` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `logproduk`
--

CREATE TABLE `logproduk` (
  `LogID` int(11) NOT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ActionType` varchar(50) DEFAULT NULL,
  `OldProductName` varchar(100) DEFAULT NULL,
  `NewProductName` varchar(100) DEFAULT NULL,
  `OldHarga` int(11) DEFAULT NULL,
  `NewHarga` int(11) DEFAULT NULL,
  `OldStock` int(11) DEFAULT NULL,
  `NewStock` int(11) DEFAULT NULL,
  `ChangeTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logproduk`
--

INSERT INTO `logproduk` (`LogID`, `ProductID`, `ActionType`, `OldProductName`, `NewProductName`, `OldHarga`, `NewHarga`, `OldStock`, `NewStock`, `ChangeTime`) VALUES
(1, 6, 'BEFORE INSERT', NULL, 'Hoodie', NULL, 450000, NULL, 15, '2024-07-14 13:07:49'),
(2, 6, 'AFTER INSERT', NULL, 'Hoodie', NULL, 450000, NULL, 15, '2024-07-14 13:07:49'),
(3, 3, 'BEFORE UPDATE', 'Jacket', 'Jacket', 500000, 550000, 20, 10, '2024-07-14 13:40:44'),
(4, 3, 'AFTER UPDATE', 'Jacket', 'Jacket', 500000, 550000, 20, 10, '2024-07-14 13:40:44'),
(8, 6, 'BEFORE DELETE', 'Hoodie', NULL, 450000, NULL, 15, NULL, '2024-07-14 13:53:51'),
(9, 6, 'AFTER DELETE', 'Hoodie', NULL, 450000, NULL, 15, NULL, '2024-07-14 13:53:51'),
(10, 6, 'BEFORE INSERT', NULL, 'Coat', NULL, 350000, NULL, 10, '2024-07-14 14:51:14'),
(11, 6, 'AFTER INSERT', NULL, 'Coat', NULL, 350000, NULL, 10, '2024-07-14 14:51:14');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `OrderDetailID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `CustomerID` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Kontak` varchar(15) DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`CustomerID`, `Nama`, `Email`, `Kontak`, `Alamat`) VALUES
(1, 'Wira', 'Wira@gmail.com', '081234567890', 'Jakarta'),
(2, 'Hamid', 'Hamid@gmail.com', '081234567891', 'Surabaya'),
(3, 'Siti', 'siti@gmail.com', '081234567892', 'Bandung'),
(4, 'Rudi', 'rudi.hartono@gmail.com', '081234567893', 'Yogyakarta'),
(5, 'Tina', 'tina.sari@gmail.com', '081234567894', 'Semarang');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`OrderID`, `CustomerID`, `ProductID`, `OrderDate`, `Quantity`) VALUES
(1, 1, 2, '2024-01-01', 2),
(3, 3, 1, '2024-01-03', 5),
(4, 4, 4, '2024-01-04', 1),
(5, 5, 5, '2024-01-05', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `productdetails`
-- (See below for the actual view)
--
CREATE TABLE `productdetails` (
`ProductName` varchar(100)
,`Harga` int(11)
,`Stock` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(100) DEFAULT NULL,
  `Harga` int(11) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`ProductID`, `ProductName`, `Harga`, `Stock`, `SupplierID`, `Status`) VALUES
(1, 'Kaos', 100000, 50, 1, 'Murah'),
(2, 'Celana Jeans', 250000, 30, 2, NULL),
(3, 'Jacket', 550000, 10, 3, NULL),
(4, 'Dress', 300000, 25, 4, 'Mahal'),
(5, 'Celana Pendek', 150000, 40, 5, NULL),
(6, 'Coat', 350000, 10, 1, NULL);

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `after_delete_produk` AFTER DELETE ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, OldProductName, OldHarga, OldStock)
VALUES (OLD.ProductID, 'AFTER DELETE', OLD.ProductName, OLD.Harga, OLD.Stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_produk` AFTER INSERT ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, NewProductName, NewHarga, NewStock)
VALUES (NEW.ProductID, 'AFTER INSERT', NEW.ProductName, NEW.Harga, NEW.Stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_produk` AFTER UPDATE ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, OldProductName, NewProductName, OldHarga, NewHarga, OldStock, NewStock) 
VALUES (NEW.ProductID, 'AFTER UPDATE', OLD.ProductName, NEW.ProductName, OLD.Harga, NEW.Harga, OLD.Stock, NEW.Stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_produk` BEFORE DELETE ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, OldProductName, OldHarga, OldStock)
VALUES (OLD.ProductID, 'BEFORE DELETE', OLD.ProductName, OLD.Harga, OLD.Stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_produk` BEFORE INSERT ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, NewProductName, NewHarga, NewStock)
VALUES (NEW.ProductID, 'BEFORE INSERT', NEW.ProductName, NEW.Harga, NEW.Stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_produk` BEFORE UPDATE ON `produk` FOR EACH ROW BEGIN
INSERT INTO LogProduk (ProductID, ActionType, OldProductName, NewProductName, OldHarga, NewHarga, OldStock, NewStock)
VALUES (OLD.ProductID, 'BEFORE UPDATE', OLD.ProductName, NEW.ProductName, OLD.Harga, NEW.Harga, OLD.Stock, NEW.Stock);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produkkategori`
--

CREATE TABLE `produkkategori` (
  `ProductID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produkkategori`
--

INSERT INTO `produkkategori` (`ProductID`, `CategoryID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `produksupplier`
--

CREATE TABLE `produksupplier` (
  `ProductID` int(11) NOT NULL,
  `SupplierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produksupplier`
--

INSERT INTO `produksupplier` (`ProductID`, `SupplierID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `SupplierID` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Kontak` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`SupplierID`, `Nama`, `Kontak`) VALUES
(1, 'Supplier A', '111111111'),
(2, 'Supplier B', '222222222'),
(3, 'Supplier C', '333333333'),
(4, 'Supplier D', '444444444'),
(5, 'Supplier E', '555555555');

-- --------------------------------------------------------

--
-- Structure for view `highpriceproducts`
--
DROP TABLE IF EXISTS `highpriceproducts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `highpriceproducts`  AS SELECT `produk`.`ProductID` AS `ProductID`, `produk`.`ProductName` AS `ProductName`, `produk`.`Harga` AS `Harga`, `produk`.`Stock` AS `Stock`, `produk`.`SupplierID` AS `SupplierID`, `produk`.`Status` AS `Status` FROM `produk` WHERE `produk`.`Harga` > 200000 ;

-- --------------------------------------------------------

--
-- Structure for view `limitedstockhighpriceproducts`
--
DROP TABLE IF EXISTS `limitedstockhighpriceproducts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `limitedstockhighpriceproducts`  AS SELECT `highpriceproducts`.`ProductID` AS `ProductID`, `highpriceproducts`.`ProductName` AS `ProductName`, `highpriceproducts`.`Harga` AS `Harga`, `highpriceproducts`.`Stock` AS `Stock` FROM `highpriceproducts` WHERE `highpriceproducts`.`Stock` < 30WITH CASCADEDCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `productdetails`
--
DROP TABLE IF EXISTS `productdetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productdetails`  AS SELECT `produk`.`ProductName` AS `ProductName`, `produk`.`Harga` AS `Harga`, `produk`.`Stock` AS `Stock` FROM `produk` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `logproduk`
--
ALTER TABLE `logproduk`
  ADD PRIMARY KEY (`LogID`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`OrderDetailID`),
  ADD KEY `ProductID` (`ProductID`),
  ADD KEY `OrderID` (`OrderID`,`ProductID`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `ProductID` (`ProductID`),
  ADD KEY `idx_customer_product` (`CustomerID`,`ProductID`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `SupplierID` (`SupplierID`),
  ADD KEY `idx_productname_supplier` (`ProductName`,`SupplierID`);

--
-- Indexes for table `produkkategori`
--
ALTER TABLE `produkkategori`
  ADD PRIMARY KEY (`ProductID`,`CategoryID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `produksupplier`
--
ALTER TABLE `produksupplier`
  ADD PRIMARY KEY (`ProductID`,`SupplierID`),
  ADD KEY `SupplierID` (`SupplierID`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`SupplierID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `logproduk`
--
ALTER TABLE `logproduk`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `pesanan` (`OrderID`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `produk` (`ProductID`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `pelanggan` (`CustomerID`),
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `produk` (`ProductID`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`);

--
-- Constraints for table `produkkategori`
--
ALTER TABLE `produkkategori`
  ADD CONSTRAINT `produkkategori_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `produk` (`ProductID`),
  ADD CONSTRAINT `produkkategori_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `kategori` (`CategoryID`);

--
-- Constraints for table `produksupplier`
--
ALTER TABLE `produksupplier`
  ADD CONSTRAINT `produksupplier_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `produk` (`ProductID`),
  ADD CONSTRAINT `produksupplier_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
