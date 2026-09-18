-- Advanced Databases
-- Stored Procedure Using a Function
-- GitHub Codespaces / MySQL 8.4

USE advanceddb;

-- Replace the previous version of GetCustomerLevel
DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN p_customerNumber INT,
    OUT p_customerLevel VARCHAR(10)
)
BEGIN
    DECLARE creditlim DOUBLE;

    SELECT creditLimit INTO creditlim
    FROM customers
    WHERE customerNumber = p_customerNumber;

    SELECT CustomerLevel(creditlim)
    INTO p_customerLevel;
END $$

DELIMITER ;

-- Test the revised procedure
CALL GetCustomerLevel(103, @level);

-- Display the value returned through the OUT parameter
SELECT @level;
