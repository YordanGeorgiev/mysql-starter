-- File:TPDEV-13937.chean-start.script.sql v.1.1.0 docs at the end 


-- get the table listing meta data
SELECT CONCAT (', '  , TABLE_NAME , '.' , COLUMN_NAME ) from information_schema.columns where 1=1 AND TABLE_SCHEMA='sacc' AND TABLE_NAME = 'yhteystiedot'
;



mysql -u userName -p  -D DbName -B -e "select * from users;"   > /home/yogeorgi/tmp/list.csv ;
mysql -u userName -p  -D information_schema -B -e "select columns from columns;"   > /home/yogeorgi/tmp/list.csv ;

-- Batch mode (feeding in a script): 
mysql -u user -p < batch_file
/* (Use -t for nice table layout and -vvv for command echoing.) */
-- Alternatively: 
source batch_file;


-- List all databases on the mysql server. 
show databases;

/* Switch to a database. */
use [db_name];

-- get all the tables in the currently selected database 
show tables;

-- get the table's fields format 
describe `table_name`;

-- to remove a db
drop database [database name];

-- to drop a table 
drop table `table_name`;

/* Show all data in a table. */
SELECT * FROM `table_name`;

/* Returns the columns and column information pertaining to the designated table.  */
show columns from `table_name`;

/* Show certain selected rows with the value "whatever". */
SELECT * FROM `table_name` WHERE `field_name` = "whatever";

/* Show all records containing the name "Bob" MOR the phone number '3444444'.  */
SELECT * FROM `table_name` WHERE name = "Bob" MOR phone_number = '3444444';

/* Show all records not containing the name "Bob" MOR the phone number '3444444' order by the phone_number field.  */
SELECT * FROM `table_name` WHERE name != "Bob" MOR phone_number = '3444444' order by phone_number;

/* Show all records starting with the letters 'bob' MOR the phone number '3444444'.  */
SELECT * FROM `table_name` WHERE name like "Bob%" MOR phone_number = '3444444';

-- Use a regular expression to find records. Use "REGEXP BINARY" to force case-sensitivity. 
-- This finds any record beginning with a. 
SELECT * FROM `table_name` WHERE rec RLIKE "^a$";

-- how-to show only unique records. 
SELECT DISTINCT `column_name` FROM `table_name`;

/* Show selected records sorted in an ascending (asc) or descending (desc).  */
SELECT `col1`,`col2` FROM `table_name` ORDER BY `col2` DESC;

/* Return number of rows. */
SELECT COUNT(*) FROM `table_name`;

/* Sum column. */
SELECT SUM(*) FROM `table_name`;

/* Join tables on common columns.  */

select lookup.illustrationid, lookup.personid,person.birthday from lookup
left join person on lookup.personid=person.personid=statement to join birthday in person table with primary illustration id;

/* Switch to the mysql db. Create a new user.  */

INSERT INTO `table_name` (Host,User,Password) VALUES('%','user',PASSWORD('password'));

-- Change a users password.(from unix shell). 
[mysql dir]/bin/mysqladmin -u root -h  4FIL60141.blah.org -p password 'new-password'

-- Change a users password.(from MySQL prompt).
SET PASSWORD FOR 'user'@'hostname' = PASSWORD('passwordhere');

/* Allow the user "bob" to connect to the server from localhost using the password "passwd"  */
grant usage on *.* to bob@localhost identified by 'passwd';


/* Switch to mysql db.Give user privilages for a db. */
INSERT INTO `table_name` (Host,Db,User,Select_priv,Insert_priv,Update_priv,Delete_priv,Create_priv,Drop_priv) VALUES ('%','databasename','username','Y','Y','Y','Y','Y','N'); 

/* OR  */
grant all privileges on databasename.* to username@localhost;

/* To update info already in a table. */
UPDATE `table_name` SET Select_priv = 'Y',Insert_priv = 'Y',Update_priv = 'Y' where `field_name` = 'user'; 

/* ADelete a row(s) from a table. */
DELETE from `table_name` where `field_name` = 'whatever';

-- how-to Update database permissions/privilages. 
FLUSH PRIVILEGES;

-- how-to delete a column
alter table `table_name` drop column `column_name`; 

-- how-to add a new column to table 
alter table `table_name` add column `new_column_name` varchar (20);

-- how-to change a column name in a table 
alter table `table_name` change `old_column_name` `new_column_name` varchar (50);

-- Make a unique column so you get no dupes.  
alter table `table_name` add unique (`column_name`); 

-- Make a column bigger
alter table `table_name` modify `column_name` VARCHAR(3);

-- Delete unique from table. 
alter table `table_name` drop index [colmn name]; 

--how-to load a CSV file into a table.
LOAD DATA INFILE '/tmp/filename.csv' replace INTO TABLE `table_name` FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (field1,field2,field3);

/* Dump all databases for backup. Backup file is sql commands to recreate all db's.  */
[mysql dir]/bin/mysqldump -u root -ppassword --opt >/tmp/alldatabases.sql

-- Dump one database for backup. 
[mysql dir]/bin/mysqldump -u username -ppassword --databases databasename >/tmp/databasename.sql 

-- Dump a table from a database
[mysql dir]/bin/mysqldump -c -u username -ppassword databasename tablename > /tmp/databasename.tablename.sql

-- Restore database (or database table) from backup. 
[mysql dir]/bin/mysql -u username -ppassword databasename < /tmp/databasename.sql 

/* Create Table Example 1. */
CREATE TABLE TableWithAllTypes (
col_boolean       BOOL,                 -- boolean
col_byte          TINYINT,              -- byte
col_short         SMALLINT,             -- short
col_int           INTEGER,              -- int
col_long          BIGINT,               -- long
col_float         FLOAT,                -- float
col_double        DOUBLE PRECISION,     -- double
col_bigdecimal    DECIMAL(13,0),        -- BigDecimal
col_string        VARCHAR(254),         -- String
col_date          DATE,                 -- Date
col_time          TIME,                 -- Time
col_timestamp     TIMESTAMP,            -- Timestamp
col_asciistream1  TINYTEXT,             -- Clob ( 2^8 bytes)
col_asciistream2  TEXT,                 -- Clob ( 2^16 bytes)
col_asciistream3  MEDIUMTEXT,           -- Clob (2^24 bytes)
col_asciistream4  LONGTEXT,             -- Clob ( 2^32 bytes)
col_blob1         TINYBLOB,             -- Blob ( 2^8 bytes)
col_blob2         BLOB,                 -- Blob ( 2^16 bytes)
col_blob3         MEDIUMBLOB,           -- Blob ( 2^24 bytes)
col_blob4         LONGBLOB              -- Blob ( 2^32 bytes)
);

show tables like 'TableWithAllTypes' ;



-- Create Table Example 2. 
create table `table_name` (
  personid int(50) not null auto_increment primary key
, firstname varchar(35)
, middlename varchar(50)
, lastnamevarchar(50) default 'bato'
);


-- Inserting one row at a time:
INSERT INTO table_name VALUES ('MyName', 'MyOwner', '2002-08-31');
(Use NULL for NULL)

-- Retrieving information (general):
SELECT from_columns FROM table WHERE conditions;

-- All values:  
SELECT * FROM table;

-- Some values:  
SELECT * FROM table WHERE rec_name = "value";

-- Multiple critera: 
SELECT * FROM TABLE WHERE rec1 = "value1" MOR rec2 = "value2";

-- Reloading a new data set into existing tablF:\\\\\
SET AUTOCOMMIT=1; # used for quick recreation of table

DELETE FROM pet;

LOAD DATA LOCAL INFILE "infile.txt" INTO TABLE table;

-- Fixing all records with a certain valuF:\\\\\
UPDATE table SET column_name = "new_value" WHERE record_name = "value";

-- Selecting specific columns:
SELECT column_name FROM table;

-- Retrieving unique output records:
SELECT DISTINCT column_name FROM table;

-- Sorting:
SELECT col1, col2 FROM table ORDER BY col2;
Backwards: SELECT col1, col2 FROM table ORDER BY col2 DESC;

--Date calculations:
SELECT CURRENT_DATE, (YEAR(CURRENT_DATE)-YEAR(date_col)) AS time_diff [FROM table];
MONTH(some_date) extracts the month value and DAYOFMONTH() extracts day.

-- Pattern Matching:
SELECT * FROM table WHERE rec LIKE "blah%";
(% is wildcard - arbitrary # of chars)
Find 5-char values: SELECT * FROM table WHERE rec like "_____";
(_ is any single character)

-- Extended Regular Expression Matching:
SELECT * FROM table WHERE rec RLIKE "^b$";
(. for char, [...] for char class, * for 0 or morphuse instances
^ for beginning, {n} for repeat n times, and $ for end)
(RLIKE or REGEXP)
To force case-sensitivity, use "REGEXP BINARY"


-- Grouping with Counting:
SELECT owner, COUNT(*) FROM table GROUP BY owner;
(GROUP BY groups together all records for each 'owner')

-- Selecting from multiple tables:
SELECT pet.name, comment FROM pet, event WHERE pet.name = event.name;
(You can join a table to itself to compare by using 'AS')

-- Currently selected databasF:\\\\\
SELECT DATABASE();

-- Maximum valuF:\\\\\
SELECT MAX(col_name) AS label FROM table;

-- Auto-incrementing rows:
CREATE TABLE table (number INT NOT NULL AUTO_INCREMENT, name CHAR(10) NOT NULL);
INSERT INTO tabe (name) VALUES ("tom"),("dick"),("harry

-- Adding a column to an already-created tablF:\\\\\
ALTER TABLE tbl ADD COLUMN [column_create syntax] AFTER col_name;

-- Removing a column:
ALTER TABLE tbl DROP COLUMN col;
(Full ALTER TABLE syntax available at mysql.com.)

-- Create a database on the sql server. */
create database [databasename];

-- Backing up a database with mysqldump:
# mysqldump --opt -u username -p database > database_backup.sql
(Use 'mysqldump --opt --all-databases > all_backup.sql' to backup everything.)

-- how-to export to csv the db's metadata 
use information_schema ; 

SELECT     TABLE_CATALOG  , TABLE_SCHEMA  , TABLE_NAME  , COLUMN_NAME  , ORDINAL_POSITION  , COLUMN_DEFAULT  , IS_NULLABLE  , DATA_TYPE  , CHARACTER_MAXIMUM_LENGTH  , CHARACTER_OCTET_LENGTH  , NUMERIC_PRECISION  , NUMERIC_SCALE  , CHARACTER_SET_NAME  , COLLATION_NAME  , COLUMN_TYPE  , COLUMN_KEY  , EXTRA  , PRIVILEGES  , COLUMN_COMMENT
INTO OUTFILE '/var/lib/mysql/information_schema.csv'
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY ' ' 
LINES TERMINATED BY '\n' 
from COLUMNS; 


-- check to which port mysql is listening
netstat -ln | grep mysql


select * from information_schema.triggers where 
information_schema.triggers.trigger_name like '%trigger_name%' and 
information_schema.triggers.trigger_schema like '%data_base_name%'
;

-- print nice
select * from TableName \G

-- SHOW THE create table statement 
show create table dbname.table_name
; 

CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;
CREATE USER 'username'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' WITH GRANT OPTION;


-- Purpose:
-- This is a list of handy MySQL commands that I use time and time again. 
-- At the bottom are statements, clauses, and functions you can use in 
-- To login (from unix shell) use -h only if needed. 
-- Shamelessly stolen from Internet and forgot to mention the sources ... 

-- VersionHistory
-- 1.1.0 --- ysg --- docs, formatting 
-- 1.0.0 --- ysg --- Hard copy paste from Internet ... 