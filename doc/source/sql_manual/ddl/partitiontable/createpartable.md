# CREATE/DROP PARTITION TABLE

# create partition table
<a name="Zu6wi"></a>
## Introduction
create partition table：create Hologres partition tables.
<a name="ad3HH"></a>
## Synopsis
```sql
--  "create partition table" format
create table [if not exists] [schema_name.]table_name partition by list (column_name) ([
  {
   column_name column_type [column_constraints, [...]]
   | table_constraints
   [, ...]
  }
]);

-- typical create child partition table exmaple:
create table [if not exists] [schema_name.]table_name partition of parent_table
	for values in (string_literal);
```
<a name="WiDUI"></a>
## Limitation

1. Can not insert any data into parent table.
1. Drop the parent table will cascade to also drop the child table (the partition table)
1. Partition key column must be of text/varchar/int type.
1. One partition rule for one partition table.
1. partition by also supports list, only one value can be used to split the partition list.
<a name="Uf5Lm"></a>
## Example
<br />
```sql
begin;
create table hologres_parent(a text primary key, b int, c timestamp, d text) partition by list(a);
call set_table_property('hologres_parent', 'orientation', 'column');
call set_table_property('hologres_parent', 'clustering_key', 'a,b'); 
call set_table_property('hologres_parent', 'segment_key', 'c');
call set_table_property('hologres_parent', 'bitmap_columns', 'a,d'); 
call set_table_property('hologres_parent', 'dictionary_encoding_columns', 'a,d'); 
call set_table_property('hologres_parent', 'time_to_live_in_seconds', '86400');
create table hologres_child1 partition of hologres_parent for values in('a');
create table hologres_child2 partition of hologres_parent for values in('b');
create table hologres_child3 partition of hologres_parent for values in('c');
commit;
```
<br />
<a name="aEpDR"></a>
# drop partition table
DROP PARTITION TABLE is similar to DROP TABLE. 