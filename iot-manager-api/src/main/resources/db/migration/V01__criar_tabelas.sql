CREATE TABLE `device` (
  `device_id` BIGINT NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(255) DEFAULT NULL UNIQUE,
  `description` VARCHAR(255) DEFAULT NULL,
  `manufacturer` VARCHAR(255) DEFAULT NULL,
  `url` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `command` (
  `command_id` bigint NOT NULL AUTO_INCREMENT,
  `command` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`command_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `command_description` (
  `command_description_id` bigint NOT NULL AUTO_INCREMENT,
  `operation` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `fk_device_id` bigint DEFAULT NULL,
  `fk_command_id` bigint DEFAULT NULL,
  PRIMARY KEY (`command_description_id`),
  UNIQUE KEY (`fk_command_id`),
  KEY (`fk_device_id`),
  CONSTRAINT FOREIGN KEY (`fk_command_id`) REFERENCES `command` (`command_id`),
  CONSTRAINT FOREIGN KEY (`fk_device_id`) REFERENCES `device` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parameter` (
  `parameter_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fk_command_id` bigint DEFAULT NULL,
  PRIMARY KEY (`parameter_id`),
  KEY (`fk_command_id`),
  CONSTRAINT FOREIGN KEY (`fk_command_id`) REFERENCES `command` (`command_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
