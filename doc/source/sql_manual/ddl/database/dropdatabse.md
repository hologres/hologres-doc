# DROP DATABASE

# Introduction 
DROP DATABASE -- Drop an existing database.
<a name="HaMD7"></a>
# Synopsis
```sql
DROP DATABASE [ IF EXISTS ] db_name;
```
<a name="pvOIj"></a>
# Limitation<br />

1. It can only be executed by the super user of the database owner which is assigned by the super user.
1. Drop database will remove all the entities of the database.
1. The database will be inaccessible after it is dropped.
<a name="jcNJ1"></a>
# Example
Drop an existing database.<br />
```sql
drop database mydb;
```