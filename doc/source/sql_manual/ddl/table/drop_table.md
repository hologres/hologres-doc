# DROP TABLE

## Introduction

drop table：drop a table. 

## Synopsis

```sql
DROP TABLE [ IF EXISTS ] table_name [, ...];
```
## Parameters

DROP TABLE supports DROP multiple tables in one command. 

If "IF EXISTS" is provided, the command will succeeded no matter if the table exists or now. If "IF EXISTS" is not provided, and the target table does not exist. The following error will be returned: "ERROR:  table "non_exist_table" does not exist."

## Example

```sql
drop table test;
```

