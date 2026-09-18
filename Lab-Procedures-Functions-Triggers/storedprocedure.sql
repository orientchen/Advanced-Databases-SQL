-- Advanced Databases
-- Stored Procedures
-- GitHub Codespaces / MySQL 8.4

USE advanceddb;

-- =====================================================
-- Example 1: A simple stored procedure
-- =====================================================

DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER $$

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM products;
END $$

DELIMITER ;

-- Test the procedure
CALL GetAllProducts();


-- =====================================================
-- Example 2: A stored procedure with IN and OUT parameters
-- =====================================================

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

    IF creditlim > 50000 THEN
        SET p_customerLevel = 'PLATINUM';
    ELSEIF creditlim >= 10000 THEN
        SET p_customerLevel = 'GOLD';
    ELSE
        SET p_customerLevel = 'SILVER';
    END IF;
END $$

DELIMITER ;

-- Test the procedure using customer 103
CALL GetCustomerLevel(103, @level);

-- Display the value returned through the OUT parameter
SELECT @level;
