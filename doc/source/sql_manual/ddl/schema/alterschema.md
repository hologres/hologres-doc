# ALTER SCHEMA

## Introduction

alter schema rename：rename schema

## Synopsis

```sql
alter schema oldschema rename to newschema; 
```

## Limitation

After the rename statement is executed successfully, all the tables under the original schema will be transferred to the new schema, but the original schema will be kept.

## Example

```sql
alter schema my_schema rename to new_schema;
set search_path to my_schema;
set search_path to new_schema;
```