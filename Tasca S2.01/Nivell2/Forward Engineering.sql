-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db-youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db-youtube` ;

-- -----------------------------------------------------
-- Table `db-youtube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`channel` (
  `channel_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `dateOfCreation` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`channel_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-youtube`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`label` (
  `label_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`label_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`user` (
  `user_id` INT NOT NULL,
  `dateOfBirth` DATE NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `userName` VARCHAR(45) NULL DEFAULT NULL,
  `sex` ENUM('Man', 'Women', 'Others') NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `zipCode` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db-youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`video` (
  `video_id` INT NOT NULL,
  `user_id` INT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `size` INT NULL DEFAULT NULL,
  `fileName` VARCHAR(45) NULL DEFAULT NULL,
  `duration` VARCHAR(45) NULL DEFAULT NULL,
  `thumbnail` VARCHAR(45) NULL DEFAULT NULL,
  `reproductions` INT NULL DEFAULT NULL,
  `likes` INT NULL DEFAULT NULL,
  `dislikes` INT NULL DEFAULT NULL,
  `publish_date` DATETIME NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `db-youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `user_id_idx` ON `db-youtube`.`video` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db-youtube`.`video_has_labels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`video_has_labels` (
  `video_id` INT NOT NULL,
  `label_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  CONSTRAINT `labe_id`
    FOREIGN KEY (`label_id`)
    REFERENCES `db-youtube`.`label` (`label_id`),
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `db-youtube`.`video` (`video_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `labe_id_idx` ON `db-youtube`.`video_has_labels` (`label_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db-youtube`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`subscription` (
  `user_id` INT NOT NULL,
  `channel_id` INT NULL,
  `subscription_date` DATETIME NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id`
    FOREIGN KEY ()
    REFERENCES `db-youtube`.`user` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `channel_id`
    FOREIGN KEY (`channel_id`)
    REFERENCES `db-youtube`.`channel` (`channel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `channel_id_idx` ON `db-youtube`.`subscription` (`channel_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db-youtube`.`videoLikeDislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`videoLikeDislike` (
  `video_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `type` ENUM('Like', 'Dislike') NULL,
  `action_datetime` DATETIME NULL,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `db-youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `db-youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `user_id_idx` ON `db-youtube`.`videoLikeDislike` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db-youtube`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`Playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `creation_date` DATE NULL,
  `status` ENUM('Public', 'Private') NULL,
  CONSTRAINT `playlist_id`
    FOREIGN KEY ()
    REFERENCES `db-youtube`.`Playlist` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `db-youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-youtube`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`comment` (
  `comment_id` INT NOT NULL,
  `video_id` INT NULL,
  `user_id` INT NULL,
  `text` TEXT NULL,
  `coment_datetime` DATETIME NULL,
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `db-youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `db-youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `video_id_idx` ON `db-youtube`.`comment` (`video_id` ASC) VISIBLE;

CREATE INDEX `user_id_idx` ON `db-youtube`.`comment` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db-youtube`.`CommentLikeDislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-youtube`.`CommentLikeDislike` (
  `comment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `type` ENUM('Like', 'Dislike') NULL,
  `action_datetime` DATETIME NULL,
  PRIMARY KEY (`comment_id`, `user_id`),
  CONSTRAINT `comment_id`
    FOREIGN KEY ()
    REFERENCES `db-youtube`.`comment` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY ()
    REFERENCES `db-youtube`.`user` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
