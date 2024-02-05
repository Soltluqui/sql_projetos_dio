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
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50) NOT NULL,
  `Sobrenome` VARCHAR(45) NULL,
  `Nascimento` DATE NOT NULL,
  `Endereço` VARCHAR(255) NOT NULL,
  `Cidade` VARCHAR(20) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Tipo_de_conta` ENUM('Física', 'Jurídica') NOT NULL,
  `CPF` CHAR(11) NULL,
  `CNPJ` CHAR(14) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cartão`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cartão` (
  `idCartão` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `Titular` VARCHAR(155) NOT NULL,
  `Número` CHAR(16) NOT NULL,
  `Validade` CHAR(5) NOT NULL,
  `CVV` CHAR(3) NOT NULL,
  PRIMARY KEY (`idCartão`, `idCliente`),
  UNIQUE INDEX `idCartão_UNIQUE` (`idCartão` ASC) VISIBLE,
  INDEX `fk_Cartão_Clientes1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cartão_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `Status_Pedido` ENUM('Pendente', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Pendente',
  `Plataforma` ENUM('Site', 'Aplicativo') NOT NULL,
  `Valor_frete` FLOAT NULL DEFAULT 50,
  `Código_rastreio` CHAR(13) NULL,
  PRIMARY KEY (`idPedido`, `idCliente`),
  INDEX `fk_Pedido_Clientes1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Categoria` ENUM('Eletronicos', 'Roupas', 'Móveis', 'Diversos') NOT NULL DEFAULT 'Diversos',
  `Valor` FLOAT NOT NULL,
  `Status_produto` ENUM('Em estoque', 'Revendido', 'Indisponivel') NOT NULL DEFAULT 'Indisponivel',
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razão_Social` VARCHAR(85) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `Endereço` VARCHAR(150) NOT NULL,
  `Cidade` VARCHAR(50) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Contato` CHAR(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `Contato_UNIQUE` (`Contato` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Endereço` VARCHAR(155) NOT NULL,
  `Cidade` VARCHAR(50) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro` (
  `idTerceiro` INT NOT NULL AUTO_INCREMENT,
  `Razão Social` VARCHAR(85) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `Endereço` VARCHAR(155) NOT NULL,
  `Cidade` VARCHAR(50) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Contato` CHAR(11) NOT NULL,
  PRIMARY KEY (`idTerceiro`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `Contato_UNIQUE` (`Contato` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `idPedido` INT NOT NULL,
  `idCartão` INT NOT NULL,
  `Forma_Pagamento` ENUM('Cartão', 'Boleto') NOT NULL,
  `Status_Pagamento` ENUM('Pendente', 'Confirmado') NOT NULL DEFAULT 'Pendente',
  PRIMARY KEY (`idPagamento`, `idPedido`, `idCartão`),
  INDEX `fk_Pagamento_Cartão1_idx` (`idCartão` ASC) VISIBLE,
  UNIQUE INDEX `idPagamento_UNIQUE` (`idPagamento` ASC) VISIBLE,
  INDEX `fk_Pagamento_Pedido1_idx` (`idPedido` ASC) VISIBLE,
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Cartão1`
    FOREIGN KEY (`idCartão`)
    REFERENCES `mydb`.`Cartão` (`idCartão`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Boleto` (
  `idBoleto` INT NOT NULL AUTO_INCREMENT,
  `idPagamento` INT NOT NULL,
  `Código_Boleto` VARCHAR(47) NOT NULL,
  `Status_boleto` ENUM('Pendente', 'Confirmado') NOT NULL DEFAULT 'Pendente',
  PRIMARY KEY (`idBoleto`, `idPagamento`),
  UNIQUE INDEX `Código do Boleto_UNIQUE` (`Código_Boleto` ASC) VISIBLE,
  INDEX `fk_Boleto_Pagamento1_idx` (`idPagamento` ASC) VISIBLE,
  UNIQUE INDEX `idBoleto_UNIQUE` (`idBoleto` ASC) VISIBLE,
  UNIQUE INDEX `idPagamento_UNIQUE` (`idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Boleto_Pagamento1`
    FOREIGN KEY (`idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_em_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_em_Pedido` (
  `idProduto` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_Estoque` (
  `idProduto` INT NOT NULL,
  `idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idProduto`, `idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_fornecido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_fornecido` (
  `idFornecedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `Valor_compra` FLOAT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`, `idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor1_idx` (`idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor1`
    FOREIGN KEY (`idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_revendido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_revendido` (
  `idTerceiro` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `Taxa_cobrada` FLOAT NOT NULL,
  PRIMARY KEY (`idTerceiro`, `idProduto`),
  INDEX `fk_Terceiro (Vendedor)_has_Produto_Produto1_idx` (`idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro (Vendedor)_has_Produto_Terceiro (Vendedor)1_idx` (`idTerceiro` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro (Vendedor)_has_Produto_Terceiro (Vendedor)1`
    FOREIGN KEY (`idTerceiro`)
    REFERENCES `mydb`.`Terceiro` (`idTerceiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro (Vendedor)_has_Produto_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

show tables;