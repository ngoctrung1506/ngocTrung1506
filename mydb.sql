-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`parent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`parent` (
  `parent_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `dob` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(45) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `last_login_date` DATE NOT NULL,
  `last_login_id` DATE NOT NULL,
  PRIMARY KEY (`parent_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `student_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `dob` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(45) NOT NULL,
  `studentcol` INT NOT NULL,
  `date_of_join` DATE NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `last_login_date` DATE NOT NULL,
  `last_login_id` VARCHAR(45) NOT NULL,
  `parent_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_student_parent_idx` (`parent_id` ASC),
  CONSTRAINT `fk_student_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `mydb`.`parent` (`parent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`teacher` (
  `teacher_id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `phone` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `status` TINYINT(1) NULL,
  `last_login_date` DATE NULL,
  `last_login_id` VARCHAR(45) NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grade` (
  `grade_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `desc` VARCHAR(45) NULL,
  PRIMARY KEY (`grade_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `course_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `grade_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_grade1_idx` (`grade_id` ASC),
  CONSTRAINT `fk_course_grade1`
    FOREIGN KEY (`grade_id`)
    REFERENCES `mydb`.`grade` (`grade_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`exam_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`exam_type` (
  `exam_type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`exam_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`exam` (
  `exam_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `exam_type_id` INT NOT NULL,
  PRIMARY KEY (`exam_id`),
  INDEX `fk_exam_exam_type1_idx` (`exam_type_id` ASC),
  CONSTRAINT `fk_exam_exam_type1`
    FOREIGN KEY (`exam_type_id`)
    REFERENCES `mydb`.`exam_type` (`exam_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`exam_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`exam_result` (
  `marks` VARCHAR(45) NOT NULL,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `exam_id` INT NOT NULL,
  INDEX `fk_exam_result_student1_idx` (`student_id` ASC),
  INDEX `fk_exam_result_course1_idx` (`course_id` ASC),
  INDEX `fk_exam_result_exam1_idx` (`exam_id` ASC),
  CONSTRAINT `fk_exam_result_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exam_result_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exam_result_exam1`
    FOREIGN KEY (`exam_id`)
    REFERENCES `mydb`.`exam` (`exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`classroom` (
  `classroom_id` INT NOT NULL,
  `year` YEAR NOT NULL,
  `section` CHAR(2) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `remarks` VARCHAR(45) NOT NULL,
  `grade_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  PRIMARY KEY (`classroom_id`),
  INDEX `fk_classroom_grade1_idx` (`grade_id` ASC),
  INDEX `fk_classroom_teacher1_idx` (`teacher_id` ASC),
  CONSTRAINT `fk_classroom_grade1`
    FOREIGN KEY (`grade_id`)
    REFERENCES `mydb`.`grade` (`grade_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classroom_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `mydb`.`teacher` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`classroom_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`classroom_student` (
  `classroom_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  INDEX `fk_classroom_student_classroom1_idx` (`classroom_id` ASC),
  INDEX `fk_classroom_student_student1_idx` (`student_id` ASC),
  CONSTRAINT `fk_classroom_student_classroom1`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `mydb`.`classroom` (`classroom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classroom_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`attendance` (
  `date` DATE NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `remark` TEXT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`date`),
  INDEX `fk_attendance_student1_idx` (`student_id` ASC),
  CONSTRAINT `fk_attendance_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
