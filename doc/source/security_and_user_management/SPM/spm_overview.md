# Simple Permission Model Overview

This section will introduce the simple permission model of Hologres.

## Background

Hologres is compatible with Postgres and uses the same permission system of Postgres. The typical Postgres permission system is very strict. For example, in business scenarios, when business personnel try to authorize a user, he/she need to execute a lot of permission statements. And Different roles have different permissions, which is tedious. And a missing permission statement could cause authorization failure.

It's hard to ask every user be an expert of the permission system of Postgres. Besides, the misuse of permission management, will not only bring security risk to the business, but also increase the user's management cost.

Hologres provides a coarse-grained simple permission model (SPM) based on PostgreSQL permissions. The simple permission model takes DB as the dimension, and provides the four roles of admin (administrator), developer (developer), writer (reader and writer) and viewer (analyst). Users can manager a DB by a small number of permission management statement.

## Simple Permission Model Introduction

Simple permission model has six permission groups for each DB:                                

| Role             | Permission                                                   |
| ---------------- | ------------------------------------------------------------ |
| **Superuser**    | The administrator of the instance, and has all the permissions |
| **db_admin**     | - The administrator of DB.<br />- The admin group is also developer group, and it has the superset of the permissions of the developer group, writer group, and viewer group.<br />- Owner of a certain DB, can delete it.<br />- Can manage the members of the current DB under the db _admin, <db> _developer, db _writer and db _viewer user groups, including add/delete user to group.<br />- Can create objects in the DB, such as schema, and can add, delete, modify and check the objects .<br />- can modify DB configurations |
| **db_developer** | - Developer of DB.<br />- The developer group is also a writer group, and has the superset of the permissions of the writer group and viewer group.<br />- Except the permission of manage DB and Users, The developer group have full permission of tables, external tables, table-like objects (such as views, etc.), Function, Procedure, Foreign Server, FDW, Type, and Language. can add, delete, modify and check all tables of all schemas;<br />- Except of the system schema, has The USAGE and CREATE permissions of all other schemas, can create tables, create views, create external tables and other DDL operations. |
| **db_writer**    | - Writer of DB.<br />- The writer group is also a viewer group, and has superset of the permissions of the viewer group;<br />- have permissions of SELECT, INSERT, UPDATE, and DELETE of tables. can add, delete, check, and modify the data of all tables, foreign tables, and table-like objects (such as views) under all schemas.<br />- Can access or use the Function, Procedure, Foreign Server, FDW, Type, and Language objects owned by the developer;<br />- Only have USAGE permissions of All schema, DDL operations are not allowed; |
| **db_viewer**    | - Analyst of DB  (readonly).<br />- have SELECT permission: can read the data of all tables, foreign tables and table-like objects (such as views, etc.) of all schemas, that is.<br />- Can access or use the Function, Procedure, Foreign Server, FDW, Type, and Language objects owned by the developer.<br />- USAGE permissions for all schemas; |
| **Others**       | - Users not belong to any of the above user groups.<br />- Cannot connect to the DB.<br />- To connect a certain DB, the user must be add to one of the; above user groups by Superuser or db_admin. |                               

To authorize new users, please refer to the usage of the simple permission model section