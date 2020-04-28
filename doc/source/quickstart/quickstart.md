# Hologres in 20 Minutes

## Prerequisites

This tutorial requires a database and table to load and query data. Creating Hologres objects requires a user with a role with the necessary access control permissions.

In addition, [psql (PostgreSQL Client)](https://www.postgresql.org/docs/current/app-psql.html) of PostgreSQL **version 11 or above** is required to execute the SQL statements in the tutorial. Please search online and see how to install psql in your machine, whether it's MacOS, Linux, Windows, etc.


## Download Sample Data Files

Download the set of sample data files by clicking [getting-started.zip](https://raw.githubusercontent.com/hologres/hologres-doc/master/doc/source/quickstart/customers.csv.zip), or right-click the file and save the link/file to your local file system.

Unpack the sample files in any location. However, we recommend using the directories referenced in the tutorial examples:

**Linux/macOS:** /tmp

**Windows:** C:\temp

The sample files include randomly generate customer data in CSV format with a few records each. The delimiter between each field is the comma (`,`) character.


## Log into Hologres via psql

1. Open a terminal windoww
2. Start psql as 

```
PGPASSWORD=<password/access_key> psql -U <username/access_id> -h <hostname> -p <port> -d postgres
```

*Note: PostgreSQL instance always comes with a built-in database "postgres". 


## Create Hologres Objects

1. Create a Database

```
create database quickstart;
```

Note that you do not need to create a schema in the database because each database created in Hologres/Postgres contains a default schema named `public`.

2. Reconnect to the new Database

Run 

```
\q
```

to quit the connection and reconnect to the newly created database `quickstart` with

```
PGPASSWORD=<password/access_key> psql -U <username/access_id> -h <hostname> -p <port> -d quickstart
```

Note that this time the parameter following `-d` should be `quickstart` rather than `postgres`.

This reconnection is necessary since psql doesn't allow users to switch databases.


3. Create a Table

```
create table customers (
	  first_name text,
	  last_name text,
	  email text,
	  address text,
	  city text,
	  registration_date date
);
```

Note that the number of columns in the table, their positions, and their data types correspond to the fields in the sample CSV data files that you will be staging in the next step in this tutorial.


## Copy CSV Data into Hologres

Open a new terminal on your machine. Run the following commands to copy the local sample data to Hologres with standard input stream:

- Linux/macOS

	```
	psql -h <hostname> -p <port> -d quickstart -U <username> -c "copy customers from STDIN with delimiter as ',';" < /tmp/customers.csv
	```

- Windows

	```
	psql -h <hostname> -p <port> -d quickstart -U <username> -c "copy customers from STDIN with delimiter as ',';" < c:\temp\customers.csv
	```

The terminal then pops up a commandline to let you enter your password.
Enter password then hit "Enter" key on your keyboard.

The command returns the following response:

```
COPY 24
```

## Query the Loaded Data

Switch back to the 1st terminal where the `customers` table is created.

You can query the data loaded in the `customers` table using standard SQL and any supported functions and operators.

You can also manipulate the data, such as updating the loaded data or inserting more data, using standard DML commands.


### Query All Data

Return all rows and columns from the table:

```
select * from customers;
```

Result is displayed as:

```
-- Partial results shown
 first_name | last_name  |         email         |          address          |        city        | registration_date
------------+------------+-----------------------+---------------------------+--------------------+-------------------
 John       | Howie      | jh@test.com           | 7 Tomscot Way             | Pampas Chico       | 2017-04-13
 Cathy      | Deer       | cd6@test.co.au        | 535 Basil Terrace         | Magapit            | 2016-12-17
 Gra        | Wis        | gw@test.com           | 162 Debra Lane            | Shiquanhe          | 2017-06-06
 Ivy        | Case       | ic@test.com           | 84 Holmberg Pass          | Campina Grande     | 2017-03-29
 Cesar      | Hok        | ch9@test.com          | 5 7th Pass                | Miami              | 2016-12-21
 
...

```


### Count Total Number of Rows

Count total number of rows, and should see 24 rows which was copied into the table in above steps.


```
select count(*) from customers;
```

Result is displayed as:

```
 count
-------
    24
(1 row)

```


### Insert Additional Rows of Data

In addition to loading data from staged files into a table, you can insert rows directly into a table using the INSERT DML command.

For example, to insert two additional rows into the table:

```
insert into customers values
  ('Clementine','Adamou','cadamou@test.com','10510 Sachs Road','Klenak','2017-9-22') ,
  ('Marlowe','De Anesy','madamouc@test.co.uk','36768 Northfield Plaza','Fangshan','2017-1-26');
```

Result is displayed as:

```
INSERT 0 2
```

### Query Rows Based on Email Address

Return a list of email addresses with United Kingdom domain names using the LIKE function:

```
select email from customers where email like '%.uk';
```

Result is displayed as:

```
         email
------------------------
 madamouc@test.co.uk
 rtalmadgej@test.co.uk
 gbassfordo@test.co.uk
```

### Query Rows Based on Start Date

Add 90 days to customer registration dates using the PostgreSQL's date/time operator to calculate when marketing campaign for certain customers might start. Filter the list by customers whose registration date occurred earlier than January 1, 2017:

```
select first_name, last_name, registration_date + interval '90 days' from customers where registration_date <= '2017-01-01';
```


Result is displayed as:

```
 first_name | last_name |      ?column?
------------+-----------+---------------------
 Cathy      | Deer      | 2017-03-17 00:00:00
 Cesar      | Hok       | 2017-03-21 00:00:00
 Wallis     | Sizey     | 2017-03-30 00:00:00
 Granger    | Bassford  | 2017-03-30 00:00:00
```


## Summary and Clean Up

Congratulations! You have successfully completed this introductory tutorial!

Please take a few minutes to review a short summary and the key points covered in the tutorial. You might also want to consider cleaning up by dropping any objects you created in the tutorial.

### Tutorial Clean Up (Optional)

Execute the following DROP statements to return your system to its state before you began the tutorial:

```
drop table customers;
```

Switch back to `postgres` database, and run:

```
drop database quickstart;
```