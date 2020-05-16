# COPY From Stdin

Hologres current version supports using copy command to upload data. Users can upload data from stdin  to specific tables.

## Introduction

COPY: upload client data from stdin to a table.

COPY FROM: copy data from stdin to a table (append data to the table).

## Synopsis

Hologres current version supports the following copy command:

```sql
COPY table_name [ ( column_name [, ...] ) ]
    FROM STDIN
    [ [ WITH ] ( option [, ...] ) ]
   
   where option can be one of:

    FORMAT format_name
    DELIMITER 'delimiter_character'
    NULL 'null_string'
    HEADER [ boolean ]
    QUOTE 'quote_character'
    ESCAPE 'escape_character'
    FORCE_QUOTE { ( column_name [, ...] ) | * }
    FORCE_NOT_NULL ( column_name [, ...] )
```

## Parameter

table_name：table name

STDIN：standard input

FORMAT：support text and csv. Default is text.

DELIMITER：delimiter between columns. Defalt is tab. For CSV，specify DELIMITER as ','

## Example

### 1. Upload data from stdin

```sql
-- 1.create table
CREATE  TABLE copy_test (
  id    int,
  age   int,
  name  text
) ;

--2. upload data（type enter to finishing data input）

COPY copy_test from stdin WITH DELIMITER AS ',' NULL AS '';
53444,24,wangming
55444,38,ligang
55444,38,luyong
\.

--3. query data
select * from  copy_test;
```

### 2. Upload data from stdin to CSV

```sql
-- 1. create table
create table partsupp ( ps_partkey          integer not null,
                        ps_suppkey     integer not null,
                        ps_availqty    integer not null,     
                        ps_supplycost  float  not null,
                        ps_comment     text not null );
                                                                                                       
--2. upload data
copy partsupp from stdin with delimiter '|' csv;  
1|2|3325|771.64|final theodolites 
1|25002|8076|993.49|ven ideas
\.

--3.query data
select * from  partsupp;
```

### 3. Update client file using CopyManager

```sql
package com.aliyun.hologram.test.jdbc;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

import org.postgresql.copy.CopyManager;
import org.postgresql.core.BaseConnection;

public class jdbcCopyFile {

	public static void main(String args[]) throws Exception {
		System.out.println(copyFromFile(getConnection(), "/Users/feng/Workspace/region.tbl", "region"));
	}

	public static Connection getConnection() throws Exception {
		Class.forName("org.postgresql.Driver");
		String url = "jdbc:postgresql://11.163.188.167:12692/postgres";
		Properties props = new Properties();
    //set db user
		props.setProperty("user", "AAA");
    //set db password
		props.setProperty("password", "BBB");
		return DriverManager.getConnection(url, props);
	}

	/*
	 * 
	 * @param connection
	 * @param filePath
	 * @param tableName
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public static long copyFromFile(Connection connection, String filePath, String tableName)
			throws SQLException, IOException {
		long count = 0;
		FileInputStream fileInputStream = null;

		try {
			CopyManager copyManager = new CopyManager((BaseConnection) connection);
			fileInputStream = new FileInputStream(filePath);
			count = copyManager.copyIn("COPY " + tableName + " FROM STDIN delimiter '|' csv", fileInputStream);
		} finally {
			if (fileInputStream != null) {
				try {
					fileInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return count;
	}

}
```

