-- MySQL Script generated by MySQL Workbench
-- Wed Dec 30 11:42:29 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema movieshow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movieshow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movieshow` DEFAULT CHARACTER SET utf8 ;
USE `movieshow` ;

-- -----------------------------------------------------
-- Table `movieshow`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`users` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nick_name` VARCHAR(32) NOT NULL DEFAULT '',
  `age` INT NOT NULL DEFAULT 18,
  `introduce` VARCHAR(2048) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `AGE` (`age` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`movies` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `TITLE` (`title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`favorite_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`favorite_movies` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`favorite_movies` (
  `user_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `rank` INT NOT NULL DEFAULT 0,
  `description` VARCHAR(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`, `movie_id`),
  INDEX `USERID` (`user_id` ASC),
  INDEX `MOVIEID` (`movie_id` ASC),
  CONSTRAINT `MOVIE`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movieshow`.`movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `USER`
    FOREIGN KEY (`user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`profile_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`profile_images` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`profile_images` (
  `user_id` INT NOT NULL,
  `domain` VARCHAR(64) NOT NULL DEFAULT '',
  `image_path` VARCHAR(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `USERID`
    FOREIGN KEY (`user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`locations` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`locations` (
  `id` INT NOT NULL,
  `prefecture` VARCHAR(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`want_watch_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`want_watch_movies` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`want_watch_movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `comment` VARCHAR(512) NOT NULL DEFAULT '',
  `watch_date` DATETIME NOT NULL DEFAULT '0000-00-00',
  `member_sum` INT NOT NULL DEFAULT 2,
  `location_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `USERID` (`user_id` ASC),
  INDEX `MOVIEID` (`movie_id` ASC),
  INDEX `WATCHDATE` (`watch_date` DESC),
  INDEX `LOCATIONID` (`location_id` ASC),
  CONSTRAINT `USERID`
    FOREIGN KEY (`user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MOVIEID`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movieshow`.`movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LOCATIONID`
    FOREIGN KEY (`location_id`)
    REFERENCES `movieshow`.`locations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`movie_medias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`movie_medias` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`movie_medias` (
  `movie_id` INT NOT NULL,
  `media_type` INT NOT NULL DEFAULT 0,
  `image_domain` VARCHAR(64) NOT NULL DEFAULT '',
  `image_path` VARCHAR(512) NOT NULL DEFAULT '',
  `url` VARCHAR(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`movie_id`),
  CONSTRAINT `MOVIEID`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movieshow`.`movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`watch_with_me`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`watch_with_me` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`watch_with_me` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `want_watch_movie_id` INT NOT NULL,
  `host_user_id` INT NOT NULL,
  `request_user_id` INT NOT NULL,
  `comment` VARCHAR(256) NOT NULL DEFAULT '',
  `treat_flg` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `WANTWATCHMOVIEID_idx` (`want_watch_movie_id` ASC),
  INDEX `REQUSTUSERID_idx` (`request_user_id` ASC),
  INDEX `HOSTUSERID_idx` (`host_user_id` ASC),
  CONSTRAINT `WANTWATCHMOVIEID`
    FOREIGN KEY (`want_watch_movie_id`)
    REFERENCES `movieshow`.`want_watch_movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `REQUSTUSERID`
    FOREIGN KEY (`request_user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `HOSTUSERID`
    FOREIGN KEY (`host_user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`movie_talks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`movie_talks` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`movie_talks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `want_watch_movie_id` INT NOT NULL,
  `post_user_id` INT NOT NULL,
  `message` VARCHAR(512) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `POSTUSERID` (`post_user_id` ASC),
  INDEX `WANTWATCHMOVIEID` (`want_watch_movie_id` ASC),
  CONSTRAINT `POSTUSERID`
    FOREIGN KEY (`post_user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WANTWATCHMOVIEID`
    FOREIGN KEY (`want_watch_movie_id`)
    REFERENCES `movieshow`.`want_watch_movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieshow`.`movie_reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieshow`.`movie_reviews` ;

CREATE TABLE IF NOT EXISTS `movieshow`.`movie_reviews` (
  `movie_id` INT NOT NULL,
  `want_watch_movie_id` INT NOT NULL,
  `reviewed_user_id` INT NOT NULL,
  `star` INT NOT NULL DEFAULT 0,
  `comment` VARCHAR(512) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `REVIEWEDUSERID` (`reviewed_user_id` ASC),
  INDEX `MOVIEID` (`movie_id` ASC),
  PRIMARY KEY (`want_watch_movie_id`, `reviewed_user_id`),
  CONSTRAINT `WANTWATCHMOVIEID`
    FOREIGN KEY (`want_watch_movie_id`)
    REFERENCES `movieshow`.`want_watch_movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `REVIEWEDUSERID`
    FOREIGN KEY (`reviewed_user_id`)
    REFERENCES `movieshow`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MOVIEID`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movieshow`.`movies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO movieshow;
 DROP USER movieshow;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
-- CREATE USER 'movieshow' IDENTIFIED BY 'thisismovieshow';

GRANT ALL ON `movieshow`.* TO 'movieshow';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
