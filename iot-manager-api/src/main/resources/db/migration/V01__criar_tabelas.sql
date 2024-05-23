CREATE TABLE device (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    manufacturer VARCHAR(255),
    url VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE command_description (
    command_description_id INT AUTO_INCREMENT PRIMARY KEY,
    operation VARCHAR(255) NOT NULL,
    description TEXT,
    result TEXT,
    format TEXT,
    fk_device_id INT,
    FOREIGN KEY (fk_device_id) REFERENCES device(device_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE command (
    command_id INT AUTO_INCREMENT PRIMARY KEY,
    command VARCHAR(255) NOT NULL,
    fk_command_description_id INT,
    FOREIGN KEY (fk_command_description_id) REFERENCES command_description(command_description_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE parameter (
    parameter_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    fk_command_id INT,
    FOREIGN KEY (fk_command_id) REFERENCES command(command_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
