# InstantRide SQL Activities

These files reproduce two Cengage Code It **InstantRide** activity sets for use in GitHub Codespaces. They can be used when the Cengage Codespaces connection is unavailable.

## Files

- `InstantRide_Setup.sql` — creates the original `InstantRide` database and loads the starting dataset
- `InstantRide_Activity_Set_1.sql` — Activity Set 1, Tasks 1–6
- `InstantRide_Activity_Set_2.sql` — Activity Set 2, Tasks 1–6
- `README.md` — database structure, dataset, task descriptions, and Codespaces setup instructions

Run `InstantRide_Setup.sql` first. Then complete **Set 1 before Set 2**. Set 2 depends on tables and constraints created in Set 1.

---

# 1. InstantRide Scenario

InstantRide is a ride-sharing application. Users request rides through the application. Drivers and cars are assigned to those requests, and the completed ride transactions are stored in the database.

The original database contains four tables:

- `USERS` — user information
- `DRIVERS` — driver information
- `CARS` — vehicle information
- `TRAVELS` — ride transactions connecting users, drivers, and cars

The activities extend this database with maintenance-related tables and an active-driver table.

---

# 2. Original Database Structure

## USERS

| Column | Type | Null | Key |
|---|---|---|---|
| `USER_ID` | `CHAR(5)` | No | Primary Key |
| `USER_FIRST_NAME` | `VARCHAR(20)` | No | |
| `USER_LAST_NAME` | `VARCHAR(20)` | No | |
| `USER_EMAIL` | `VARCHAR(100)` | No | |

## DRIVERS

| Column | Type | Null | Key |
|---|---|---|---|
| `DRIVER_ID` | `CHAR(5)` | No | Primary Key |
| `DRIVER_FIRST_NAME` | `VARCHAR(20)` | No | |
| `DRIVER_LAST_NAME` | `VARCHAR(20)` | No | |
| `DRIVER_DRIVING_LICENSE_ID` | `VARCHAR(10)` | No | |
| `DRIVER_START_DATE` | `DATE` | No | |
| `DRIVER_DRIVING_LICENSE_CHECKED` | `TINYINT(1)` | No | |
| `DRIVER_RATING` | `DECIMAL(2,1)` | No | |

## CARS

| Column | Type | Null | Key |
|---|---|---|---|
| `CAR_ID` | `CHAR(5)` | No | Primary Key |
| `CAR_PLATE` | `VARCHAR(10)` | No | |
| `CAR_MODEL` | `VARCHAR(20)` | No | |
| `CAR_YEAR` | `YEAR` | No | |

## TRAVELS

| Column | Type | Null | Key |
|---|---|---|---|
| `TRAVEL_ID` | `CHAR(10)` | No | Primary Key |
| `TRAVEL_START_TIME` | `DATETIME` | No | |
| `TRAVEL_END_TIME` | `DATETIME` | No | |
| `TRAVEL_START_LOCATION` | `CHAR(30)` | No | |
| `TRAVEL_END_LOCATION` | `CHAR(30)` | No | |
| `TRAVEL_PRICE` | `DECIMAL(5,2)` | No | |
| `DRIVER_ID` | `CHAR(5)` | No | |
| `CAR_ID` | `CHAR(5)` | No | |
| `USER_ID` | `CHAR(5)` | No | |
| `TRAVEL_DISCOUNT` | `DECIMAL(3,2)` | Yes | |

## Main relationships

```text
USERS.USER_ID     ─────┐
                       │
DRIVERS.DRIVER_ID ─────┼──> TRAVELS
                       │
CARS.CAR_ID       ─────┘
```

`TRAVELS` is the central transaction table. Each travel identifies the user, driver, and car involved in a ride.

---

# 3. Original Dataset

## USERS

| USER_ID | USER_FIRST_NAME | USER_LAST_NAME | USER_EMAIL |
|---|---|---|---|
| 3001 | Jack | Hill | j.hill@xmail.com |
| 3002 | Ryan | Collins | r.collins@xmail.com |
| 3003 | Nursin | Yilmaz | n.atak@gmail.com |
| 3004 | Sarah | Price | s.price@xmail.com |
| 3005 | Bobby | Griffin | b.griffin@xmail.com |
| 3006 | Randy | Clark | r.clark@xmail.com |
| 3007 | Jose | Thomas | j.thomas@xmail.com |
| 3008 | Nursin | Yilmaz | n.yilmaz@xmail.com |

## DRIVERS

| DRIVER_ID | FIRST_NAME | LAST_NAME | LICENSE_ID | START_DATE | LICENSE_CHECKED | RATING |
|---|---|---|---|---|---:|---:|
| 2001 | Willie | Butler | 1874501 | 2022-09-12 | 1 | 4.4 |
| 2002 | Justin | Howard | 1953853 | 2022-09-09 | 1 | 4.8 |
| 2003 | Anthony | Walker | 1735487 | 2022-09-15 | 1 | 3.5 |
| 2004 | Ece | Yilmaz | 1734747 | 2022-08-15 | 1 | 0.0 |

## CARS

| CAR_ID | CAR_PLATE | CAR_MODEL | CAR_YEAR |
|---|---|---|---:|
| 1001 | BB-542-AB | TOYOTA PRIUS | 2021 |
| 1002 | BB-883-EE | TESLA MODEL 3 | 2022 |
| 1003 | BB-451-ZN | TOYOTA AURIS | 2022 |
| 1004 | BB-189-MM | MERCEDES E200 | 2022 |

## TRAVELS

| TRAVEL_ID | START_TIME | END_TIME | START_LOCATION | END_LOCATION | PRICE | DRIVER_ID | CAR_ID | USER_ID | DISCOUNT |
|---|---|---|---|---|---:|---|---|---|---:|
| 5001 | 2022-10-01 04:04:55 | 2022-10-01 04:14:19 | 9614 York Road | 84 Church Lane | 15.44 | 2001 | 1003 | 3005 | NULL |
| 5002 | 2022-10-01 05:57:33 | 2022-10-01 06:12:33 | 47 Church Street | 68 High Street | 20.56 | 2001 | 1003 | 3006 | NULL |
| 5003 | 2022-10-01 13:35:20 | 2022-10-01 13:45:10 | 2 Windsor Road | 95 West Street | 12.32 | 2002 | 1001 | 3002 | NULL |
| 5004 | 2022-10-02 08:44:48 | 2022-10-02 09:15:28 | 9060 Mill Lane | 27 Main Road | 30.49 | 2003 | 1002 | 3001 | 0.13 |
| 5005 | 2022-10-02 16:38:54 | 2022-10-02 16:48:10 | 2 Queensway | 24 Mill Lane | 11.15 | 2001 | 1003 | 3007 | NULL |
| 5006 | 2022-10-03 19:12:14 | 2022-10-03 19:23:45 | 50 Main Road | 93 Broadway | 14.61 | 2003 | 1002 | 3007 | 0.10 |
| 5007 | 2022-10-03 16:06:36 | 2022-10-03 16:08:56 | 39 Park Road | 91 West Street | 4.41 | 2002 | 1004 | 3003 | 0.14 |
| 5008 | 2022-10-03 17:17:12 | 2022-10-03 17:37:42 | 37 The Drive | 17 Stanley Road | 25.12 | 2001 | 1003 | 3001 | 0.25 |
| 5009 | 2022-10-03 21:16:48 | 2022-10-03 21:26:18 | 77 Mill Road | 724 Springfield Road | 13.55 | 2001 | 1003 | 3005 | NULL |
| 5010 | 2022-10-03 23:21:40 | 2022-10-03 23:39:10 | 16 Church Road | 30 North Road | 25.62 | 2003 | 1002 | 3003 | 0.20 |

---

# 4. Activity Set 1

## Task 1 — Create MAINTENANCE_TYPES

The InstantRide Management team founded a new team for car maintenance. The new team is responsible for small maintenance operations for cars in the InstantRide system. To support faster maintenance actions, the team wants to store a `MAINTENANCE_TYPE_ID` (`CHAR(5)`) and a `MAINTENANCE_TYPE_DESCRIPTION` (`VARCHAR(30)`) in the database.

Create a new table named `MAINTENANCE_TYPES`, using `MAINTENANCE_TYPE_ID` as the primary key, and display the table description with its column names and types.

**Main concepts:** `CREATE TABLE`, data types, `PRIMARY KEY`, `DESCRIBE`.

## Task 2 — Create MAINTENANCES

The Car Maintenance team also wants to store actual maintenance operations. Create a table named `MAINTENANCES` containing:

- `CAR_ID` — `CHAR(5)`
- `MAINTENANCE_TYPE_ID` — `CHAR(5)`
- `MAINTENANCE_DUE` — `DATE`

The primary key should be the combination of all three fields. `CAR_ID` and `MAINTENANCE_TYPE_ID` should be foreign keys referencing their original tables. Both foreign keys should use cascade update and cascade delete.

**Main concepts:** composite primary key, foreign keys, `ON UPDATE CASCADE`, `ON DELETE CASCADE`.

## Task 3 — Create ACTIVE_DRIVERS

The Driver Relationship team wants to organize workshops and communicate with drivers who have had at least one ride in the InstantRide system.

Create a new table named `ACTIVE_DRIVERS` from the `DRIVERS` and `TRAVELS` tables. It should contain:

- `DRIVER_ID` — `CHAR(5)`, primary key
- `DRIVER_FIRST_NAME` — `VARCHAR(20)`
- `DRIVER_LAST_NAME` — `VARCHAR(20)`
- `DRIVER_DRIVING_LICENSE_ID` — `VARCHAR(10)`
- `DRIVER_DRIVING_LICENSE_CHECKED` — `BOOL`
- `DRIVER_RATING` — `DECIMAL(2,1)`

Only drivers who have had at least one ride should be included.

**Main concepts:** `CREATE TABLE ... AS SELECT`, `JOIN`, `DISTINCT`, primary key.

## Task 4 — Create NameSearch index

The Driver Relationship team frequently searches active drivers using first name, last name, and driving license ID.

Create an index named `NameSearch` on `ACTIVE_DRIVERS` using:

1. `DRIVER_FIRST_NAME`
2. `DRIVER_LAST_NAME`
3. `DRIVER_DRIVING_LICENSE_ID`

**Main concepts:** `CREATE INDEX`, composite/multi-column index.

## Task 5 — Add DuplicateCheck constraint

The Driver Relationship team wants to prevent duplicate active-driver records based on the combination of first name, last name, and driving license ID.

Create a constraint named `DuplicateCheck` on `ACTIVE_DRIVERS` that makes the combination of these three fields unique.

**Main concepts:** `ALTER TABLE`, named constraint, `UNIQUE` constraint.

## Task 6 — Add MAINTENANCE_PRICE

The Car Maintenance team wants maintenance types to include price information.

Alter `MAINTENANCE_TYPES` to add a column named `MAINTENANCE_PRICE` with data type `DECIMAL(5,2)`.

**Main concepts:** `ALTER TABLE`, `ADD COLUMN`, `DECIMAL` precision and scale.

---

# 5. Activity Set 2

Activity Set 2 continues from the database produced by Activity Set 1.

## Task 1 — Set a default maintenance price

The Car Maintenance team wants the default price of a maintenance action to be `0` when a price is not specified.

Alter `MAINTENANCE_TYPES` so that `MAINTENANCE_PRICE` has a default value of `0`.

**Main concepts:** `ALTER TABLE`, `ALTER COLUMN`, `SET DEFAULT`.

## Task 2 — Check driving license ID length

The Driver Relationship team wants to ensure that all driving license IDs in `ACTIVE_DRIVERS` have a length of exactly `7`.

Alter `ACTIVE_DRIVERS` to add a check on the length of `DRIVER_DRIVING_LICENSE_ID`.

**Main concepts:** `CHECK` constraint, `CHAR_LENGTH()`/string length validation.

## Task 3 — Insert maintenance types

Insert the following maintenance types into `MAINTENANCE_TYPES`:

| ID | Description | Price |
|---|---|---:|
| 1 | Tire Change | 50 |
| 2 | Oil Change | 45 |
| 3 | Full Cleaning | 100 |
| 4 | Gas Pump Change | 145 |

**Main concepts:** `INSERT INTO`, multi-row `VALUES`.

## Task 4 — Insert maintenance tasks for 2021 cars

The Car Maintenance team has determined that every car with model year `2021` should have a **Tire Change** maintenance task (`MAINTENANCE_TYPE_ID = 1`) due on **December 31, 2022**.

Insert the appropriate rows into `MAINTENANCES` for every car built in 2021, and display the resulting maintenance data.

**Main concepts:** `INSERT ... SELECT`, constants in a `SELECT`, `WHERE` filtering.

## Task 5 — Remove license checked field

The Driver Relationship team no longer needs the `DRIVER_DRIVING_LICENSE_CHECKED` field in `ACTIVE_DRIVERS` because all active drivers are expected to have their licenses checked regularly.

Remove this column from the table.

**Main concepts:** `ALTER TABLE`, `DROP COLUMN`.

## Task 6 — Update and delete maintenance types

The Car Maintenance team wants to change the price of **Oil Change** to `75`. It will also stop providing **Gas Pump Change**, so that maintenance type should be removed from the database.

Update the Oil Change price and delete the Gas Pump Change row from `MAINTENANCE_TYPES`.

**Main concepts:** `UPDATE`, `SET`, `WHERE`, `DELETE`.

---

# 6. Database Structure After Activity Set 1

After Set 1 is completed, the database contains the original four tables plus three new tables:

```text
USERS                 DRIVERS                    CARS
  │                       │                        │
  │                       │                        │
  └───────────────────────┼───────────────> TRAVELS
                          │                        │
                          │                        └────> MAINTENANCES
                          │                                  │
                          │                                  │
                          │                                  └────> MAINTENANCE_TYPES
                          │
                          └────> ACTIVE_DRIVERS
```

### MAINTENANCE_TYPES after Set 1

| Column | Type | Key |
|---|---|---|
| `MAINTENANCE_TYPE_ID` | `CHAR(5)` | Primary Key |
| `MAINTENANCE_TYPE_DESCRIPTION` | `VARCHAR(30)` | |
| `MAINTENANCE_PRICE` | `DECIMAL(5,2)` | |

### MAINTENANCES

| Column | Type | Key / Relationship |
|---|---|---|
| `CAR_ID` | `CHAR(5)` | Composite PK; FK → `CARS.CAR_ID` |
| `MAINTENANCE_TYPE_ID` | `CHAR(5)` | Composite PK; FK → `MAINTENANCE_TYPES.MAINTENANCE_TYPE_ID` |
| `MAINTENANCE_DUE` | `DATE` | Composite PK |

### ACTIVE_DRIVERS after Set 1

| Column | Type |
|---|---|
| `DRIVER_ID` | `CHAR(5)` Primary Key |
| `DRIVER_FIRST_NAME` | `VARCHAR(20)` |
| `DRIVER_LAST_NAME` | `VARCHAR(20)` |
| `DRIVER_DRIVING_LICENSE_ID` | `VARCHAR(10)` |
| `DRIVER_DRIVING_LICENSE_CHECKED` | `TINYINT(1)` / Boolean |
| `DRIVER_RATING` | `DECIMAL(2,1)` |

`ACTIVE_DRIVERS` also contains the `NameSearch` composite index and the `DuplicateCheck` unique constraint.

---

# 7. Using the Existing GitHub Codespace

This activity uses the existing **Advanced-Databases-SQL** GitHub repository and its preconfigured Codespace environment. **Students do not need to configure MySQL or modify the `.devcontainer` files.**

The activity files are located in:

```text
Lab-InstantRide-Activities/
├── README.md
├── InstantRide_Setup.sql
├── InstantRide_Activity_Set_1.sql
└── InstantRide_Activity_Set_2.sql
```

## Step 1 — Open the existing Codespace

1. Open the **Advanced-Databases-SQL** repository on GitHub.
2. Click **Code**.
3. Select the **Codespaces** tab.
4. Create a new Codespace or open your existing Codespace.
5. Wait until VS Code in the browser finishes loading.

The database environment is already configured for this repository.

## Step 2 — Open a terminal

In Codespaces, select:

**Terminal → New Terminal**

Connect to MySQL:

```bash
mysql -h mysql -u student -pstudent
```

When the connection succeeds, you will see the MySQL prompt:

```text
mysql>
```

## Step 3 — Load the original InstantRide database

At the `mysql>` prompt, use the `SOURCE` command:

```sql
SOURCE Lab-InstantRide-Activities/InstantRide_Setup.sql;
```

The setup script creates the original InstantRide database, creates the four starting tables, and loads the original dataset.

> Run `SOURCE` from the MySQL prompt, not from the normal Bash terminal.

At the end of the setup, you should see the original tables:

```text
CARS
DRIVERS
TRAVELS
USERS
```

The expected row counts are:

```text
CARS       4
DRIVERS    4
USERS      8
TRAVELS   10
```

## Step 4 — Verify the database

At the `mysql>` prompt, run:

```sql
USE InstantRide;

SHOW TABLES;

SELECT * FROM CARS;
SELECT * FROM DRIVERS;
SELECT * FROM USERS;
SELECT * FROM TRAVELS;
```

At this point the starting database is ready.

You should **not** see `MAINTENANCE_TYPES`, `MAINTENANCES`, or `ACTIVE_DRIVERS` yet. Those tables are created during Activity Set 1.

## Step 5 — Complete Activity Set 1

Open:

```text
Lab-InstantRide-Activities/InstantRide_Activity_Set_1.sql
```

The file contains the six tasks, guided hints, and SQL statement templates. Write your SQL in the spaces provided.

Complete the tasks **in order**, because later tasks depend on database objects created by earlier tasks.

You can execute your SQL statements at the `mysql>` prompt and use commands such as these to verify your work:

```sql
SHOW TABLES;
DESCRIBE MAINTENANCE_TYPES;
DESCRIBE MAINTENANCES;
DESCRIBE ACTIVE_DRIVERS;
SHOW INDEX FROM ACTIVE_DRIVERS;
```

## Step 6 — Complete Activity Set 2

After completing all six tasks in Set 1, open:

```text
Lab-InstantRide-Activities/InstantRide_Activity_Set_2.sql
```

Complete Tasks 1–6 in order.

**Do not reset the database between Set 1 and Set 2.** Activity Set 2 depends on the changes made in Activity Set 1.

## Step 7 — Reset the database if needed

If you need to start the activities over, stay at or reconnect to the `mysql>` prompt and run:

```sql
SOURCE Lab-InstantRide-Activities/InstantRide_Setup.sql;
```

The setup script drops and recreates the InstantRide database, restoring the original tables and dataset.

You can then begin Activity Set 1 again.

---

# 8. Important Codespaces Notes

### Bash terminal vs. MySQL prompt

The normal Codespaces terminal and the MySQL client are different environments.

At the normal terminal prompt, connect to MySQL with:

```bash
mysql -h mysql -u student -pstudent
```

After you see:

```text
mysql>
```

you can enter SQL commands:

```sql
USE InstantRide;
SHOW TABLES;
```

The `SOURCE` command is also entered at the `mysql>` prompt:

```sql
SOURCE Lab-InstantRide-Activities/InstantRide_Setup.sql;
```

### Re-running activity statements

Some tasks create tables, add columns or constraints, or insert data. If you execute the same task more than once, MySQL may report errors such as:

```text
Table already exists
Duplicate key
Duplicate column
Duplicate constraint/index name
```

This may simply mean that the task has already been completed.

If you are unsure of the current database state, reset it with:

```sql
SOURCE Lab-InstantRide-Activities/InstantRide_Setup.sql;
```

Then begin Activity Set 1 again.

### Recommended activity workflow

1. Open the existing Codespace.
2. Connect to MySQL.
3. Use `SOURCE` to load/reset the original InstantRide database.
4. Complete one task at a time.
5. Verify the result with `SHOW`, `DESCRIBE`, or `SELECT`.
6. Continue through Set 1.
7. Continue directly to Set 2 without resetting the database.
