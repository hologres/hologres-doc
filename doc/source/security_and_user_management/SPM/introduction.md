# Introduction of Simple Permission Model

This section will introduce the simple permission model of Hologres.

# Background

Hologres is compatible with Postgres and uses the same permission system of Postgres. The typical Postgres permission system is very strict. For example, in business scenarios, when business person tries to authorize a user, he/she need to execute a lot of permission statements. And different roles have different permissions, which is tedious. And a missing permission statement could cause authorization failure.

It's hard to ask every user be an expert of the permission system of Postgres. Besides, the misuse of permission management, will not only bring security risk to the business, but also increase the user's management cost.

Hologres provides a coarse-grained simple permission model (SPM) based on PostgreSQL permissions. The simple permission model takes DB as the dimension, and provides the four roles of admin (administrator), developer (developer), writer (reader and writer) and viewer (analyst). Users can manager a DB by a small number of permission management statement.

# Simple Permission Model Introduction

Simple permission model has six permission groups for each DB:

- superuser：superuser
- DB administrator：<db>_admin
- developer：<db>_developer
- writer：<db>_writer
- viewer：<db>_viewer
- Others: Users not belong to any of the above user groups                                    

| Role           | Permission                                                   |
| -------------- | ------------------------------------------------------------ |
| **Superuser**  | The administrator of the instance, and has all the permissions |
| ******_admin** | The administrator of DBThe admin group is also developer group, and it has the superset of the permissions of the developer group, writer group, and viewer groupOwner of a certain DB, can delete it.Can manage the members of the current DB under the <db> _admin, <db> _developer, <db> _writer and <db> _viewer user groups, including add/delete user to groupCan create objects in the DB, such as schema, and can add, delete, modify and check the objectscan modify DB configurations |
| **_developer** | Developer of DB；The developer group is also a writer group, and has the superset of the permissions of the writer group and viewer group;Except the permission of manage DB and Users, The developer group have full permission of tables, external tables, table-like objects (such as views, etc.), Function, Procedure, Foreign Server, FDW, Type, and Language. can add, delete, modify and check all tables of all schemas;Except of the system schema, has The USAGE and CREATE permissions of all other schemas, can create tables, create views, create external tables and other DDL operations. |
| **_writer**    | Writer of DB;The writer group is also a viewer group, and has superset of the permissions of the viewer group;have permissions of SELECT, INSERT, UPDATE, and DELETE of tables. can add, delete, check, and modify the data of all tables, foreign tables, and table-like objects (such as views) under all schemas.Can access or use the Function, Procedure, Foreign Server, FDW, Type, and Language objects owned by the developer;only have USAGE permissions of All schema, DDL operations are not allowed; |
| **_viewer**    | Analyst of DB  (readonly);have SELECT permission: can read the data of all tables, foreign tables and table-like objects (such as views, etc.) of all schemas, that is,Can access or use the Function, Procedure, Foreign Server, FDW, Type, and Language objects owned by the developer;USAGE permissions for all schemas; |
| **Others**     | Users not belong to any of the above user groupsCannot connect to the DB;To connect a certain DB, the user must be add to one of the; above user groups by Superuser or <db>_admin. |

  To authorize new users, please refer to the usage of the simple permission model section                                     

​                                           

​                                           

​                                           

​                                           

​                                           

​                                           



