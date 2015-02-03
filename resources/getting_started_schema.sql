CREATE SCHEMA IF NOT EXISTS `face_getting_started` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `face_getting_started` ;

-- -----------------------------------------------------
-- Table `face_getting_started`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `face_getting_started`.`author` (
  `id` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `face_getting_started`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `face_getting_started`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `article_content` TEXT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_author_idx` (`author_id` ASC),
  CONSTRAINT `fk_article_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `face_getting_started`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `face_getting_started`.`tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `face_getting_started`.`article_has_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `face_getting_started`.`article_has_tag` (
  `article_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`article_id`, `tag_id`),
  INDEX `fk_article_has_tag_tag1_idx` (`tag_id` ASC),
  INDEX `fk_article_has_tag_article1_idx` (`article_id` ASC),
  CONSTRAINT `fk_article_has_tag_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `mydb`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `mydb`.`tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;