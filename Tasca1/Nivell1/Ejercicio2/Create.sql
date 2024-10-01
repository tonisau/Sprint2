-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ejercicio2_pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ejercicio2_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ejercicio2_pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema db-pizzeria
-- -----------------------------------------------------
USE `Ejercicio2_pizzeria` ;

-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`, `provincia_provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_provincia_id`)
    REFERENCES `Ejercicio2_pizzeria`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(5) NULL,
  `localidad_id` INT NOT NULL,
  `telefono` VARCHAR(9) NULL,
  PRIMARY KEY (`cliente_id`, `localidad_id`),
  INDEX `fk_cliente_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `Ejercicio2_pizzeria`.`localidad` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`tienda` (
  `tienda_id` INT NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(5) NULL,
  `localidad_id` INT NOT NULL,
  PRIMARY KEY (`tienda_id`),
  INDEX `fk_tienda_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `Ejercicio2_pizzeria`.`localidad` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`trabajador` (
  `trabajador_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`trabajador_id`, `tienda_id`),
  INDEX `fk_trabajador_tienda1_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_trabajador_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `Ejercicio2_pizzeria`.`tienda` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`pedido` (
  `pedido_id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` ENUM('reparto', 'recogida') NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `cliente_id` INT NOT NULL,
  `tienda_id` INT NOT NULL,
  `trabajador_id` INT NULL,
  `fecha_hora_entrega` DATETIME NULL,
  PRIMARY KEY (`pedido_id`, `cliente_id`, `tienda_id`),
  INDEX `fk_pedido_trabajador1_idx` (`trabajador_id` ASC) VISIBLE,
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_pedido_tienda1_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_trabajador1`
    FOREIGN KEY (`trabajador_id`)
    REFERENCES `Ejercicio2_pizzeria`.`trabajador` (`trabajador_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Ejercicio2_pizzeria`.`cliente` (`cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `Ejercicio2_pizzeria`.`tienda` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`categoriaPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`categoriaPizza` (
  `categoriaPizza_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`categoriaPizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`producto` (
  `producto_id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` DECIMAL(4,2) NOT NULL,
  `categoriaPizza_id` INT NULL,
  PRIMARY KEY (`producto_id`),
  INDEX `fk_producto_categoriaPizza1_idx` (`categoriaPizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoriaPizza1`
    FOREIGN KEY (`categoriaPizza_id`)
    REFERENCES `Ejercicio2_pizzeria`.`categoriaPizza` (`categoriaPizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`detalle_pedido` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  INDEX `fk_detalle_pedido_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_detalle_pedido_producto1_idx` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Ejercicio2_pizzeria`.`pedido` (`pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `Ejercicio2_pizzeria`.`producto` (`producto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`user_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`user_1` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);

USE `Ejercicio2_pizzeria`;

DELIMITER $$
USE `Ejercicio2_pizzeria`$$
CREATE TRIGGER check_is_reparto
BEFORE UPDATE ON pedido
FOR EACH ROW
BEGIN
	IF (NEW.tipo <> 'reparto' AND (NEW.trabajador_id IS NOT NULL OR NEW.fecha_hora_entrega IS NOT NULL)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'trabajador_id y feha de entrega solo permitidas para productos de reparto';
	END IF;
END;$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
