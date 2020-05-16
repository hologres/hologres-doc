# HG_UPDATE_DATABASE_PROPERTY

## Introduction

HG_UPDATE_DATABASE_PROPERTY：Update DB properties。So far, only default shard_count of Table Group is supported.

_**Note**_：hg_update_database_property need super user or DB owner privileges.	

## Synopsis

```sql
CALL HG_UPDATE_DATABASE_PROPERTY ( property, value );
```

## Parameters

_**Property**_ : Property name.

_**value**_ : The property value.

## Limitation

Only default shard_count of Table Group is supported.

## Example

Change default shard count of Table Group to 120.
```sql
CALL HG_UPDATE_DATABASE_PROPERTY ( 'shard_count', '120' );
```

