# Use Simple Permission Model

## Overview

In Hologres, user could use Simple Permission Model to manage user role and privileges, besides the traditional Postgre SQL user role model. 

## Examples

### 1.Enable SPM extension

Use CREATE EXTENSION to enable SPM extension.

```sql
create extension spm;
```

### 2. Enable SPM

By default, SPM is disabled. The super could execute following statement to enable it in the specific database.
```sql
call spm_enable ();  // Enable SPM in the current database.
```

Note: After SPM is enabled, the developer user group owns all the entities of all the schema in the current database, regardless when or by whom the entity was created.

### 3. Create User

The user should be created before granting the privilege.
```sql
 // Create user. Double quota is required when use email.
call spm_create_user ('account');

 // Add user into a group while creating the user.
call spm_create_user ('account', '<dbname>_[admin|developer|writer|viewer]');
```

### 4. Add User To User Group

The privilege is granted by adding the user into the specific user group.
```sql
// Add a user to an user group.
call spm_grant ('<dbname>_[admin|developer|writer|viewer]', 'account');

// Example
// Add the user to the admin group of a specific database
// Add 197006222995xxx to the admin group of database mydb
call spm_grant ('mydb_admin', '197006222995xxx', ); 

// Add 197006222995xxx to the developer group of database mydb
call spm_grant ('mydb_developer', '197006222995xxx');

// Add 197006222995xxx to the viewer group of database mydb
call spm_grant ('"mydb_viewer"', '197006222995xxx');
```
### 5. Remove User From User Group

The privilege is revoked by removing the user from the specific user group.
```sql
// Remove a user from an user group.
call spm_revoke ('<dbname>_[admin|developer|writer|viewer]', 'account');

// Example
// Remove the user from the admin group of a specific database
// Remove 197006222995xxx from the admin group of the database mydb
call spm_revoke ('mydb_admin', '197006222995xxx', ); 

// Remove 197006222995xxx from the developer group of the database mydb
call spm_revoke ('mydb_developer', '197006222995xxx');

// Remove 197006222995xxx from the viewer group of the database mydb
call spm_revoke ('"mydb_viewer"', '197006222995xxx');
```
### 6. Remove user

The user can be removed from the current database. Proceed with cautions.
```sql
// Remove the user from the current database
DROP ROLE "account"
```

## Migrate the Postgre SQL user role model to SPM

If you are using Postgre SQL user role module and would like to migrate to SPM, in order to better and/or simple user permission management on the database entities, the spm_migrate function can be executed to migrate the existing user role to SPM.
```sql
// Migrate all database entities to be owened by developer user group and managed by spm.
call spm_migrate (); 
```

Notes: User need ensure no active SQL statement is running when enabling the SPM, otherwise the enable statement may fail and have side effects on the serviceability.

There would be numerous Alter Owner operation triggered by migration and PostgreSQL has throttling on such operation. Each smp_migrate may only Alter Owner on no more than max_locks_per_transaction number of entities. Therefore, you my need execute spm_migration multiple times, until all the entities are migrated.

## Disable SPM

### 1. Disable SPM

After enable SPM, the super user may disable the spm later on, based on business requirement changes.
```sql
call spm_disable ();
```
After SPM is disabled, the corresponding user groups won't be deleted. The detailed privileges that the users in the user group have, may reference to the description of SPM function.
### 2. Remove User Group

After SPM is disabled, the user group may be removed by call function spm_cleanup.

Notes: Normally, user groups as a convenient way to manage user,  removing are not recommended.

There are two scenarios.

#### Scenario 1, Delete user group while keep the DB

The super user can execute the following state to remove user group while keep the DB serving.
```sql
call spm_cleanup ( '<dbname>' );
```
Notes：Ensure there is no active statement running on the database before execute the spm_cleanup, otherwise the execution may fail and service may be affected.

There would be numerous Alter Owner operation triggered by removing user group, while PostgreSQL has throttling on such operation. Each spm_cleanup may only Alter Owner on no more than max_locks_per_transaction number of entities. Therefore, you my need execute spm_cleanup multiple times, until all the 4 SPM user group are removed.
#### Scenario 2, Delete user group after DB is dropped

Given the circumstances that the original database is delete while the user group is not. The super user could execute spm_cleanup from another database.
```sql
postgres=# call spm_cleanup ( 'mydb' );
```

## Remarks

1. Only super user may disable the SPM
1. The USAGE and CREATE privilege of PUBLIC schema are granted to PUBLIC.
1. The CONECT and TEMPORARY privilege of DB are granted to PUBLIC.
1. The EXECUTE privilege of functions, procedures is granted to PUBLIC.
1. The USAGE privilege of language, data types (include domains) is granted to PUBLIC.
1. The privileges of other entities including table, view, materialized view, table column, sequence, foreign data wrapper, foreign server and schema（except public schema）are not granted to PUBLIC.
1. After SPM is disabled:
- _**admin**_: The granted privileges on the existing entities are kept, but won't be applied to new entities in the database, going forward.

- _**developer**_: The granted privileges on the existing entities are kept, but won't be applied to new entities in the database, going forward.

- _**writer**_: The granted privileges on the existing entities are kept, but won't be applied to new entities in the database, going forward.

- _**viewer**_: The granted privileges on the existing entities are kept, but won't be applied to new entities in the database, going forward.

