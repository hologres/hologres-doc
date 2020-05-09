# UNNEST

## Introduction

UNNEST (anyarray): The UNNEST() function takes an array of any type, expands it to a set of rows (return type is  set of anyelement).  

## Synopsis

```sql
CREATE TABLE T(keys text[], price double);
SELECT UNNEST(keys) FROM T WHERE price > 10;
SELECT UNNEST(keys), COUNT(1), SUM(price) FROM T GROUP BY UNNEST(keys);
```
## Examples

```sql
SELECT UNNEST(ARRAY['1', '1']);

CREATE TABLE t(keys text[], value int);

INSERT INTO t VALUES(ARRAY['1', '2'], 10), (ARRAY['1', '3'], 20), (ARRAY['1', '1'], 30);

SELECT UNNEST(keys), COUNT(1), SUM(value) FROM t GROUP BY UNNEST(keys);
```

