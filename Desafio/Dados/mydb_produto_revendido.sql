-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `produto_revendido`
--

DROP TABLE IF EXISTS `produto_revendido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_revendido` (
  `idTerceiro` int NOT NULL,
  `idProduto` int NOT NULL,
  `Taxa_cobrada` float NOT NULL,
  PRIMARY KEY (`idTerceiro`,`idProduto`),
  KEY `fk_Terceiro (Vendedor)_has_Produto_Produto1_idx` (`idProduto`),
  KEY `fk_Terceiro (Vendedor)_has_Produto_Terceiro (Vendedor)1_idx` (`idTerceiro`),
  CONSTRAINT `fk_Terceiro (Vendedor)_has_Produto_Produto1` FOREIGN KEY (`idProduto`) REFERENCES `produtos` (`idProduto`),
  CONSTRAINT `fk_Terceiro (Vendedor)_has_Produto_Terceiro (Vendedor)1` FOREIGN KEY (`idTerceiro`) REFERENCES `terceiro` (`idTerceiro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_revendido`
--

LOCK TABLES `produto_revendido` WRITE;
/*!40000 ALTER TABLE `produto_revendido` DISABLE KEYS */;
INSERT INTO `produto_revendido` VALUES (1,3,5),(1,4,5);
/*!40000 ALTER TABLE `produto_revendido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-05 20:06:55
