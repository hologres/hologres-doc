# Roles Overview

Hologres is compatible with PostgreSQL 11, and the permission system is the same as PostgreSQL.

1.**Superuser**:the Hologres instance owner，who has all the authority ，for example, create 、drop database and create user ,etc.

2.**Normal user**:can connect Hologres after Authorized by instance superuser，and can do developing within the scope of authority .normal user can also be superuser.

3.**User group**: composited by 0 or more users , used to represent user roles, such as administrator role, developer role, etc., users in a user group have the same permissions.

more information ，please see [PostgreSQL role](https://www.postgresql.org/docs/11/user-manag.html).