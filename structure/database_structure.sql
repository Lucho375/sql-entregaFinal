CREATE SCHEMA IF NOT EXISTS `workshop`;

USE `workshop`;

-- -----------------------------------------------------
-- Table `workshop`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(16) NOT NULL,
    `email` VARCHAR(255) NULL,
    `password` VARCHAR(32) NOT NULL,
    `role` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `workshop`.`workshop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`workshop` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `address` VARCHAR(45) NOT NULL,
    `phone` VARCHAR(45) NOT NULL,
    `email` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
    INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_workshop_user_id` FOREIGN KEY (`user_id`) REFERENCES `workshop`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`customer` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `workshop_id` INT NOT NULL,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `email` VARCHAR(45) NOT NULL,
    `address` VARCHAR(45) NOT NULL,
    `phone` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
    INDEX `workshop_id_idx` (`workshop_id` ASC) VISIBLE,
    CONSTRAINT `fk_customer_workshop_id` FOREIGN KEY (`workshop_id`) REFERENCES `workshop`.`workshop` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`vehicle` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    `brand` VARCHAR(45) NOT NULL,
    `model` VARCHAR(45) NOT NULL,
    `year` INT NOT NULL,
    `license_plate` VARCHAR(7) NOT NULL,
    `chasis` VARCHAR(45) NOT NULL,
    `kilometers` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `license_plate_UNIQUE` (`license_plate` ASC) VISIBLE,
    UNIQUE INDEX `chasis_UNIQUE` (`chasis` ASC) VISIBLE,
    INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
    CONSTRAINT `fk_vehicle_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `workshop`.`customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`mechanic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`mechanic` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `workshop_id` INT NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`work_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`work_order` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `vehicle_id` INT NOT NULL,
    `mechanic_id` INT NOT NULL,
    `problem_description` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_vehicle_id_idx` (`vehicle_id` ASC) VISIBLE,
    INDEX `fk_mechanic_id_idx` (`mechanic_id` ASC) VISIBLE,
    CONSTRAINT `fk_work_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `workshop`.`vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_work_order_mechanic_id` FOREIGN KEY (`mechanic_id`) REFERENCES `workshop`.`mechanic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`invoice` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `work_order_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `total` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_work_order_id_idx` (`work_order_id` ASC) VISIBLE,
    INDEX `fk_customer_id_idx` (`customer_id` ASC) VISIBLE,
    CONSTRAINT `fk_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `workshop`.`work_order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_invoice_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `workshop`.`customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `workshop`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `workshop`.`payment` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `invoice_id` INT NOT NULL,
    `paid_amount` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_invoice_id_idx` (`invoice_id` ASC) VISIBLE,
    CONSTRAINT `fk_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `workshop`.`invoice` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;