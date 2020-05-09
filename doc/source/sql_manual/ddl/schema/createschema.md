# CREATE SCHEMA

This section will introduce the usage of create schema in Hologres.<br />In PostgreSQL, a database can contain multiple schemas, and public schema is the default configuration. Each user can use a database with his/her own schema, without interfering with each other, and it is also easy for administrators to maintain the database.<br />When a new schema is added to the Hologres, the storage structure of a table will be changed from database.table to database.schema.table. Each table belongs to a schema, and a database can have multiple schemas. Different schema can have the same object (table name, data type, etc.).<br />currently, Hologres supports create/alter/rename schema, and create table for a schema. Drop schema is not supported by now.
<a name="iiIOn"></a>

# public schema
Every database has a default schema, which is a public schema. And the tables created will be stored in the public schema by default.<br />to view the current schema is as following:
```sql
select current_schema(); //view current schema
\d tablename; // describe a table, and it also shows the schema it belongs to. it can only be called in the terminal
```
<a name="ctzzV"></a>
# create schema
Create a new schema in a database is as following:<br />

```sql
create schema schemaname; //create a new schema
set search_path to schemaname; //switch to the schema
creat table blink_demo (id text); //create a table in current schema
select current_schema(); //view current schema
\d blink_demo; //describe table
```
<a name="Icz2b"></a>
# Create tables across schema
Hologres supports the operation of tables of not only current schema but also other schemas by adding "schema_name." in front of the table name. Example is as following:<br />
<br />1.Create a table for the public schema
```sql
create table public.mytest (
  name text,
  id int);
```

<br />2.create table for schema my_schema in public schema, the example is as following<br />

```sql
set search_path to public;
create table my_schema.mytest (
  name text,
  id int,
  age int
);
```

