-- =====================================================================
-- InstantRide Activity Set 2 — Guided Hints
-- Student Version
-- =====================================================================
-- IMPORTANT: Complete Activity Set 1 before starting Activity Set 2.
-- Set 2 depends on tables and constraints created in Set 1.
-- =====================================================================

USE InstantRide;

-- =====================================================================
-- Task 1 — Set the default maintenance price
-- =====================================================================
-- The default MAINTENANCE_PRICE should be 0 when a price is not
-- specified.
--
-- Alter MAINTENANCE_TYPES so that MAINTENANCE_PRICE has a default
-- value of 0.
--
-- Guided hints:
-- 1. MAINTENANCE_PRICE already exists. Do not add it again.
-- 2. Use ALTER TABLE.
-- 3. Alter the existing column's DEFAULT value.
-- 4. Setting a DEFAULT does not by itself make the column NOT NULL.
--
-- Statement template:
--
-- ALTER TABLE table_name
-- ALTER COLUMN column_name SET DEFAULT value;
--
-- Optional verification:
--
-- DESCRIBE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 2 — Check driving license ID length
-- =====================================================================
-- Ensure that DRIVER_DRIVING_LICENSE_ID values in ACTIVE_DRIVERS have
-- a length of exactly 7.
--
-- Guided hints:
-- 1. This is a rule about acceptable values, so use a CHECK constraint.
-- 2. Use a string-length function to measure the license ID.
-- 3. Compare the result with 7.
-- 4. The task does not require changing VARCHAR(10); the CHECK
--    constraint supplies the additional business rule.
--
-- Statement templates:
--
-- ALTER TABLE table_name
-- ADD CHECK (LENGTH(column_name) = required_length);
--
-- OR, when a constraint name is desired:
--
-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name
-- CHECK (LENGTH(column_name) = required_length);
--
-- Optional verification:
--
-- SHOW CREATE TABLE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 3 — Insert maintenance types
-- =====================================================================
-- Insert these rows into MAINTENANCE_TYPES:
--
--   ID   Description       Price
--   1    Tire Change        50
--   2    Oil Change         45
--   3    Full Cleaning     100
--   4    Gas Pump Change   145
--
-- Guided hints:
-- 1. Use INSERT INTO.
-- 2. List the target columns explicitly.
-- 3. You can insert all four records with one VALUES clause.
-- 4. MAINTENANCE_TYPE_ID is CHAR(5), so treat its values as character
--    values.
-- 5. Text descriptions also require quotes.
--
-- Statement template:
--
-- INSERT INTO table_name (column1, column2, column3)
-- VALUES
--     (value1, value2, value3),
--     (value1, value2, value3),
--     (value1, value2, value3),
--     (value1, value2, value3);
--
-- Optional verification:
--
-- SELECT * FROM table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 4 — Add Tire Change maintenance for 2021 cars
-- =====================================================================
-- Every car with model year 2021 should receive a Tire Change
-- maintenance task:
--
--   MAINTENANCE_TYPE_ID = 1
--   MAINTENANCE_DUE     = December 31, 2022
--
-- Insert the appropriate rows into MAINTENANCES and then display the
-- maintenance data.
--
-- Guided hints:
-- 1. Do NOT manually enter a particular CAR_ID.
-- 2. Select CAR_ID from CARS based on CAR_YEAR.
-- 3. Use INSERT ... SELECT to insert rows produced by a query.
-- 4. The SELECT can return a column from CARS plus constant values for
--    the maintenance type and due date.
-- 5. Use the MySQL date format YYYY-MM-DD.
--
-- Statement template:
--
-- INSERT INTO target_table (column1, column2, column3)
-- SELECT
--     source_column,
--     constant_value,
--     constant_value
-- FROM source_table
-- WHERE condition;
--
-- Display the result:
--
-- SELECT *
-- FROM table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 5 — Remove DRIVER_DRIVING_LICENSE_CHECKED
-- =====================================================================
-- The Driver Relationship team no longer needs
-- DRIVER_DRIVING_LICENSE_CHECKED in ACTIVE_DRIVERS.
--
-- Remove this column from the table.
--
-- Guided hints:
-- 1. You are changing the table structure, not deleting a row.
-- 2. Use ALTER TABLE.
-- 3. Use DROP COLUMN for the field that is no longer needed.
--
-- Statement template:
--
-- ALTER TABLE table_name
-- DROP COLUMN column_name;
--
-- Optional verification:
--
-- DESCRIBE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 6 — Update and delete maintenance types
-- =====================================================================
-- Make these two changes:
--
--   A. Change the Oil Change price to 75.
--   B. Remove Gas Pump Change from MAINTENANCE_TYPES.
--
-- Guided hints:
-- 1. These are two different operations, so use two SQL statements.
-- 2. UPDATE changes an existing row.
-- 3. SET identifies the new value.
-- 4. DELETE FROM removes an existing row.
-- 5. Use WHERE carefully so that only the intended row is changed or
--    deleted.
-- 6. The maintenance type ID is the primary key and is a precise way
--    to identify a maintenance type.
--
-- Statement templates:
--
-- UPDATE table_name
-- SET column_name = new_value
-- WHERE condition;
--
-- DELETE FROM table_name
-- WHERE condition;
--
-- Optional verification:
--
-- SELECT * FROM table_name;
--
-- Write your SQL below:




-- =====================================================================
-- End of Activity Set 2
-- =====================================================================
