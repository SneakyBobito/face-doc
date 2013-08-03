SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `lemon-test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `lemon-test` ;

-- -----------------------------------------------------
-- Table `lemon-test`.`tree`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lemon-test`.`tree` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `age` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lemon-test`.`lemon`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lemon-test`.`lemon` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tree_id` INT NOT NULL ,
  `mature` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_lemon_tree1` (`tree_id` ASC) ,
  CONSTRAINT `fk_lemon_tree1`
    FOREIGN KEY (`tree_id` )
    REFERENCES `lemon-test`.`tree` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lemon-test`.`seed`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lemon-test`.`seed` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `lemon_id` INT NOT NULL ,
  `fertil` TINYINT NOT NULL ,
  INDEX `fk_seed_lemon1` (`lemon_id` ASC) ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_seed_lemon1`
    FOREIGN KEY (`lemon_id` )
    REFERENCES `lemon-test`.`lemon` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lemon-test`.`leaf`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lemon-test`.`leaf` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `length` INT NULL ,
  `tree_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_leaf_tree` (`tree_id` ASC) ,
  CONSTRAINT `fk_leaf_tree`
    FOREIGN KEY (`tree_id` )
    REFERENCES `lemon-test`.`tree` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `lemon-test`.`tree`
-- -----------------------------------------------------
START TRANSACTION;
USE `lemon-test`;
INSERT INTO `lemon-test`.`tree` (`id`, `age`) VALUES (1, 8);
INSERT INTO `lemon-test`.`tree` (`id`, `age`) VALUES (2, 2);
INSERT INTO `lemon-test`.`tree` (`id`, `age`) VALUES (3, 5);

COMMIT;

-- -----------------------------------------------------
-- Data for table `lemon-test`.`lemon`
-- -----------------------------------------------------
START TRANSACTION;
USE `lemon-test`;
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (1, 1, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (2, 1, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (3, 1, '0');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (4, 1, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (5, 1, '0');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (6, 1, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (7, 2, '0');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (8, 3, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (9, 3, '0');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (10, 3, '0');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (11, 3, '1');
INSERT INTO `lemon-test`.`lemon` (`id`, `tree_id`, `mature`) VALUES (12, 3, '0');

COMMIT;

-- -----------------------------------------------------
-- Data for table `lemon-test`.`seed`
-- -----------------------------------------------------
START TRANSACTION;
USE `lemon-test`;
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (1, 1, '0');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (2, 1, '0');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (3, 1, '1');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (4, 2, '0');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (5, 6, '1');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (6, 8, '1');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (7, 8, '0');
INSERT INTO `lemon-test`.`seed` (`id`, `lemon_id`, `fertil`) VALUES (8, 11, '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `lemon-test`.`leaf`
-- -----------------------------------------------------
START TRANSACTION;
USE `lemon-test`;
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (1, 10, 1);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (2, 5, 1);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (3, 8, 1);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (4, 2, 2);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (5, 3, 2);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (6, 1, 2);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (7, 5, 2);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (8, 6, 1);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (9, 2, 3);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (10, 6, 3);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (11, 8, 3);
INSERT INTO `lemon-test`.`leaf` (`id`, `length`, `tree_id`) VALUES (12, 8, 3);

COMMIT;
