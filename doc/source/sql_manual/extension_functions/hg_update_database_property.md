# HG_UPDATE_DATABASE_PROPERTY

# Introduction
HG_UPDATE_DATABASE_PROPERTY：Update DB properties。So far, only default shard_count of Table Group is supported.
> hg_update_database_property need super user or DB owner privileges.

<a name="GfrrN"></a>
# Synopsis
```sql
CALL HG_UPDATE_DATABASE_PROPERTY ( property, value );
```
<a name="LhwbM"></a>
# Parameters
_**property：**_Property name.<br />_**value：**_The property value.
<a name="WpaLT"></a>
# Limitation
Only default shard_count of Table Group is supported.
<a name="1EN6Y"></a>
# Example
Change default shard count of Table Group to 120.
```sql
CALL HG_UPDATE_DATABASE_PROPERTY ( 'shard_count', '120' );
```

