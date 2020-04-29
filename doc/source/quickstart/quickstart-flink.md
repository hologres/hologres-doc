# Using Hologres with Flink

In this tutorial, we will walk through examples of using Flink to 

1. write real-time streaming data into Hologres
2. bulk load batch data into Hologres
3. bulk read all existing data from Hologres

For more detailed information of how to use Flink and Hologres together and how end-to-end exactly-once works, please see the following documents:

- [write data to Hologres using Flink](../data_load/flink.md)
- [read data from Holgores using Flink](../data_read_and_unload/flink.md)

## Prerequisites

This tutorial requires a database and table to load and query data. Creating Hologres objects requires a user with a role with the necessary access control permissions.

In addition, [psql (PostgreSQL Client)](https://www.postgresql.org/docs/current/app-psql.html) of PostgreSQL **version 11 or above** is required to execute the SQL statements in the tutorial. Please search online and see how to install psql in your machine, whether it's MacOS, Linux, Windows, etc.

An IDE like [IntelliJ IDEA](https://www.jetbrains.com/idea/) or Eclipse is highly recommend to run examples jobs, though these jobs can be run as junit tests via Maven from commandline as well. In this tutorial, we will use IntelliJ IDEA as example.

At last, the Flink examples requires JDK to run. It's recommended that you have JDK 1.8 installed in the environment. 


## Create Hologres Objects

### Create a Database

Following the steps in [Hologres in 20 minutes](quickstart.md) to create a database named `quickstart` and connect to it via psql.

### Create a Table

Create an `orders` table with the following command

```
create table orders(
	orders integer,
	custkey integer,
	orderstatus text,
	totalprice numeric(13, 2),
	primary key(orders)
);
```


## Downdload the Project and Import in IDE

### Download the project from following example repository from Github

[https://github.com/hologres/hologres-flink-examples](https://github.com/hologres/hologres-flink-examples)

### Import Project in IntelliJ IDEA

Open IntelliJ IDEA, import the downloaded project as `Maven` project, and select the "JDK for importer" as `1.8`. The other part of the process is exactly the same as importing as other Maven projects.

You should see the following product structure and files:

```
hologres-flink-examples
	- src
		- main
		- test
			- java
				- io.hologres.flink.examples
					- JobTestBase
					- SimpleBulkloadJobTest
					- SimpleReadJobTest
					- SimpleStreamingJobTest
	- pom.xml
	- README.md
```

### Set Hologres Configurations

In order to interact with a Hologres instance, you have to set Hologres configurations.

Take a look at `JobTestBase.java` file now, and it contains 5 variables, `DATABASE`, `USERNAME`, `PASSWORD`, `ENDPOINT`, and `TABLE`. The `TABLE` variable has been predefined as `orders` to match name of the table that is just created in Hologres. 

There are two ways to set the other four variables. You can either replace them in the `.java` file with plain strings, or set them in your environment variables. Note that if you set environment variables, you have to completely shutdown IntelliJ and restart for it to pick up new environment variables.


## Write Real-Time Streaming Data into Hologres

In this job, we will run a single-parallelism Flink streaming job which generates 100 rows per second with random data and writes to the `orders` table in Holgores.

### Clean the Table

Before running this example, clean the table by running `delete from orders;` in psql to make sure any previous testing data is deleted, and not interfere with the upcoming test you are going to run.


### Run the Job

In IntelliJ, right-click `SimpleStreamingJobTest` and click "Run 'SimpleStreamingJobTest'". The job starts running and writing data to Hologres. Data ingested into Hologres is immediately available! 

### Check the Data

So why wait? Let us now switch back the psql terminal and query the latest data as it coming in with queries like `select count(*) from orders` which shows how many rows are in the table.

```
select count(*) from orders;
-------
  1719
(1 row)

select count(*) from orders;
 count
-------
  1826
(1 row)

select count(*) from orders;
 count
-------
  1955
(1 row)
```

As the query is run multiple times, you can see that the number of rows keeps on growing as streaming data is written into Hologres.

### Terminate the Job

Remember to terminate the job after testing is done. This is a streaming job and otherwise will run forever and never terminate itself.


## Bulk Load Batch Data into Hologres

In this job, we will run a single-parallelism Flink batch job which read csv data in `/test/resources/csv/orders.csv` and bulk loads to the `orders` table in Holgores.

### Clean the Table

Before running this example, clean the table by running `delete from orders;` in psql to make sure any previous testing data is deleted, and not interfere with the upcoming test you are going to run.


### Run the Job

In IntelliJ, right-click `SimpleBulkloadJobTest` and click "Run 'SimpleBulkloadJobTest'". The job starts running and writing data to Hologres. After a while, it should finish and terminate itself. The job should bulk load 2800 records from the csv file to Hologres.

### Check the Data

Now switch back to the psql terminal, and check the data.

```
select count(*) from orders;
 count
-------
  2800
(1 row)
```

## Read Batch Data from Hologres

In this job, we will run a single-parallelism Flink batch job which bulk read the `orders` table in Holgores and output the number of rows in the table.


### Run the Job

In IntelliJ, right-click `SimpleReadJobTest` and click "Run 'SimpleReadJobTest'". The job starts running and writing data to Hologres. After a while, it should finish and terminate itself. 

Assuming that you run this job right after running the `SimpleBulkloadJobTest`. The job should will count the 2800 records in Hologres, and print the following message in your IntelliJ console:

```
There are 2800 records in table 'orders' in Hologres
```



