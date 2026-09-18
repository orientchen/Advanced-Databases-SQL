-- Advanced Databases
-- BEFORE UPDATE Trigger
-- GitHub Codespaces / MySQL 8.4

USE advanceddb;

DROP TRIGGER IF EXISTS before_employee_update;

DELIMITER $$

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
        employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW();
END $$

DELIMITER ;

-- Check employee 1056 before the update
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE employeeNumber = 1056;

-- Update employee 1056
UPDATE employees
SET lastName = 'Phan'
WHERE employeeNumber = 1056;

-- Check the employee after the update
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE employeeNumber = 1056;

-- Check the audit record created by the trigger
SELECT * FROM employees_audit;
