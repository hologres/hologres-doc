# HG_SHARD_ID_FOR_DISTRIBUTION_KEY

# Introduction
HG_SHARD_ID_FOR_DISTRIBUTION_KEY: Get the shard Id for specified distribution keys.
<a name="GfrrN"></a>
# Synopsis
```sql
SELECT HG_SHARD_ID_FOR_DISTRIBUTION_KEY ( tablename [, column [...] ] )
```
<a name="LhwbM"></a>
# Parameters
_**tablename:**_ The table name to calculate the shard Id.<br />_**column:**_ One or multiple columns on which calculate the shard Id.
<a name="evAzK"></a>
# Example
Calculates the shard Id on columns 'ORDERSKEY' and 'CUSKEY' on table ORDERS
```sql
CALL HG_SHARD_ID_FOR_DISTRIBUTION_KEY ( ORDERS, 'ORDERSKEY', 'CUSKEY' );
```