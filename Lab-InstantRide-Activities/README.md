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

# 7. GitHub Repository and Codespaces Setup

The following setup uses **MySQL 8** in GitHub Codespaces. The repository contains the SQL files, while the Codespace provides the MySQL server used to execute them.

## Step 1 — Create the GitHub repository folder

In your GitHub repository, create a folder such as:

```text
Lab-InstantRide-Activities/
```

Place these files in the folder:

```text
Lab-InstantRide-Activities/
├── README.md
├── InstantRide_Setup.sql
├── InstantRide_Activity_Set_1.sql
└── InstantRide_Activity_Set_2.sql
```

The repository also needs the `.devcontainer` configuration described below so that a new Codespace automatically includes MySQL.

A recommended repository structure is:

```text
Advanced-Databases-SQL/
├── .devcontainer/
│   ├── devcontainer.json
│   └── docker-compose.yml
├── Lab-InstantRide-Activities/
│   ├── README.md
│   ├── InstantRide_Setup.sql
│   ├── InstantRide_Activity_Set_1.sql
│   └── InstantRide_Activity_Set_2.sql
└── ...
```

## Step 2 — Configure the Codespace

Create `.devcontainer/devcontainer.json` at the repository root:

```json
{
  "name": "Advanced Databases - MySQL",
  "dockerComposeFile": "docker-compose.yml",
  "service": "workspace",
  "workspaceFolder": "/workspaces/${localWorkspaceFolderBasename}",
  "customizations": {
    "vscode": {
      "extensions": [
        "mtxr.sqltools",
        "mtxr.sqltools-driver-mysql"
      ]
    }
  }
}
```

Create `.devcontainer/docker-compose.yml`:

```yaml
services:
  workspace:
    image: mcr.microsoft.com/devcontainers/base:ubuntu
    command: sleep infinity
    volumes:
      - ..:/workspaces/${COMPOSE_PROJECT_NAME}:cached
    depends_on:
      mysql:
        condition: service_healthy

  mysql:
    image: mysql:8.0
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: InstantRide
      MYSQL_USER: student
      MYSQL_PASSWORD: student
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uroot", "-proot"]
      interval: 5s
      timeout: 5s
      retries: 20
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

This creates a MySQL 8 container and a student account:

```text
Host: mysql
Port: 3306
User: student
Password: student
Database: InstantRide
```

> These credentials are intended only for the temporary classroom Codespace environment.

## Step 3 — Create a Codespace

1. Open the GitHub repository.
2. Click **Code**.
3. Select the **Codespaces** tab.
4. Click **Create codespace on main**.
5. Wait for VS Code in the browser to finish loading.
6. The first creation may take a few minutes because the MySQL image and VS Code extensions must be installed.

When the Codespace is ready, the repository files should appear in the Explorer on the left.

## Step 4 — Open a terminal

In Codespaces, select:

**Terminal → New Terminal**

The terminal prompt should appear at the bottom of the window.

Check that MySQL is running:

```bash
mysqladmin -h mysql -u student -pstudent ping
```

Expected result:

```text
mysqld is alive
```

## Step 5 — Connect to MySQL

From the Codespaces terminal, enter:

```bash
mysql -h mysql -u student -pstudent
```

You should see the MySQL prompt:

```text
mysql>
```

At this prompt, SQL commands can be entered directly.

For example:

```sql
SHOW DATABASES;
```

Exit the MySQL client with:

```sql
exit;
```

## Step 6 — Build/reset the InstantRide database

The setup script creates the original four tables and loads the original dataset.

From the repository terminal, run:

```bash
mysql -h mysql -u student -pstudent < Lab-InstantRide-Activities/InstantRide_Setup.sql
```

`InstantRide_Setup.sql` begins by dropping and recreating the `InstantRide` database. Therefore, it can also be used whenever you want to **reset the activity back to its original state**.

At the end of the script, you should see the original tables:

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

## Step 7 — Verify the database manually

Connect to MySQL:

```bash
mysql -h mysql -u student -pstudent
```

Then run:

```sql
USE InstantRide;

SHOW TABLES;

SELECT * FROM CARS;
SELECT * FROM DRIVERS;
SELECT * FROM USERS;
SELECT * FROM TRAVELS;
```

At this point the starting database is ready.

Do **not** expect to see `MAINTENANCE_TYPES`, `MAINTENANCES`, or `ACTIVE_DRIVERS` yet. Students create those tables during Activity Set 1.

## Step 8 — Work on Activity Set 1

Open:

```text
InstantRide_Activity_Set_1.sql
```

Activity Set 1 contains six tasks. Complete them in order because later tasks depend on objects created by earlier tasks.

To execute an entire SQL file from the terminal:

```bash
mysql -h mysql -u student -pstudent InstantRide < Lab-InstantRide-Activities/InstantRide_Activity_Set_1.sql
```

During class, however, it is usually better to execute **one task at a time**. This lets students inspect the result before moving to the next task.

You can connect to MySQL and paste/run only the statement for the current task:

```bash
mysql -h mysql -u student -pstudent InstantRide
```

Then verify objects as needed with commands such as:

```sql
SHOW TABLES;
DESCRIBE MAINTENANCE_TYPES;
DESCRIBE MAINTENANCES;
DESCRIBE ACTIVE_DRIVERS;
SHOW INDEX FROM ACTIVE_DRIVERS;
```

## Step 9 — Work on Activity Set 2

Activity Set 2 assumes that **all six tasks in Set 1 have already been completed**.

Open:

```text
InstantRide_Activity_Set_2.sql
```

Then complete Tasks 1–6 in order.

Do not reset the database between Set 1 and Set 2.

## Step 10 — Reset the activity when needed

If you want to start over, exit the MySQL client and run:

```bash
mysql -h mysql -u student -pstudent < Lab-InstantRide-Activities/InstantRide_Setup.sql
```

This removes the activity-created objects and restores the original InstantRide database and dataset.

You can then begin Activity Set 1 again.

---

# 8. Important Codespaces Notes

### Bash terminal vs. MySQL prompt

These are different environments.

At a normal terminal prompt, commands such as this are shell commands:

```text
$
```

Do not type:

```sql
SHOW TABLES;
```

directly at the Bash prompt.

First connect with:

```bash
mysql -h mysql -u student -pstudent
```

Then, when you see:

```text
mysql>
```

you can run SQL commands such as:

```sql
USE InstantRide;
SHOW TABLES;
```

### Re-running activity statements

Some activity statements intentionally change the database structure or insert data. Running them twice may result in messages such as:

```text
Table already exists
Duplicate key
Duplicate column
Duplicate constraint/index name
```

That does not necessarily mean the original statement was wrong; it may simply mean the task was already completed.

If the database state becomes confusing, run `InstantRide_Setup.sql` again to return to the original starting point.

### Recommended classroom workflow

For demonstrations:

1. Reset with `InstantRide_Setup.sql` before class if necessary.
2. Complete one activity task.
3. Verify the result with `SHOW`, `DESCRIBE`, or `SELECT`.
4. Discuss what changed.
5. Continue to the next task.
6. Keep the same database state when moving from Set 1 to Set 2.
