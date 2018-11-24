-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Comboios
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Comboios
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Comboios` DEFAULT CHARACTER SET utf8 ;
USE `Comboios` ;

-- -----------------------------------------------------
-- Table `Comboios`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `nif` INT NOT NULL,
  `password` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Comboio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Comboio` (
  `id_comboio` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_comboio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Estacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Estacao` (
  `id_estacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_estacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Viagem` (
  `id_viagem` INT NOT NULL AUTO_INCREMENT,
  `data_partida` DATETIME NOT NULL,
  `data_chegada` DATETIME NOT NULL,
  `duracao` TIME NOT NULL,
  `preco_base` FLOAT(5,2) NOT NULL,
  `comboio` INT NOT NULL,
  `origem` INT NOT NULL,
  `destino` INT NOT NULL,
  PRIMARY KEY (`id_viagem`),
  INDEX `fk_Viagem_Comboio1_idx` (`comboio` ASC),
  INDEX `fk_Viagem_Estacao1_idx` (`origem` ASC),
  INDEX `fk_Viagem_Estacao2_idx` (`destino` ASC),
  CONSTRAINT `fk_Viagem_Comboio1`
    FOREIGN KEY (`comboio`)
    REFERENCES `Comboios`.`Comboio` (`id_comboio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Viagem_Estacao1`
    FOREIGN KEY (`origem`)
    REFERENCES `Comboios`.`Estacao` (`id_estacao`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Viagem_Estacao2`
    FOREIGN KEY (`destino`)
    REFERENCES `Comboios`.`Estacao` (`id_estacao`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Bilhete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Bilhete` (
  `id_bilhete` INT NOT NULL AUTO_INCREMENT,
  `preco` FLOAT(5,2) NOT NULL,
  `data_aquisicao` DATETIME NOT NULL,
  `classe` CHAR(1) NOT NULL,
  `numero` SMALLINT NOT NULL,
  `cliente` INT NOT NULL,
  `viagem` INT NOT NULL,
  PRIMARY KEY (`id_bilhete`),
  INDEX `fk_Bilhete_Cliente1_idx` (`cliente` ASC),
  INDEX `fk_Bilhete_Viagem1_idx` (`viagem` ASC),
  CONSTRAINT `fk_Bilhete_Cliente1`
    FOREIGN KEY (`cliente`)
    REFERENCES `Comboios`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bilhete_Viagem1`
    FOREIGN KEY (`viagem`)
    REFERENCES `Comboios`.`Viagem` (`id_viagem`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Lugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Lugar` (
  `classe` CHAR(1) NOT NULL,
  `numero` SMALLINT NOT NULL,
  `comboio` INT NOT NULL,
  INDEX `fk_Lugar_Comboio1_idx` (`comboio` ASC),
  PRIMARY KEY (`numero`, `comboio`, `classe`),
  CONSTRAINT `fk_Lugar_Comboio1`
    FOREIGN KEY (`comboio`)
    REFERENCES `Comboios`.`Comboio` (`id_comboio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
