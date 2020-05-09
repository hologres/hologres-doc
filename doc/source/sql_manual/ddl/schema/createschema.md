# CREATE SCHEMA

In PostgreSQL, a database can contain multiple schemas, and public schema is the default configuration. Each user can use a database with his/her own schema, without interfering with each other, and it is also easy for administrators to maintain the database.

When a new schema is added to the Hologres, the storage structure of a table will be changed from database.table to database.schema.table. Each table belongs to a schema, and a database can have multiple schemas. Different schema can have the same object (table name, data type, etc.).

currently, Hologres supports create/alter/rename schema, and create table for a schema. Drop schema is not supported by now.

## Public Schema

Every database has a default schema, which is a public schema. And the tables created will be stored in the public schema by default.

to view the current schema is as following:

```sql
select current_schema(); 

\d tablename; // describe a table, and it also shows the schema it belongs to. it can only be called in the terminal
```

## Create Schema

Create a new schema in a database is as following:

```sql
create schema schemaname; 

set search_path to schemaname; 

creat table blink_demo (id text); 

select current_schema(); 

\d blink_demo; //describe table
```

## Create tables across Schema

Hologres supports the operation of tables of not only current schema but also other schemas by adding "schema_name." in front of the table name. Example is as following:

1.Create a table for the public schema

```sql
create table public.mytest (
  name text,
  id int);
```

2.create table for schema my_schema in public schema, the example is as following

```sql
set search_path to public;
create table my_schema.mytest (
  name text,
  id int,
  age int
);
```

