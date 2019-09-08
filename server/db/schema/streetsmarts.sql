-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema streetsmarts
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `streetsmarts` ;

-- -----------------------------------------------------
-- Schema streetsmarts
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `streetsmarts` DEFAULT CHARACTER SET latin1 ;
USE `streetsmarts` ;

-- -----------------------------------------------------
-- Table `streetsmarts`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`address` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`address` (
  `PK_address` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `lat` VARCHAR(45) NOT NULL,
  `long` VARCHAR(45) NOT NULL,
  `private` TINYINT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` INT NOT NULL,
  PRIMARY KEY (`PK_address`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_address_UNIQUE` ON `streetsmarts`.`address` (`PK_address` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`login` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`login` (
  `PK_login` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`PK_login`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_login_UNIQUE` ON `streetsmarts`.`login` (`PK_login` ASC);

CREATE UNIQUE INDEX `email_UNIQUE` ON `streetsmarts`.`login` (`email` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`user` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`user` (
  `PK_user` INT NOT NULL AUTO_INCREMENT,
  `FK_address` INT NOT NULL,
  `FK_login` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `birthday` DATE NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `phone` INT NOT NULL,
  PRIMARY KEY (`PK_user`),
  CONSTRAINT `FK_address`
    FOREIGN KEY (`FK_address`)
    REFERENCES `streetsmarts`.`address` (`PK_address`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_login`
    FOREIGN KEY (`FK_login`)
    REFERENCES `streetsmarts`.`login` (`PK_login`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_user_UNIQUE` ON `streetsmarts`.`user` (`PK_user` ASC);

CREATE INDEX `FK_address_idx` ON `streetsmarts`.`user` (`FK_address` ASC);

CREATE INDEX `FK_login_idx` ON `streetsmarts`.`user` (`FK_login` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`books` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`books` (
  `PK_books` INT NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`PK_books`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_books_UNIQUE` ON `streetsmarts`.`books` (`PK_books` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`library` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`library` (
  `PK_library` INT NOT NULL AUTO_INCREMENT,
  `FK_books` INT NOT NULL,
  `FK_user` INT NOT NULL,
  `checkedOut` TINYINT NOT NULL,
  PRIMARY KEY (`PK_library`),
  CONSTRAINT `FK_books`
    FOREIGN KEY (`FK_books`)
    REFERENCES `streetsmarts`.`books` (`PK_books`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_user`
    FOREIGN KEY (`FK_user`)
    REFERENCES `streetsmarts`.`user` (`PK_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_library_UNIQUE` ON `streetsmarts`.`library` (`PK_library` ASC);

CREATE INDEX `FK_books_idx` ON `streetsmarts`.`library` (`FK_books` ASC);

CREATE INDEX `FK_user_idx` ON `streetsmarts`.`library` (`FK_user` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`checkout` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`checkout` (
  `PK_checkout` INT NOT NULL AUTO_INCREMENT,
  `FK_owner` INT NOT NULL,
  `FK_borrower` INT NOT NULL,
  `returnDate` DATE NULL,
  PRIMARY KEY (`PK_checkout`),
  CONSTRAINT `FK_owner`
    FOREIGN KEY (`FK_owner`)
    REFERENCES `streetsmarts`.`library` (`PK_library`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_borrower`
    FOREIGN KEY (`FK_borrower`)
    REFERENCES `streetsmarts`.`user` (`PK_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_checkout_UNIQUE` ON `streetsmarts`.`checkout` (`PK_checkout` ASC);

CREATE INDEX `FK_owner_idx` ON `streetsmarts`.`checkout` (`FK_owner` ASC);

CREATE INDEX `FK_borrower_idx` ON `streetsmarts`.`checkout` (`FK_borrower` ASC);


-- -----------------------------------------------------
-- Table `streetsmarts`.`messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streetsmarts`.`messages` ;

CREATE TABLE IF NOT EXISTS `streetsmarts`.`messages` (
  `PK_messages` INT NOT NULL AUTO_INCREMENT,
  `FK_receiver` INT NOT NULL,
  `FK_sender` INT NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`PK_messages`),
  CONSTRAINT `FK_sender`
    FOREIGN KEY (`FK_sender`)
    REFERENCES `streetsmarts`.`user` (`PK_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_receiver`
    FOREIGN KEY (`FK_receiver`)
    REFERENCES `streetsmarts`.`user` (`PK_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `PK_messages_UNIQUE` ON `streetsmarts`.`messages` (`PK_messages` ASC);

CREATE INDEX `FK_sender_idx` ON `streetsmarts`.`messages` (`FK_sender` ASC);

CREATE INDEX `FK_receiver_idx` ON `streetsmarts`.`messages` (`FK_receiver` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
