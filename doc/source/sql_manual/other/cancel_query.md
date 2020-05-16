# CANCEL QUERY

## Introduction

CANCEL QUERY： Cancel a backend's current query. 
## Synopsis

```sql
SELECT pg_cancel_backend(pid);
```
## Examples

Here is the steps to cancel query in Hologres:

1. Find the _pid_ of the running query that you are about to cancel:

```sql
SELECT pid,query FROM pg_stat_activity WHERE length(query) > 0;
```

2.Cancel the query using the identified _pid_

```sql
SELECT pg_cancel_backend(192910);
```

