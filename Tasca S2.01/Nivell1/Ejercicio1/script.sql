-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db-optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db-optica` ;

-- -----------------------------------------------------
-- Table `db-optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`clients` (
  `idclients` INT NOT NULL,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `adreca` VARCHAR(45) NULL DEFAULT NULL,
  `telefon` INT NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `data` DATETIME NULL DEFAULT NULL,
  `recomanat` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idclients`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-optica`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`proveidor` (
  `idproveidor` INT NOT NULL,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `adreca` VARCHAR(45) NULL DEFAULT NULL,
  `telefon` INT NULL DEFAULT NULL,
  `fax` INT NULL DEFAULT NULL,
  `nif` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idproveidor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`marca` (
  `idmarca` INT NOT NULL,
  `marca` VARCHAR(45) NULL,
  `idproveidor` INT NOT NULL,
  PRIMARY KEY (`idmarca`),
  INDEX `fk_marca_proveidor1_idx` (`idproveidor` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveidor1`
    FOREIGN KEY (`idproveidor`)
    REFERENCES `db-optica`.`proveidor` (`idproveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`ulleres` (
  `idulleres` INT NOT NULL,
  `marca` VARCHAR(45) NULL DEFAULT NULL,
  `graduacio` FLOAT NULL DEFAULT NULL,
  `muntura` VARCHAR(45) NULL DEFAULT NULL,
  `colorMuntura` VARCHAR(45) NULL DEFAULT NULL,
  `colorVidre` VARCHAR(45) NULL DEFAULT NULL,
  `preu` INT NULL DEFAULT NULL,
  `idventa` INT NOT NULL,
  `idmarca` INT NOT NULL,
  PRIMARY KEY (`idulleres`),
  INDEX `fk_ulleres_marca1_idx` (`idmarca` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_marca1`
    FOREIGN KEY (`idmarca`)
    REFERENCES `db-optica`.`marca` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-optica`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`empleat` (
  `idempleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idempleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-optica`.`venta` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `idulleres` INT NOT NULL,
  `idempleat` INT NOT NULL,
  `idclients` INT NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_ulleres_has_empleat_empleat1_idx` (`idempleat` ASC) VISIBLE,
  INDEX `fk_ulleres_has_empleat_ulleres1_idx` (`idulleres` ASC) VISIBLE,
  INDEX `fk_venta_clients1_idx` (`idclients` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_has_empleat_ulleres1`
    FOREIGN KEY (`idulleres`)
    REFERENCES `db-optica`.`ulleres` (`idulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_has_empleat_empleat1`
    FOREIGN KEY (`idempleat`)
    REFERENCES `db-optica`.`empleat` (`idempleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_clients1`
    FOREIGN KEY (`idclients`)
    REFERENCES `db-optica`.`clients` (`idclients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
