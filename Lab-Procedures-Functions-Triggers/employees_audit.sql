-- Advanced Databases
-- Audit Table for Trigger Exercise
-- GitHub Codespaces / MySQL 8.4

USE advanceddb;

DROP TABLE IF EXISTS employees_audit;

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- Verify the table structure
DESCRIBE employees_audit;
