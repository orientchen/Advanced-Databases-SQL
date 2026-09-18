-- Advanced Databases
-- Stored Function
-- GitHub Codespaces / MySQL 8.4

USE advanceddb;

DROP FUNCTION IF EXISTS CustomerLevel;

DELIMITER $$

CREATE FUNCTION CustomerLevel(p_creditLimit DOUBLE)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE lvl VARCHAR(10);

    IF p_creditLimit > 50000 THEN
        SET lvl = 'PLATINUM';
    ELSEIF p_creditLimit >= 10000 THEN
        SET lvl = 'GOLD';
    ELSE
        SET lvl = 'SILVER';
    END IF;

    RETURN lvl;
END $$

DELIMITER ;

-- Test the function with a single value
SELECT CustomerLevel(21000);

-- Apply the function to the customers table
SELECT
    customerName,
    creditLimit,
    CustomerLevel(creditLimit) AS customerLevel
FROM customers
ORDER BY customerName;
