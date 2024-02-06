-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Contato` CHAR(11) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Veiculos` (
  `idVeiculos` INT NOT NULL AUTO_INCREMENT,
  `idClientes` INT NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Placa` VARCHAR(45) NOT NULL,
  `Ano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idVeiculos`, `idClientes`),
  INDEX `fk_Veiculos_Clientes_idx` (`idClientes` ASC) VISIBLE,
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculos_Clientes`
    FOREIGN KEY (`idClientes`)
    REFERENCES `mydb`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `Turno` ENUM('Diurno', 'Noturno') NOT NULL,
  `Setor` ENUM('Mecânico', 'Estético', 'Revisão') NOT NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mecânico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mecânico` (
  `idMecânico` INT NOT NULL AUTO_INCREMENT,
  `idEquipe` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMecânico`, `idEquipe`),
  INDEX `fk_Mecânico_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Mecânico_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pecas` (
  `idPecas` INT NOT NULL AUTO_INCREMENT,
  `Código` CHAR(6) NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `Quantidade` INT NOT NULL,
  `Valor_un` FLOAT NOT NULL,
  PRIMARY KEY (`idPecas`),
  UNIQUE INDEX `Código_UNIQUE` (`Código` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Serviços` (
  `idServiços` INT NOT NULL AUTO_INCREMENT,
  `Descrição` VARCHAR(45) NOT NULL,
  `Valor` INT NOT NULL,
  PRIMARY KEY (`idServiços`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem_Serviço` (
  `idOrdem_Serviço` INT NOT NULL AUTO_INCREMENT,
  `idVeiculos` INT NOT NULL,
  `idEquipe` INT NOT NULL,
  `Data_entrada` DATE NOT NULL,
  `Data_saida` DATE NULL,
  `Status_ordem` VARCHAR(45) NULL,
  `Valor_total` FLOAT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`, `idVeiculos`, `idEquipe`),
  INDEX `fk_Ordem_Serviço_Veiculos1_idx` (`idVeiculos` ASC) VISIBLE,
  INDEX `fk_Ordem_Serviço_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Serviço_Veiculos1`
    FOREIGN KEY (`idVeiculos`)
    REFERENCES `mydb`.`Veiculos` (`idVeiculos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Serviço_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem_Serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem_Serviços` (
  `idServiços` INT NOT NULL,
  `idOrdem_Serviço` INT NOT NULL,
  PRIMARY KEY (`idServiços`, `idOrdem_Serviço`),
  INDEX `fk_Serviços_has_Ordem_Serviço_Ordem_Serviço1_idx` (`idOrdem_Serviço` ASC) VISIBLE,
  INDEX `fk_Serviços_has_Ordem_Serviço_Serviços1_idx` (`idServiços` ASC) VISIBLE,
  CONSTRAINT `fk_Serviços_has_Ordem_Serviço_Serviços1`
    FOREIGN KEY (`idServiços`)
    REFERENCES `mydb`.`Serviços` (`idServiços`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviços_has_Ordem_Serviço_Ordem_Serviço1`
    FOREIGN KEY (`idOrdem_Serviço`)
    REFERENCES `mydb`.`Ordem_Serviço` (`idOrdem_Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem_pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem_pecas` (
  `idOrdem_Serviço` INT NOT NULL,
  `idPecas` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`, `idPecas`),
  INDEX `fk_Pecas_has_Ordem_Serviço_Ordem_Serviço1_idx` (`idOrdem_Serviço` ASC) VISIBLE,
  INDEX `fk_Pecas_has_Ordem_Serviço_Pecas1_idx` (`idPecas` ASC) VISIBLE,
  CONSTRAINT `fk_Pecas_has_Ordem_Serviço_Pecas1`
    FOREIGN KEY (`idPecas`)
    REFERENCES `mydb`.`Pecas` (`idPecas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pecas_has_Ordem_Serviço_Ordem_Serviço1`
    FOREIGN KEY (`idOrdem_Serviço`)
    REFERENCES `mydb`.`Ordem_Serviço` (`idOrdem_Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
