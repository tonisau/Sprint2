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

-- -----------------------------------------------------
-- Data for table `db-optica`.`clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (1, 'Jose Ramon', 'dfgsfd', 87573, 'vbbbb@gmail.com', '24/09/2024', 'Rocco');
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (2, 'Genesis', 'fghbgf', 87879, 'xxx@gmail.com', '05/03/2024', 'Rocco');
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (3, 'Manuela', 'dfg', 56576, 'ccc@gmail.com', '21/09/2024', 'Rocco');
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (4, 'Luis', 'ewtre', 123435, 'bbbb@gmail.com', '30/01/2024', 'Juanchu');
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (5, 'Pedro', 'asdfa', 54623451, 'aaaa@gmail.com', '20/05/2024', 'Juanchu');
INSERT INTO `db-optica`.`clients` (`idclients`, `nom`, `adreca`, `telefon`, `email`, `data`, `recomanat`) VALUES (6, 'Juan', 'sdafsdf', 564563546, 'dfgadfg@gmail.com', '10/09/2024', 'Juanchu');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-optica`.`proveidor`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (1, 'aaaaa', 'qwerwer', 4444444, 7775, '3145');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (2, 'bbbbb', 'dsfgfdg', 111111111, 65, '345');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (3, 'cccc', 'xcvx', 2222222, 435, '342');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (4, 'dddd', 'bvcbc', 333333, 234, '43');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (5, 'gggggg', 'zxcas', 4444, 134, '5466');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (6, 'fffff', 'asdf', 54555, 54673, '5');
INSERT INTO `db-optica`.`proveidor` (`idproveidor`, `nom`, `adreca`, `telefon`, `fax`, `nif`) VALUES (7, 'aaa', 'wqer', 6666, 657, '675');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-optica`.`marca`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`marca` (`idmarca`, `marca`, `idproveidor`) VALUES (1, 'Ray Ban', 1);
INSERT INTO `db-optica`.`marca` (`idmarca`, `marca`, `idproveidor`) VALUES (2, ' efgsfd', 2);
INSERT INTO `db-optica`.`marca` (`idmarca`, `marca`, `idproveidor`) VALUES (3, 'retre', 3);
INSERT INTO `db-optica`.`marca` (`idmarca`, `marca`, `idproveidor`) VALUES (4, 'fgfgf', 1);
INSERT INTO `db-optica`.`marca` (`idmarca`, `marca`, `idproveidor`) VALUES (5, 'gng', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-optica`.`ulleres`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`ulleres` (`idulleres`, `marca`, `graduacio`, `muntura`, `colorMuntura`, `colorVidre`, `preu`, `idventa`, `idmarca`) VALUES (1, 'ray ban', 1, 'waybfarer', 'negro', 'transparent', 100, 1, 1);
INSERT INTO `db-optica`.`ulleres` (`idulleres`, `marca`, `graduacio`, `muntura`, `colorMuntura`, `colorVidre`, `preu`, `idventa`, `idmarca`) VALUES (2, 'sdf', 4, 'fdsaa', 'blanco', 'cristal', 200, 2, 1);
INSERT INTO `db-optica`.`ulleres` (`idulleres`, `marca`, `graduacio`, `muntura`, `colorMuntura`, `colorVidre`, `preu`, `idventa`, `idmarca`) VALUES (3, 'fff', 5, 'asdf', 'azul', 'dd', 300, 3, 1);
INSERT INTO `db-optica`.`ulleres` (`idulleres`, `marca`, `graduacio`, `muntura`, `colorMuntura`, `colorVidre`, `preu`, `idventa`, `idmarca`) VALUES (4, 'ggg', 6, 'qwere', 'rojo', 'rrr', 400, 4, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-optica`.`empleat`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`empleat` (`idempleat`, `nom`) VALUES (1, 'Toni');
INSERT INTO `db-optica`.`empleat` (`idempleat`, `nom`) VALUES (2, 'Mavi');
INSERT INTO `db-optica`.`empleat` (`idempleat`, `nom`) VALUES (3, 'Lorena');
INSERT INTO `db-optica`.`empleat` (`idempleat`, `nom`) VALUES (4, 'Isidro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db-optica`.`venta`
-- -----------------------------------------------------
START TRANSACTION;
USE `db-optica`;
INSERT INTO `db-optica`.`venta` (`idventa`, `idulleres`, `idempleat`, `idclients`) VALUES (1, 1, 1, 1);
INSERT INTO `db-optica`.`venta` (`idventa`, `idulleres`, `idempleat`, `idclients`) VALUES (2, 2, 1, 2);
INSERT INTO `db-optica`.`venta` (`idventa`, `idulleres`, `idempleat`, `idclients`) VALUES (3, 3, 2, 3);
INSERT INTO `db-optica`.`venta` (`idventa`, `idulleres`, `idempleat`, `idclients`) VALUES (4, 4, 2, 4);
INSERT INTO `db-optica`.`venta` (`idventa`, `idulleres`, `idempleat`, `idclients`) VALUES (5, 5, 3, 1);

COMMIT;

