CREATE DATABASE  IF NOT EXISTS `sistema_corporativo_rh` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_corporativo_rh`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_corporativo_rh
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargos` (
  `id_cargo` int NOT NULL AUTO_INCREMENT,
  `titulo_cargo` varchar(50) NOT NULL,
  `salario_minimo` decimal(10,2) DEFAULT NULL,
  `salario_maximo` decimal(10,2) DEFAULT NULL,
  `nivel_cargo` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_cargo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamentos` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nome_departamento` varchar(40) NOT NULL,
  `id_localizacao` int DEFAULT NULL,
  `id_gestor` int DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  PRIMARY KEY (`id_departamento`),
  KEY `idx_departamento_localizacao` (`id_localizacao`),
  KEY `idx_departamento_gestor` (`id_gestor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `sobrenome` varchar(50) DEFAULT NULL,
  `telefone` char(11) DEFAULT NULL,
  `data_admissao` date DEFAULT NULL,
  `id_cargo` int NOT NULL,
  `id_departamento` int NOT NULL,
  `id_gestor` int DEFAULT NULL,
  `status_funcionario` enum('ATIVO','INATIVO','FERIAS','AFASTADO') DEFAULT NULL,
  PRIMARY KEY (`id_funcionario`),
  KEY `idx_funcionario_cargo` (`id_cargo`),
  KEY `idx_funcionario_departamento` (`id_departamento`),
  KEY `idx_funcionario_gestor` (`id_gestor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_funcional`
--

DROP TABLE IF EXISTS `historico_funcional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_funcional` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_funcionario` int NOT NULL,
  `id_cargo_anterior` int NOT NULL,
  `id_cargo_novo` int NOT NULL,
  `id_departamento_anterior` int NOT NULL,
  `id_departamento_novo` int NOT NULL,
  `data_alteracao` date DEFAULT NULL,
  `motivo_alteracao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_historico`),
  KEY `fk_historico_cargo_anterior` (`id_cargo_anterior`),
  KEY `fk_historico_departamento_anterior` (`id_departamento_anterior`),
  KEY `idx_historico_funcionario` (`id_funcionario`),
  KEY `idx_historico_cargo_novo` (`id_cargo_novo`),
  KEY `idx_historico_departamento_novo` (`id_departamento_novo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_funcional`
--

LOCK TABLES `historico_funcional` WRITE;
/*!40000 ALTER TABLE `historico_funcional` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_funcional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localizacoes`
--

DROP TABLE IF EXISTS `localizacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localizacoes` (
  `id_localizacao` int NOT NULL AUTO_INCREMENT,
  `cidade` varchar(30) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `pais` varchar(20) DEFAULT NULL,
  `endereco` varchar(80) DEFAULT NULL,
  `cep` char(8) NOT NULL,
  PRIMARY KEY (`id_localizacao`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localizacoes`
--

LOCK TABLES `localizacoes` WRITE;
/*!40000 ALTER TABLE `localizacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `localizacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salarios`
--

DROP TABLE IF EXISTS `salarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salarios` (
  `id_salario` int NOT NULL AUTO_INCREMENT,
  `id_funcionario` int NOT NULL,
  `valor_salario` decimal(10,2) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date DEFAULT NULL,
  `salario_ativo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_salario`),
  UNIQUE KEY `uq_salario_ativo` (`id_funcionario`,`salario_ativo`),
  KEY `idx_salario_funcionario` (`id_funcionario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salarios`
--

LOCK TABLES `salarios` WRITE;
/*!40000 ALTER TABLE `salarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `salarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_sistema`
--

DROP TABLE IF EXISTS `usuarios_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_sistema` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(15) NOT NULL,
  `perfil_acesso` varchar(20) NOT NULL,
  `id_funcionario` int NOT NULL,
  `data_criacao` date DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `usuario_ativo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nome_usuario` (`nome_usuario`),
  KEY `idx_usuario_funcionario` (`id_funcionario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_sistema`
--

LOCK TABLES `usuarios_sistema` WRITE;
/*!40000 ALTER TABLE `usuarios_sistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_sistema` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-08 13:15:32
