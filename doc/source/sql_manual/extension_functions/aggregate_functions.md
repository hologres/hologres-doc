# APPROX_COUNT_DISTINCT

## Introduction

APPROX_COUNT_DISTINCT：count approximate distinct values

## Synopsis

```sql
APPROX_COUNT_DISTINCT ( column )
```
## Parameters

**_column_**: the column needed to be counted against

## Example

```sql
SELECT APPROX_COUNT_DISTINCT ( O_CUSTKEY ) FROM ORDERS;
```