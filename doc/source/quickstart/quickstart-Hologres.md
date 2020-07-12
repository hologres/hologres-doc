# Welcome to Hologres

Welcome to Hologres,wait for more ideas from you!

- Hologres Introduction
- Data Preparation
- Hologres Initialization
- Data Uploading
- Query Time
- Commands in Linux and SQL 

## Hologres Introduction

Hologres seamlessly opens up with the big data ecology, supporting high concurrency and low delay analysis and processing of PB-level data, allowing you to easily and economically use existing BI tools for multi-dimensional analysis, perspective and business exploration of data.

For now, we have one stand-alone version of Hologres to try!

## Data Preparation

1.Data Source

First,download a large amount of data to get familiar with Hologres. In this blog,we take some flight data from [the USA government example](http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time) without a license and therefore assumed to be in the public domain in the United States.

Github has a repro containing scripts and loaders for ["On-Time Performance"](https://github.com/Percona-Lab/ontime-airline-performance) data.

2.Download the Dataset

If you are in Linux, go with the following script and download the data；
One thing need to remember, choose the right directory before you start.

```
for s in `seq 1987 2018`
do
for m in `seq 1 12`
do
wget https://transtats.bts.gov/PREZIP/On_Time_Reporting_Carrier_On_Time_Performance_1987_present_${s}_${m}.zip
done
done
```

![image](../images/Quickstart/quickstart-Hologres/datadownload1.gif)

![image](../images/Quickstart/quickstart-Hologres/datadownload2.gif)

Data is stored in CSV (with , delimiter) format.  Total uncompressed CSV files size is about 79852548 Bytes (about 77GB). 
Note: in 1987, only 10,11,12 (3 months) data is available for download.
Note: the following 14 files fails to upload in Hologres for the invalid byte sequence for encoding.

| NO | FILES |
|---|---|
| 1 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_1.csv |
| 2 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_2.csv |
| 3 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_3.csv |
| 4 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_4.csv |
| 5 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_5.csv |
| 6 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_6.csv |
| 7 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_7.csv |
| 8 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_8.csv |
| 9 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_9.csv |
| 10 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_10.csv |
| 11 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_11.csv |
| 12 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2001_12.csv |
| 13 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2002_1.csv |
| 14 | On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2002_2.csv |


we better delete these 14 files by:

```
# remove the files in 2001 .12 files in total  
rm -f On_Time_Reporting_Carrier_On_Time_Performance_\(1987_present\)_2001*.csv

# remove the files in 2002_1 and 2002_2 ,2 files in total  
rm -f On_Time_Reporting_Carrier_On_Time_Performance_\(1987_present\)_2002_1.csv
rm -f On_Time_Reporting_Carrier_On_Time_Performance_\(1987_present\)_2002_2.csv
```

3.Unzip the Dataset 

Once download the data, go to the directory and unzip the data with the following script:

```
find . -name '*.zip'-exec unzip {} \；
```

the following warning might come, [N] is priority:
```
#replace readme.html? [y]es, [n]o, [A]ll, [N]one, [r]ename: 
```

## Hologres Initialization

Let's connect Hologres with the following script.

```
PGPASSWORD=[password] psql -U [username] -h [host] -p [port] -d [database]
```

Now you have landed Hologres successfully.

Let's check the database in Hologres and if nothing goes wrong there shoud be no database.

```
\l
```

Let's create some database and check.

```
CREATE DATABASE HOLO_TESTDB；
\l;
```

Since the table we need is quite long let's save it into a file.
Create a file firstly,then save the script.

As fowllowing, create one "data.ddl".

```
mkdir /temp/testDDL/data.ddl
```

Save the script into the file.
```
BEGIN;
CREATE TABLE ontime (
  FltYear integer not null,
  FltQuarter integer not null,
  FltMonth integer not null,
  FltDayofMonth integer,
  FltDayOfWeek integer,
  FlightDate date,
  UniqueCarrier text,
  AirlineID integer,
  Carrier text,
  TailNum text,
  FlightNum text,
  OriginAirportID integer,
  OriginAirportSeqID integer,
  OriginCityMarketID integer,
  Origin text,
  OriginCityName text,
  OriginState text,
  OriginStateFips text,
  OriginStateName text,
  OriginWac integer,
  DestAirportID integer,
  DestAirportSeqID integer,
  DestCityMarketID integer,
  Dest text,
  DestCityName text,
  DestState text,
  DestStateFips text,
  DestStateName text,
  DestWac integer,
  CRSDepTime text,
  DepTime text,
  DepDelay numeric(13,2),
  DepDelayMinutes numeric(13,2),
  DepDel15 numeric(13,2),
  DepartureDelayGroups integer,
  DepTimeBlk text,
  TaxiOut numeric(13,2),
  WheelsOff text,
  WheelsOn text,
  TaxiIn numeric(13,2),
  CRSArrTime text,
  ArrTime text,
  ArrDelay numeric(13,2),
  ArrDelayMinutes numeric(13,2),
  ArrDel15 numeric(13,2),
  ArrivalDelayGroups integer,
  ArrTimeBlk text,
  Cancelled numeric(13,2),
  CancellationCode text,
  Diverted numeric(13,2),
  CRSElapsedTime numeric(13,2),
  ActualElapsedTime numeric(13,2),
  AirTime numeric(13,2),
  Flights numeric(13,2),
  Distance numeric(13,2),
  DistanceGroup integer,
  CarrierDelay numeric(13,2),
  WeatherDelay numeric(13,2),
  NASDelay numeric(13,2),
  SecurityDelay numeric(13,2),
  LateAircraftDelay numeric(13,2),
  FirstDepTime text,
  TotalAddGTime numeric(13,2),
  LongestAddGTime numeric(13,2),
  DivAirportLandings numeric(13,2),
  DivReachedDest numeric(13,2),
  DivActualElapsedTime numeric(13,2),
  DivArrDelay numeric(13,2),
  DivDistance numeric(13,2),
  Div1Airport text,
  Div1AirportID integer,
  Div1AirportSeqID integer,
  Div1WheelsOn text,
  Div1TotalGTime numeric(13,2),
  Div1LongestGTime numeric(13,2),
  Div1WheelsOff text,
  Div1TailNum text,
  Div2Airport text,
  Div2AirportID integer,
  Div2AirportSeqID integer,
  Div2WheelsOn text,
  Div2TotalGTime numeric(13,2),
  Div2LongestGTime numeric(13,2),
  Div2WheelsOff text,
  Div2TailNum text,
  Div3Airport text,
  Div3AirportID integer,
  Div3AirportSeqID integer,
  Div3WheelsOn text,
  Div3TotalGTime numeric(13,2),
  Div3LongestGTime numeric(13,2),
  Div3WheelsOff text,
  Div3TailNum text,
  Div4Airport text,
  Div4AirportID integer,
  Div4AirportSeqID integer,
  Div4WheelsOn text,
  Div4TotalGTime numeric(13,2),
  Div4LongestGTime numeric(13,2),
  Div4WheelsOff text,
  Div4TailNum text,
  Div5Airport text,
  Div5AirportID integer,
  Div5AirportSeqID integer,
  Div5WheelsOn text,
  Div5TotalGTime numeric(13,2),
  Div5LongestGTime numeric(13,2),
  Div5WheelsOff text,
  Div5TailNum text,
  trailer integer
);

CALL set_table_property('ontime', 'clustering_key', 'FltYear, FltQuarter, FltMonth');
CALL set_table_property('ontime', 'segment_key', 'FltYear');
CALL set_table_property('ontime', 'shard_count', '1');
CALL set_table_property('ontime', 'bitmap_columns', 'OriginState, DestState, FltDayofMonth, FltDayOfWeek, Carrier');
CALL set_table_property('ontime', 'dictionary_encoding_columns', 'UniqueCarrier, Carrier, TailNum, Origin, OriginCityName, OriginState, OriginStateName, Dest, DestCityName, DestState, DestStateName, DepTimeBlk, WheelsOff, WheelsOn, ArrTimeBlk, CancellationCode, Div1Airport, Div1WheelsOn, Div1WheelsOff, Div1TailNum, Div2Airport, Div2WheelsOn, Div2WheelsOff, Div2TailNum, Div3Airport, Div3WheelsOn, Div3WheelsOff, Div3TailNum, Div4Airport, Div4WheelsOn, Div4WheelsOff, Div4TailNum, Div5Airport, Div5WheelsOn, Div5WheelsOff, Div5TailNum');
CALL set_table_property('ontime', 'time_to_live_in_seconds', '31536000');
COMMIT;
```

After you finish the script file,go to the database you have created and execute the script file.

```
\i /temp/testDDL/data.ddl
```

```
BEGIN
CREATE TABLE
CALL
CALL
CALL
CALL
CALL
CALL
CALL
COMMIT
```

Let's check the table "ontime" we have just executed.

```
\d ontime
```

Now you have prepare one database with one table!

## Data Uploading

Let's upload the data we have prepared early.
Follow me with uploading one csv file just for a quick test( we take keyword "copy ...from... " to upload data here).

```
\COPY ontime FROM '/temp/testdata_file/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_1987_10.csv' DELIMITER ',' CSV HEADER;
```

Data is uploaded successfully as following.
```
COPY 448620
```

Let's check the data.

```
select * from ontime limit 100;
```

Congratulation：no bug!
Now you could upload the rest in one time (374 files in total)
Note: mutiole csv files should be uploaded in 5 minutes by the following script:

```
cat /temp/*.csv |PGPASSWORD=[] psql -U [user] -h [host] -p [port] -d [database] -c 'copy ontime from stdin CSV HEADER'
```

you can also upload the data seperately by the following script:

```
\COPY ontime FROM 'temp/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_1987_10.csv' DELIMITER ',' CSV HEADER;
```
ops!

```

ERROR:  exec query failed => status:7,error=ERROR:  Query:[20000745330718297] Get result failed: code: kActorInvokeError
msg: "code: kInternalError msg: \"status { code: SERVER_INTERNAL_ERROR message: \\\"query next from pg executor failed from 11.160.224.215:19577: failed to query next, detail:invalid byte sequence for encoding \\\\\\\"UTF8\\\\\\\": 0xe2 0x22 0x2c [method:QueryNext,transaction_id:20000745330718297,query_id:20000745330718297,batch_id:0,actor_id:837916746126030549:23,worker_address:11.160.224.215:37769,11.160.224.215:31851]\\\" }\""
```

As I mentioned at the beginning,14 files fails uploading for the invalid byte sequence for encoding.
Let's do the final check.

```
select count(*) from ontime;
```

```
count
-------
177821031
```

## Query Time

We prepare 10 easy query for you to have a try:
1.--Query 1: Average monthly flight takeoff and landing records

```
SELECT avg(c1) 
FROM ( SELECT FltYear, FltMonth, count(*) as c1 FROM ontime GROUP BY FltYear, FltMonth ) A;
```

2.--Query 2: Daily flights from 2000 to 2008

```
SELECT FltDayOfWeek, count(*) as c 
FROM ontime 
where FltYear>=2000 AND FltYear<=2008 
GROUP BY FltDayOfWeek 
ORDER BY c DESC;
```

3.--Query 3: Count the number of flights delayed from 2000 to 2008 (more than 10 minutes, the same below) by week

```

SELECT FltDayOfWeek, count(*) as c 
FROM ontime 
WHERE DepDelay>10 AND FltYear>=2000 AND FltYear<=2008 
GROUP BY FltDayOfWeek 
ORDER BY c DESC;
```

4.--Query 4:Statistics of the number of delays from 2000 to 2008 by departure airport

```
SELECT Origin, count(*) as c 
FROM ontime 
WHERE DepDelay>10 AND FltYear>=2000 AND FltYear<=2008 
GROUP BY Origin 
ORDER BY c DESC 
LIMIT 10;
```

5.--Query 5: According to airline statistics, the number of delays in 2007

```
SELECT Carrier, count(*) 
FROM ontime
WHERE DepDelay>10 AND FltYear=2007 
GROUP BY Carrier 
ORDER BY count(*) DESC;
```

6.--Query 6: According to airline statistics, the percentage of delays in 2007

```
SELECT Carrier, c, c2, c*100/c2 as c3
FROM  
  ( SELECT Carrier, count(*) as c FROM ontime WHERE depdelay>10 AND FltYear=2007 GROUP BY Carrier ) A 
  INNER JOIN 
  ( SELECT Carrier, count(*) as c2 FROM ontime WHERE FltYear=2007 GROUP BY Carrier ) B using (Carrier) 
ORDER BY c3 DESC;
```

7.--Query 7: According to airline statistics, the percentage of delays from 2000 to 2008

```
SELECT Carrier, c, c2, c*100/c2 as c3 
FROM 
  ( SELECT Carrier, count(*) as c FROM ontime WHERE DepDelay>10 AND FltYear>=2000 AND FltYear<=2008 GROUP BY Carrier ) A 
  INNER JOIN 
  ( SELECT Carrier, count(*) as c2 FROM ontime WHERE FltYear>=2000 AND FltYear<=2008 GROUP BY Carrier ) B using (Carrier) 
ORDER BY c3 DESC;
```

8.--Query 8: Statistics of flight delay rate by year

```
SELECT FltYear, c1/c2 as ratio
FROM 
  ( SELECT FltYear, count(*)*100 as c1 FROM ontime WHERE DepDelay>10 GROUP BY FltYear ) A 
  INNER JOIN
  ( SELECT FltYear, count(*) as c2 FROM ontime GROUP BY FltYear ) B using (FltYear) 
ORDER BY FltYear ;
```

9.--Query 9: Number of flights per year

```
SELECT FltYear, count(*) as c1 
FROM ontime  
GROUP BY FltYear;
```

10.--Query 10: Multi-dimensional complex filtering and aggregation

```
SELECT 
  min(FltYear), 
  max(FltYear), 
  Carrier, 
  count(*) as cnt, 
  sum(ArrDelayMinutes) as flights_delayed, 
  round(sum(ArrDelayMinutes)/count(*), 2) as rate 
FROM ontime 
WHERE 
  FltDayOfWeek not in (6,7) AND 
  OriginState not in ('ak', 'hi', 'pr', 'vi') AND 
  DestState not in ('ak', 'hi', 'pr', 'vi') AND 
  ArrDelayMinutes > 30 AND
  FlightDate < '2010-01-01' 
GROUP BY Carrier HAVING count(*)>100000 AND max(FltYear)>1990 
ORDER BY rate DESC 
LIMIT 1000;
```
You could try more in Hologres!

## Commands in Linux and SQL

This part is prepared for you to refer !

### Commonly used in Linux

#### General Commands

- history – lists the last used commands on your Linux server
make – when compiling a software from source, this command will create the binaries

- id – who am I right now? besides the philosophical angle, this command will show you as which user you will be running commands, I use this to check what is my status, and then sudo to the user I need

- sudo – execute a command as another user – although  usually use it to change to root
- ps – list the running processes on the server, it give more info like the process id, the parent process id, running time and much more

- man – displays a manual page, whenever you are not sure about a specific command or config file, you should run “man command” to get info about it. to search the man database use “whatis command” to find which man file has the info you need

- df – report file system disk space usage, use “df -h” to get a human formatted listing

#### Files and Directories Management

- ls – Lists files and directories content, I usually use “ls -la” to have a long listing with all the details and hidden files
cd – move from the current directory to a different folder

- pwd – lists your current location

- mv – this command can either change the name of a file, or move it to a different location

- locate – find any file on the Linux server, to get an updated index of files (if for example you just installed a whole bunch of RPM’s) run the command updatedb

- ln – create a shortcut to a file or folder

- tar – create or extract files out of a storage file. with the correct arguments it will also compress the files 

#### Editing and Viewing

- tail – lists the last 10 lines of a file, but you tell tell it to show any number of last lines

- vi – the best command line editing software a little hard to learn how to work this one at first, buts its worth the effort  a little hard to learn how to work this one at first, buts its worth the effort

- cat – list the content of the file. better know how long is the file you are running this command on, or you will get a very long scrolling of lines that will fill up your screen

### Commonly used in SQL

#### A. Data Definition Language (DDL)

1.CREATE

CREATE queries are used to create a new database or table.

```
CREATE TABLE table_name (
  column_1 datatype_1,
  column_2 datatype_2,
);
```

2.ALTER

ALTER queries are used to modify the structure of a database or a table such as adding a new column, change the data type, drop, or rename an existing column, etc.

```
ALTER TABLE table_name 
ADD column_name datatype;
```

3.DROP

DROP queries are used to delete a database or table. You should also be careful when using this type of query because it will remove everything, including table definition along with all the data, indexes, triggers, constraints and permission specifications for that table.

```
DROP TABLE table_name;
```

4.TRUNCATE

TRUNCATE queries are used to clean the table, remove all the existing records, but not the table itself.

```
TRUNCATE TABLE table_name;
```

#### B. Data Manipulation Language (DML)

1.SELECT
- SELECT … FROM … is the most basic and commonly used query in SQL. It’s used for retrieving data from a table.
A common SELECT query is broken down into four main parts:
- SELECT
- FROM
- WHERE
- ORDER BY

Let’s look deeper
- To see data of an entire table:

```
SELECT * FROM table_name;
```

- To see data in some specific columns:

```
SELECT column_name(s) FROM table_name;
```

- To see data from your table based on some conditions, this is the case for WHERE to be used:

```
SELECT column_name(s)
FROM table_name
WHERE condition(s);
```

By using WHERE in a SELECT query, we add one or more conditions and restrict the number the records affected by the query.
Or in other words, it’s being a filter to filter out only the records that match the conditions as the result.
Example:

```
SELECT * FROM students
WHERE state_code = 'CA'
```

That query to show every record from the table students that match the state_code “CA”.
- ORDER BY is a clause that indicates you want to sort the result set by a particular column either alphabetically or numerically.

```
SELECT column_name
FROM table_name
ORDER BY column_name ASC | DESC;
```

2.INSERT
INSERT INTO queries are used to insert one or more rows of data (new records) into an existing table.

```
INSERT INTO table_name (column_1, column_2, column_3, ...)
VALUES (value_1, value_2, value_3, ...);
```

Example:
```
INSERT INTO students (full_name, student_id, state_code)
VALUES (“Alex Jonas”, 234, "CA");
```

3.UPDATE
UPDATE queries are used to modify an existing table and update it with new data based on some conditions.

```
UPDATE table_name
SET column_1 = value_1, column_2 = value_2, ...
WHERE condition;
```

4.DELETE
DELETE FROM queries are used to remove the records from a table based on some conditions. DELETE FROM is similar to TRUNCATE but it limits the number of rows being affected by the query using the conditions.

```
DELETE FROM table_name
WHERE condition;
```
#### C. Aggregate Functions

- AVG() returns the average value for a numeric column.

```
SELECT AVG(column_name)
FROM table_name;
```

- SUM() returns the sum of all the values in a column.

```
SELECT SUM(column_name)
FROM table_name;
```

- ROUND() rounds the values in the column to the number of decimal places specified by the integer.

```
SELECT ROUND(column_name, integer)
FROM table_name;
```

- MAX() returns the largest value in a column.

```
SELECT MAX(column_name)
FROM table_name;
```

- MIN() returns the smallest value in a column.

```
SELECT MIN(column_name)
FROM table_name;
```

- COUNT() counts the number of rows where the column is not NULL.

```
SELECT COUNT(column_name)
FROM table_name;
```
#### Additional clauses and functions

- You can use AS to rename a column or table temporarily using an alias on the result view.

```
SELECT column_name AS 'Alias'
FROM table_name;
```

- The BETWEEN operator is used to select the value within a certain range.

```
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value_1 AND value_2;
```

- GROUP BY is a clause in SQL that is only used with aggregate functions (COUNT, MAX, MIN, SUM, AVG). It is used in collaboration with the SELECT statement to arrange identical data into groups.

```
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name;
```

- HAVING is used to replace WHERE to work with aggregate functions. WHERE clause introduces a condition on individual rows; HAVING clause introduces a condition on aggregations.
HAVING is typically used with GROUP BY.

```
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name
HAVING COUNT(*) > value;
```

- IS NULL and IS NOT NULL are used to test whether a column value is empty or not.

```
SELECT column_name(s)
FROM table_name
WHERE column_name IS NULL;
```

- LIKE is a special operator used with the WHERE clause to search for a specific pattern in a column.

```
SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;
```

- You can use LIMIT to specify the maximum number of records you want to show in a result set.

```
SELECT *
FROM table_name
LIMIT number;
```

- OR is used to combine two or more conditions in a where clause. The results have to match at least one of the conditions specified.

```
SELECT *
FROM table_name
WHERE condition_1
   OR condition_2;
```

- SELECT DISTINCT returns unique values in the specified column(s).

```
SELECT DISTINCT column_name
FROM table_name;
```

- An OUTER JOIN will combine rows from different tables even if the join condition is not met. Every row in the left table is returned in the result set, and if the join condition is not met, then NULL values are used to fill in the columns from the right table.

```
SELECT column_name(s)
FROM table_1
LEFT JOIN table_2
  ON table_1.column_name = table_2.column_name;
```

- An INNER JOIN will combine rows from different tables if the join condition is true.

```
SELECT column_name(s)
FROM table_1
JOIN table_2
  ON table_1.column_name = table_2.column_name;
```
