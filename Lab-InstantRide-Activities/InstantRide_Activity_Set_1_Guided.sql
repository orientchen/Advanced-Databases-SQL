-- =====================================================================
-- InstantRide Activity Set 1 — Guided Hints
-- Student Version
-- =====================================================================
-- Complete the tasks in order.
-- The templates show the SQL commands/syntax you may need, but they do
-- not provide the completed SQL statements.
--
-- Before starting, make sure InstantRide_Setup.sql has been executed.
-- =====================================================================

USE advanceddb;

-- =====================================================================
-- Task 1 — Create MAINTENANCE_TYPES
-- =====================================================================
-- The InstantRide Management team founded a new team for car maintenance.
-- Create a table named MAINTENANCE_TYPES that stores:
--
--   MAINTENANCE_TYPE_ID           CHAR(5)
--   MAINTENANCE_TYPE_DESCRIPTION  VARCHAR(30)
--
-- Use MAINTENANCE_TYPE_ID as the primary key.
-- Display the table description after creating it.
--
-- Guided hints:
-- 1. Use CREATE TABLE.
-- 2. Define both columns with the required data types.
-- 3. Define MAINTENANCE_TYPE_ID as the PRIMARY KEY.
-- 4. Use DESCRIBE to check the finished table.
--
-- Statement templates:
--
-- CREATE TABLE table_name (
--     column_name data_type,
--     column_name data_type,
--     PRIMARY KEY (column_name)
-- );
--
-- DESCRIBE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 2 — Create MAINTENANCES
-- =====================================================================
-- Create a table named MAINTENANCES containing:
--
--   CAR_ID                CHAR(5)
--   MAINTENANCE_TYPE_ID   CHAR(5)
--   MAINTENANCE_DUE       DATE
--
-- The PRIMARY KEY must be the combination of all three columns.
--
-- CAR_ID should reference CARS(CAR_ID).
-- MAINTENANCE_TYPE_ID should reference
-- MAINTENANCE_TYPES(MAINTENANCE_TYPE_ID).
--
-- Both foreign keys should use:
--   ON UPDATE CASCADE
--   ON DELETE CASCADE
--
-- Guided hints:
-- 1. Use CREATE TABLE.
-- 2. A composite primary key lists multiple columns inside PRIMARY KEY.
-- 3. Add one FOREIGN KEY definition for each relationship.
-- 4. REFERENCES identifies the parent table and parent column.
-- 5. Add the cascade actions to each foreign-key relationship.
--
-- Statement template:
--
-- CREATE TABLE table_name (
--     column1 data_type,
--     column2 data_type,
--     column3 data_type,
--
--     PRIMARY KEY (column1, column2, column3),
--
--     FOREIGN KEY (column1)
--         REFERENCES parent_table(parent_column)
--         ON UPDATE CASCADE
--         ON DELETE CASCADE,
--
--     FOREIGN KEY (column2)
--         REFERENCES parent_table(parent_column)
--         ON UPDATE CASCADE
--         ON DELETE CASCADE
-- );
--
-- Optional verification:
--
-- DESCRIBE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 3 — Create ACTIVE_DRIVERS
-- =====================================================================
-- The Driver Relationship team wants a table containing drivers who
-- have had at least one ride.
--
-- Create ACTIVE_DRIVERS from DRIVERS and TRAVELS with these fields:
--
--   DRIVER_ID                       CHAR(5)       Primary Key
--   DRIVER_FIRST_NAME               VARCHAR(20)
--   DRIVER_LAST_NAME                VARCHAR(20)
--   DRIVER_DRIVING_LICENSE_ID       VARCHAR(10)
--   DRIVER_DRIVING_LICENSE_CHECKED  BOOL
--   DRIVER_RATING                   DECIMAL(2,1)
--
-- Only drivers with at least one matching row in TRAVELS should appear.
--
-- Guided hints:
-- 1. DRIVER_ID appears in both DRIVERS and TRAVELS.
-- 2. JOIN the two tables using DRIVER_ID.
-- 3. One driver may have several rides, so the JOIN can produce the
--    same driver more than once. Think about DISTINCT.
-- 4. CREATE TABLE ... AS SELECT can create a table from query results.
-- 5. A primary-key definition is not automatically carried into a table
--    created with CREATE TABLE ... AS SELECT. Add it afterward.
--
-- Statement templates:
--
-- CREATE TABLE new_table AS
-- SELECT DISTINCT
--     table_alias.column1,
--     table_alias.column2,
--     ...
-- FROM table1 AS table_alias
-- JOIN table2 AS other_alias
--     ON table_alias.common_column = other_alias.common_column;
--
-- ALTER TABLE table_name
-- ADD PRIMARY KEY (column_name);
--
-- Optional verification:
--
-- SELECT * FROM table_name;
-- DESCRIBE table_name;
--
-- Think before writing:
-- Which original driver should NOT appear because that driver has no
-- matching ride in TRAVELS?
--
-- Write your SQL below:




-- =====================================================================
-- Task 4 — Create the NameSearch index
-- =====================================================================
-- Create an index named NameSearch on ACTIVE_DRIVERS using these
-- columns IN THIS ORDER:
--
--   1. DRIVER_FIRST_NAME
--   2. DRIVER_LAST_NAME
--   3. DRIVER_DRIVING_LICENSE_ID
--
-- Guided hints:
-- 1. Use CREATE INDEX.
-- 2. Specify the index name after CREATE INDEX.
-- 3. Specify ACTIVE_DRIVERS after ON.
-- 4. A multi-column index lists all columns inside parentheses.
-- 5. Preserve the requested column order.
--
-- Statement template:
--
-- CREATE INDEX index_name
-- ON table_name (column1, column2, column3);
--
-- Optional verification:
--
-- SHOW INDEX FROM table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 5 — Add the DuplicateCheck constraint
-- =====================================================================
-- Prevent duplicate active-driver records based on the COMBINATION of:
--
--   DRIVER_FIRST_NAME
--   DRIVER_LAST_NAME
--   DRIVER_DRIVING_LICENSE_ID
--
-- Name the constraint DuplicateCheck.
--
-- Guided hints:
-- 1. The requirement applies to the combination of three columns.
-- 2. Do NOT make each column individually unique.
-- 3. Use ALTER TABLE to modify ACTIVE_DRIVERS.
-- 4. Use ADD CONSTRAINT followed by the requested constraint name.
-- 5. Use UNIQUE with all three columns inside one set of parentheses.
--
-- Statement template:
--
-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name
-- UNIQUE (column1, column2, column3);
--
-- Optional verification:
--
-- SHOW INDEX FROM table_name;
--
-- Write your SQL below:




-- =====================================================================
-- Task 6 — Add MAINTENANCE_PRICE
-- =====================================================================
-- Alter MAINTENANCE_TYPES to add:
--
--   MAINTENANCE_PRICE   DECIMAL(5,2)
--
-- Guided hints:
-- 1. The table already exists, so do not use CREATE TABLE again.
-- 2. Use ALTER TABLE.
-- 3. Use ADD COLUMN to add the new field.
-- 4. DECIMAL(5,2) means 5 total digits, with 2 digits after the
--    decimal point.
--
-- Statement template:
--
-- ALTER TABLE table_name
-- ADD COLUMN column_name data_type;
--
-- Optional verification:
--
-- DESCRIBE table_name;
--
-- Write your SQL below:




-- =====================================================================
-- End of Activity Set 1
-- =====================================================================
