# DROP DATABASE

## Introduction 

DROP DATABASE -- Drop an existing database.

## Synopsis

```sql
DROP DATABASE [ IF EXISTS ] db_name;
```
## Limitation

1. It can only be executed by the super user of the database owner which is assigned by the super user.
1. Drop database will remove all the entities of the database.
1. The database will be inaccessible after it is dropped.
## Example

Drop an existing database.
```sql
drop database mydb;
```