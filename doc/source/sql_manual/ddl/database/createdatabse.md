# CREATE DATABASE

# Introduction
CREATE DATABASE -- create a new database.<br />To create a database, you must be a superuser or have the special `CREATEDB` privilege.

Note: A default database named postgres is created automatically by the service when the instance is created successfully. However, the allocated resource quota is limited on this database, creating new databases are recommended.
<a name="GfrrN"></a>
# Synopsis
```sql
CREATE DATABASE db_name
    [ [ WITH ] [ OWNER [=] user_name ]
;
```
<a name="LhwbM"></a>
# Parameters

- _**db_name**: _The name of a database to create. The name must be unique within the instance and comply with the rules for SQL identifiers.
- _**user_name**:_ The role name of the user who will own the new database. By default, the current user (namely, the user executing the command) will be the owner of the database. The owner has the permission to delete the database, which operation will remove the entities of the database, including table and data, etc.
- The super user can create database for other users and make them as owner. And then database owner can manage and configure the database.
<a name="pJO3v"></a>
# Example
To create a new database:
```sql
create database testdb;
```