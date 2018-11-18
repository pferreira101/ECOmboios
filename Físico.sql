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
  `email` VARCHAR(30) NULL,
  `nif` INT(9) NOT NULL,
  `password` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`TelemovelCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`TelemovelCliente` (
  `telemovel` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`telemovel`),
  INDEX `fk_TelemovelCliente_Cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_TelemovelCliente_Cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Comboios`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `duracao` TIME GENERATED ALWAYS AS (data_chegada - data_partida) VIRTUAL,
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_Estacao1`
    FOREIGN KEY (`origem`)
    REFERENCES `Comboios`.`Estacao` (`id_estacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_Estacao2`
    FOREIGN KEY (`destino`)
    REFERENCES `Comboios`.`Estacao` (`id_estacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Bilhete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Bilhete` (
  `id_bilhete` INT NOT NULL AUTO_INCREMENT,
  `preco` FLOAT(5,2) NOT NULL,
  `data_aquisicao` DATETIME NOT NULL,
  `cliente` INT NOT NULL,
  `viagem` INT NOT NULL,
  PRIMARY KEY (`id_bilhete`),
  INDEX `fk_Bilhete_Cliente1_idx` (`cliente` ASC),
  INDEX `fk_Bilhete_Viagem1_idx` (`viagem` ASC),
  CONSTRAINT `fk_Bilhete_Cliente1`
    FOREIGN KEY (`cliente`)
    REFERENCES `Comboios`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilhete_Viagem1`
    FOREIGN KEY (`viagem`)
    REFERENCES `Comboios`.`Viagem` (`id_viagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`Lugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`Lugar` (
  `id_lugar` INT NOT NULL AUTO_INCREMENT,
  `classe` CHAR(1) NOT NULL,
  `numero` INT NOT NULL,
  `comboio` INT NOT NULL,
  PRIMARY KEY (`id_lugar`),
  INDEX `fk_Lugar_Comboio1_idx` (`comboio` ASC),
  CONSTRAINT `fk_Lugar_Comboio1`
    FOREIGN KEY (`comboio`)
    REFERENCES `Comboios`.`Comboio` (`id_comboio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comboios`.`LugarBilhete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Comboios`.`LugarBilhete` (
  `bilhete_id` INT NOT NULL,
  `lugar_id` INT NOT NULL,
  PRIMARY KEY (`bilhete_id`, `lugar_id`),
  INDEX `fk_Bilhete_has_Lugar_Lugar1_idx` (`lugar_id` ASC),
  INDEX `fk_Bilhete_has_Lugar_Bilhete1_idx` (`bilhete_id` ASC),
  CONSTRAINT `fk_Bilhete_has_Lugar_Bilhete1`
    FOREIGN KEY (`bilhete_id`)
    REFERENCES `Comboios`.`Bilhete` (`id_bilhete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilhete_has_Lugar_Lugar1`
    FOREIGN KEY (`lugar_id`)
    REFERENCES `Comboios`.`Lugar` (`id_lugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
