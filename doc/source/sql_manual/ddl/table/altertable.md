# ALETER TABLE

Current Hologres version only supports 1. changing name , 2.add new columns and 3.alter table property by "ALTER TABLE". There is no such limitation against Foreign Tables.<br />For Hologres Partition Table ATTACH PARTITION and DETACH PARTITION are also supported. See more details below. 

<a name="LwIjx"></a>
## Rename Table
<a name="uzLhh"></a>
## Synopsis
```sql
ALTER TABLE table_name RENAME to new_table_name;
ALTER FOREIGN TABLE my_foreign_table_name to my_new_foreign_table_name;
```
<br />
<a name="4PpS3"></a>
### Notes
An error would return if trying to change a name for a table not exist, or change an exist table to a name conflicting table name. 
<a name="PGVtM"></a>
### Example
```sql
ALTER TABLE test RENAME to holo_test ;
ALTER FOREIGN TABLE odps_test to my_odps_test;
```


<a name="VvF8h"></a>
## Add Column
<a name="2fn5K"></a>
## Synopsis
```sql
ALTER TABLE IF EXISTS table_name ADD COLUMN new_column_name data_type;
ALTER TABLE IF EXISTS table_name ADD COLUMN col_add_1 data_type, ADD COLUMN col_add_2 TEXT IF NOT EXISTS col_add_2 data_type; 
```
<a name="4eVwG"></a>
### Example
```sql
ALTER TABLE IF EXISTS holo_test ADD COLUMN id int;
```


<a name="ewyrU"></a>
## Alter Table Property
In general, setting table property must be in the same transaction as "CREATE TABLE", however, the following properties can be changed independently:<br />

```sql
call set_table_property('tbl', 'bitmap_columns', '[columnName [,...]]'); 
call set_table_property('tbl', 'dictionary_encoding_columns', '[columnName [,...]]');
call set_table_property('tbl', 'time_to_live_in_seconds', '<non_negative_literal>');
```
<a name="fdJxB"></a>
### Example

1. Change bitmap indexing properties for columns.
```sql
call set_table_property('tbl', 'bitmap_columns', 'a,b');
```

1. Change dictionary encoding properties for columns.
```
call set_table_property('tbl', 'dictionary_encoding_columns', 'a,b');
```

1. Change table's TTL (time-to-live), unit is in seconds.
```sql
call set_table_property('tbl', 'time_to_live_in_seconds', '86400');
```