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
-- Schema ejercicio2_pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ejercicio2_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ejercicio2_pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema db-pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
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
  `idcategoriaPizza` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoriaPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`producto` (
  `idproducto` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` VARCHAR(45) NULL,
  `categoriaPizza_idcategoriaPizza` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_producto_categoriaPizza2_idx` (`categoriaPizza_idcategoriaPizza` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoriaPizza2`
    FOREIGN KEY (`categoriaPizza_idcategoriaPizza`)
    REFERENCES `Ejercicio2_pizzeria`.`categoriaPizza` (`idcategoriaPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`categoriaPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`categoriaPizza` (
  `idcategoriaPizza` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoriaPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ejercicio2_pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ejercicio2_pizzeria`.`producto` (
  `idproducto` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` VARCHAR(45) NULL,
  `categoriaPizza_idcategoriaPizza` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_producto_categoriaPizza2_idx` (`categoriaPizza_idcategoriaPizza` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoriaPizza2`
    FOREIGN KEY (`categoriaPizza_idcategoriaPizza`)
    REFERENCES `Ejercicio2_pizzeria`.`categoriaPizza` (`idcategoriaPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ejercicio2_pizzeria` ;

-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`categoriapizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`categoriapizza` (
  `categoriaPizza_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`categoriaPizza_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`producto` (
  `producto_id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DECIMAL(4,2) NOT NULL,
  `categoriaPizza_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`producto_id`),
  INDEX `fk_producto_categoriaPizza1_idx` (`categoriaPizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoriaPizza1`
    FOREIGN KEY (`categoriaPizza_id`)
    REFERENCES `ejercicio2_pizzeria`.`categoriapizza` (`categoriaPizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`detalle_pedido` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  INDEX `fk_detalle_pedido_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_detalle_pedido_producto1_idx` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `ejercicio2_pizzeria`.`pedido` (`pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_pedido_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `ejercicio2_pizzeria`.`producto` (`producto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`, `provincia_provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_provincia_id`)
    REFERENCES `ejercicio2_pizzeria`.`provincia` (`provincia_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`trabajador` (
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
    REFERENCES `ejercicio2_pizzeria`.`tienda` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ejercicio2_pizzeria`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejercicio2_pizzeria`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `db-pizzeria` ;

-- -----------------------------------------------------
-- Table `db-pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`localidad` (
  `idlocalidad` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idlocalidad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-pizzeria`.`provinicia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`provinicia` (
  `idprovinicia` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `localidad_idlocalidad1` INT NOT NULL,
  PRIMARY KEY (`idprovinicia`),
  INDEX `fk_provinicia_localidad1_idx` (`localidad_idlocalidad1` ASC) VISIBLE,
  CONSTRAINT `fk_provinicia_localidad1`
    FOREIGN KEY (`localidad_idlocalidad1`)
    REFERENCES `db-pizzeria`.`localidad` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`cliente` (
  `idcliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(45) NULL DEFAULT NULL,
  `provinicia_idprovinicia` INT NOT NULL,
  `provinicia_localidad_idlocalidad` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_provinicia1_idx` (`provinicia_idprovinicia` ASC, `provinicia_localidad_idlocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_provinicia1`
    FOREIGN KEY (`provinicia_idprovinicia` , `provinicia_localidad_idlocalidad`)
    REFERENCES `db-pizzeria`.`provinicia` (`idprovinicia` , `localidad_idlocalidad1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '			';


-- -----------------------------------------------------
-- Table `db-pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`tienda` (
  `idtienda` INT NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(45) NULL DEFAULT NULL,
  `provinicia_idprovinicia` INT NOT NULL,
  `localidad_idlocalidad` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  INDEX `fk_tienda_provinicia1_idx` (`provinicia_idprovinicia` ASC, `localidad_idlocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_provinicia1`
    FOREIGN KEY (`provinicia_idprovinicia` , `localidad_idlocalidad`)
    REFERENCES `db-pizzeria`.`provinicia` (`idprovinicia` , `localidad_idlocalidad1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '	';


-- -----------------------------------------------------
-- Table `db-pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`pedido` (
  `idpedido` INT NOT NULL,
  `fecha_hora` VARCHAR(45) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT NULL,
  `cliente_idcliente` INT NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_pedido_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `db-pizzeria`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `db-pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`producto` (
  `idproducto` INT NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-pizzeria`.`trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`trabajador` (
  `idtrabajador` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `puesto` VARCHAR(45) NULL DEFAULT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idtrabajador`),
  INDEX `fk_trabajador_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_trabajador_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `db-pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-pizzeria`.`pedido_has_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-pizzeria`.`pedido_has_producto` (
  `pedido_idpedido` INT NOT NULL,
  `producto_idproducto` INT NOT NULL,
  INDEX `fk_pedido_has_producto_producto1_idx` (`producto_idproducto` ASC) VISIBLE,
  INDEX `fk_pedido_has_producto_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_producto_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `db-pizzeria`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_producto_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `Ejercicio2_pizzeria`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

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

-- -----------------------------------------------------
-- Data for table `Ejercicio2_pizzeria`.`provincia`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ejercicio2_pizzeria`;
INSERT INTO `Ejercicio2_pizzeria`.`provincia` (`provincia_id`, `nombre`) VALUES (1, 'Barcelona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-pizzeria`.`localidad`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-pizzeria`;
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (1, 'Barcelona');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (2, 'Hospitalet');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (3, 'Badalona');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (4, 'Tiana');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (5, 'Mataro');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (6, 'Girona');
INSERT INTO `db-pizzeria`.`localidad` (`idlocalidad`, `nombre`) VALUES (7, 'Calella de palafurgell');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-pizzeria`.`provinicia`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-pizzeria`;
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (1, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (2, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (3, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (4, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (5, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (6, 'barcelona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (7, 'girona', DEFAULT);
INSERT INTO `db-pizzeria`.`provinicia` (`idprovinicia`, `nombre`, `localidad_idlocalidad1`) VALUES (8, 'girona', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-pizzeria`.`cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-pizzeria`;
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (1, 'toni', 'sau', 'fdsjkgsfd', '43534', barcelona, barcelona);
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (2, 'pedro', 'alo', 'fdgsdf', '4365345', barcelona, hospitalet);
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (3, 'vitoria', 'escalona', 'sdfgsdfg', '67665', maremse, tiana);
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (4, 'lorena', 'rodri', 'rthtjdg', '562452', maresme, mataro);
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (5, 'diego', 'feo', 'fhdfgsj', '234554', barcelona, badalona);
INSERT INTO `db-pizzeria`.`cliente` (`idcliente`, `nombre`, `apellidos`, `direccion`, `codigo_postal`, `provinicia_idprovinicia`, `provinicia_localidad_idlocalidad`) VALUES (6, 'jose', 'ramon', 'hwre', '657657', barcelona, montcada);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-pizzeria`.`pedido`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-pizzeria`;
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (1, '12312', 'reparto a domicilio', '100', 1, 1);
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (2, '43435', 'reparto a domicilio', '340', 1, 2);
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (3, '12345243', 'reparto a domicilio', '245', 2, 1);
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (4, '546', 'recogida en tienda', '453', 2, 2);
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (5, '3425', 'recogida en tienda', '600', 3, 1);
INSERT INTO `db-pizzeria`.`pedido` (`idpedido`, `fecha_hora`, `tipo`, `precio`, `cliente_idcliente`, `tienda_idtienda`) VALUES (6, '23435', 'recogida en tienda', '830', 4, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-pizzeria`.`trabajador`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-pizzeria`;
INSERT INTO `db-pizzeria`.`trabajador` (`idtrabajador`, `nombre`, `apellidos`, `nif`, `telefono`, `puesto`, `tienda_idtienda`) VALUES (1, 'Juan', 'Soriano', '4352435', '934353423', 'repartidor', can joan);
INSERT INTO `db-pizzeria`.`trabajador` (`idtrabajador`, `nombre`, `apellidos`, `nif`, `telefono`, `puesto`, `tienda_idtienda`) VALUES (2, 'Amos', 'Milton', '436245645', '91435234', 'cocinero', organics);
INSERT INTO `db-pizzeria`.`trabajador` (`idtrabajador`, `nombre`, `apellidos`, `nif`, `telefono`, `puesto`, `tienda_idtienda`) VALUES (3, 'Guillermo', 'Anton', '345435', '96234523', 'repartidor', organics);
INSERT INTO `db-pizzeria`.`trabajador` (`idtrabajador`, `nombre`, `apellidos`, `nif`, `telefono`, `puesto`, `tienda_idtienda`) VALUES (4, 'Lourdes', 'Soriano', '34656462', '9325435', 'cocinero', can joan);

COMMIT;

