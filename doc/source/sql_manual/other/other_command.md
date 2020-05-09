# Other SQL Commands

Hologres is compatible with PostgreSQL.  In addition to table creation, schema change, DML, and query, Hologres supports other SQL commands.  The following table lists other supported SQL commands.  You can find usage description and examples from [PostgreSQL official documentation](https://www.postgresql.org/docs/11/index.html): 

| Command                     | Supported? | Note                                                         |
| --------------------------- | ---------- | ------------------------------------------------------------ |
| ALTER ROLE                  | YES        | None                                                         |
| ANALYZE                     | YES        | None                                                         |
| BEGIN                       | YES        | Only valid for DDL                                           |
| COMMIT                      | YES        | Only valid for DDL                                           |
| CREATE DATABASE             | YES        | None                                                         |
| CREATE EXTENSION            | YES        | None                                                         |
| CREATE FOREIGN DATA WRAPPER | YES        | None                                                         |
| CREATE FOREIGN TABLE        | YES        | Only support MaxCompute                                      |
| CREATE GROUP                | YES        | None                                                         |
| CREATE SERVER               | YES        | None                                                         |
| CREATE TABLE                | YES        | Only support partial PostgreSQL functionality（For example，the only supported partition type is list，and partition list only can have one value with string data type）。 The following is unsupported:UNLOGGEDTEMPIF NOT EXISTSLIKECHECKDEFAULTGENERATEDUNIQUEEXCLUDEFOREIGN KEYDEFERRABLEWITH OIDSGLOBAL/LOCAL |
| CREATE VIEW                 | YES        | None                                                         |
| CREATE USER                 | YES        | None                                                         |
| CREATE USER MAPPING         | YES        | None                                                         |
| DROP DATABASE               | YES        | None                                                         |
| DROP FOREIGN DATA WRAPPER   | YES        | None                                                         |
| DROP FOREIGN TABLE          | YES        | None                                                         |
| DROP GROUP                  | YES        | None                                                         |
| DROP OWNED                  | YES        | None                                                         |
| DROP POLICY                 | YES        | None                                                         |
| DROP ROLE                   | YES        | None                                                         |
| DROP SERVER                 | YES        | None                                                         |
| DROP TABLE                  | YES        | None                                                         |
| DROP USER                   | YES        | None                                                         |
| DROP USER MAPPING           | YES        | None                                                         |
| END                         | YES        | Only can be used with DDL statements                         |
| EXPLAIN                     | YES        | None                                                         |
| INSERT                      | YES        | None                                                         |
| ROLLBACK                    | YES        | None                                                         |
| SELECT                      | YES        | Partial functionality support. The following is unsupported:CUBE/GROUPING SET/ROLL UPRECURSIVENULL FIRST/LASTINTERSECT/EXCEPTTABLESAMPLELockingONLY |
| SET                         | YES        | Set some Postgres parameter might have no effects            |
| SET ROLE                    | YES        | None                                                         |
| START TRANSACTION           | YES        | None                                                         |