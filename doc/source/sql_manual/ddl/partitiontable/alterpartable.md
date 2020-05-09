# ALTER PARTITON TABLE

# Introduction
alter partition table：alter partition tables.
<a name="FoX3C"></a>
# Synopsis
Hologres support the following 3 types of command for "ALTER PARTITION TABLE":
```sql
ALTER TABLE [IF EXISTS] table_name RENAME to new_table_name;
ALTER TABLE [IF EXISTS] table_name ATTACH PARTITION new_partition_name FOR VALUES in (<string_literal>);
ALTER TABLE [IF EXISTS] table_name DETACH PARTITION paritition_name;
```
<a name="LhwbM"></a>
# Parameters
ATTACH PARTITION new_partition_name FOR VALUES in (<string_literal>)：The shares the same _`partition_bound_spec`_ as "CREATE TABLE". Which use the existing table (which itself could be a partition table) as a partition table of the target table.<br />Notes:

- The partition rule should follow the target table's partition rule and partition key.
- The columns of the partition table and target table must be identical: the same number of columns and the same type.
- Columns also must have the same NOT NULL constraint as the target table. If adding a column that will not accept `NULL` values, also add `NOT NULL` constraint to the partition key column, unless it's an expression.

`DETACH PARTITION` _`partition_name： `_ would detach target table's specified partition. The detached partition will exist as an independent table. 
<a name="wm2PB"></a>
# Example
```sql
ALTER TABLE holo_test RENAME to my_holo_test;// rename a table

ALTER TABLE holo_table ATTACH PARTITION my_table FOR VALUES in ('2015');// make holo_table as a partition of my_table

ALTER TABLE all_test DETACH PARTITION holo_test; // detach all_test from the partition tables of holo_test
```

