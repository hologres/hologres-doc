# Postgres Permission Model

Hologres is compatible with Postgres and uses the same permission system of Postgres .

## GRANT

The standard PostgreSQL authorization steps are as follows

### Step 1: Create User

```sql
CREATE USER "username"; 
CREATE USER "username" superuser; //to be a superuser
```

more information，see [PostgreSQL create role](https://www.postgresql.org/docs/11/sql-createrole.html).

### Step2: Grant user

After the user is created in the role of Hologres, the user needs to be granted certain permissions ,and then the user can use Hologres within the scope of permissions. 

Common GRANT are as follows:

| Authority | Example |
| --- | --- |
| create user within login | CREATE USER "username"; |
| create superuser  | CREATE USER  "username" SUPERUSER ; |
| Give all users the view, write, and update permissions in the public schema to all users | GRANT SELECT,INSERT,UPDATE ON ALL TABLES IN SCHEMA public to PUBLIC; |
| Grant a user SELECT permission on Table1 | GRANT SELECT ON TABLE Table1 TO "username"; |
| Grant a user SELECT permission on Table1 and allow the user to grant this permission to others | GRANT SELECT ON TABLE Table1 TO "username" WITH GRANT OPTION; |
| Grant SELECT permissions on all tables under public schema to a user | GRANT SELECT ON ALL TABLES IN SCHEMA public TO "username";   |
| By default, all tables in the public schema can be read by everyone (including future tables) | ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO PUBLIC; |

More information about GRANT，please see [PostgeSQL GRANT](https://www.postgresql.org/docs/11/sql-grant.html).

## REVOKE

Use REVOKE to revoke permissions:

```sql
REVOKE SELECT ON TABLE tablename from "username" ;
```

More information about REVOKE，please see [PostgreSQL REVOKE](https://www.postgresql.org/docs/11/sql-revoke.html).


## DROP user

To drop a user, use the following command:

```sql
DROP user "username";
```

Once the user is drooped, he will not be able to connect to the Hologres instance and access any objects in the instance.<br />