# APPROX_COUNT_DISTINCT

# Introduction
APPROX_COUNT_DISTINCT：count approximate distinct values
<a name="GfrrN"></a>
# Synopsis
```sql
CREATE DATABASE db_name
    [ [ WITH ] [ OWNER [=] user_name ]
;
```
```sql
APPROX_COUNT_DISTINCT ( column )
```
<a name="elsgh"></a>
# Parameters
**_column：_**the column needed to be counted against
<a name="BOZnZ"></a>
# Example
```sql
SELECT APPROX_COUNT_DISTINCT ( O_CUSTKEY ) FROM ORDERS;
```