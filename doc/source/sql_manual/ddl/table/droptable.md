# DROP TABLE

# Introduction
drop table：drop a table. 
<a name="j9r29"></a>
# Synopsis
```sql
DROP TABLE [ IF EXISTS ] table_name [, ...];
```
<a name="eh3nL"></a>
# Parameters
DROP TABLE supports DROP multiple tables in one command. <br />If "IF EXISTS" is provided, the command will succeeded no matter if the table exists or now. If "IF EXISTS" is not provided, and the target table does not exist. The following error will be returned: "ERROR:  table "non_exist_table" does not exist."
<a name="vrogJ"></a>
# Example
```sql
drop table test;
```

