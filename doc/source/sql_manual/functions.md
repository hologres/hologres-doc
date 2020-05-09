# Function

Hologres use PostgreSQL 11 semantics but only support a subset of all the functions supported by PostgreSQL. Below tables list  all functions Hologres supported currently. For detailed information please refer to [PostgreSQL](https://www.postgresql.org/docs/11/functions.html) document.
## Mathematcial Functions

| Function                                       | Supported | Added by Hologres |
| ---------------------------------------------- | --------- | ----------------- |
| abs(bigint)                                    | Yes       | No                |
| abs(int)                                       | Yes       | No                |
| abs(float8)                                    | Yes       | No                |
| abs(float4)                                    | Yes       | No                |
| abs(numeric)                                   | Yes       | No                |
| cbrt(dp)                                       | Yes       | No                |
| ceil(dp )                                      | Yes       | No                |
| ceil(numeric)                                  | Yes       | No                |
| ceiling(dp )                                   | Yes       | No                |
| ceiling(numeric)                               | Yes       | No                |
| degrees(dp)                                    | Yes       | No                |
| exp(dp)                                        | Yes       | No                |
| exp(numeric)                                   | Yes       | No                |
| floor(dp )                                     | Yes       | No                |
| floor(numeric)                                 | Yes       | No                |
| ln(dp)                                         | Yes       | No                |
| ln(numeric)                                    | Yes       | No                |
| log(dp)                                        | Yes       | No                |
| log(numeric)                                   | Yes       | No                |
| log(b numeric, x numeric)                      | Yes       | No                |
| mod(bigint, x)                                 | Yes       | No                |
| mod(int, x)                                    | Yes       | No                |
| pi()                                           | Yes       | No                |
| power(a dp, b dp)                              | Yes       | No                |
| power(a numeric, b numeric)                    | Yes       | No                |
| radians(dp)                                    | Yes       | No                |
| round(dp )                                     | Yes       | No                |
| round(numeric)                                 | Yes       | No                |
| round(v numeric, s int)                        | Yes       | No                |
| sign(dp )                                      | Yes       | No                |
| sign(numeric)                                  | Yes       | No                |
| sqrt(dp)                                       | Yes       | No                |
| sqrt(numeric)                                  | Yes       | No                |
| trunc(dp)                                      | Yes       | No                |
| trunc(numeric)                                 | Yes       | No                |
| trunc(v numeric, s int)                        | Yes       | No                |
| width_bucket(operand numeric, b1 numeric, ...) | Yes       | No                |
| random()                                       | Yes       | No                |

## Trigonometric Functions

| Function       | Supported | Added by Hologress |
| -------------- | --------- | ------------------ |
| acos(bigint)   | Yes       | No                 |
| acos(int)      | Yes       | No                 |
| acos(float8)   | Yes       | No                 |
| acos(float4)   | Yes       | No                 |
| acos(numeric)  | Yes       | No                 |
| asin(bigint)   | Yes       | No                 |
| asin(int)      | Yes       | No                 |
| asin(float8)   | Yes       | No                 |
| asin(float4)   | Yes       | No                 |
| asin(numeric)  | Yes       | No                 |
| atan(bigint)   | Yes       | No                 |
| atan(int)      | Yes       | No                 |
| atan(float8)   | Yes       | No                 |
| atan(float4)   | Yes       | No                 |
| atan(numeric)  | Yes       | No                 |
| atan2(bigint)  | Yes       | No                 |
| atan2(int)     | Yes       | No                 |
| atan2(float8)  | Yes       | No                 |
| atan2(float4)  | Yes       | No                 |
| atan2(numeric) | Yes       | No                 |
| cos(bigint)    | Yes       | No                 |
| cos(int)       | Yes       | No                 |
| cos(float8)    | Yes       | No                 |
| cos(float4)    | Yes       | No                 |
| cos(numeric)   | Yes       | No                 |
| cot(bigint)    | Yes       | No                 |
| cot(int)       | Yes       | No                 |
| cot(float8)    | Yes       | No                 |
| cot(float4)    | Yes       | No                 |
| cot(numeric)   | Yes       | No                 |
| sin(bigint)    | Yes       | No                 |
| sin(int)       | Yes       | No                 |
| sin(float8)    | Yes       | No                 |
| sin(float4)    | Yes       | No                 |
| sin(numeric)   | Yes       | No                 |
| tan(bigint)    | Yes       | No                 |
| tan(int)       | Yes       | No                 |
| tan(float8)    | Yes       | No                 |
| tan(float4)    | Yes       | No                 |
| tan(numeric)   | Yes       | No                 |

## String Functions and Operators

| Function                                  | Supported | Added by Hologress              |
| ----------------------------------------- | --------- | ------------------------------- |
| string                                    |           | string                          |
| bit_length(string)                        | Yes       | No                              |
| char_length(string)                       | Yes       | No                              |
| lower(string)                             | Yes       | No                              |
| octet_length(string)                      | Yes       | No                              |
| position(substring in string)             | Yes       | No                              |
| substring(string [from int] [for int])    | Yes       | No                              |
| substring(string from pattern)            | Yes       | No                              |
| substring(string from pattern for escape) | Yes       | No                              |
| trim([leading                             | trailing  | both] [characters] from string) |
| trim([lea                                 | tra       | both] [from] string [, char] )  |
| upper(string)                             | Yes       | No                              |

## Other Postgres String Functions

| Function                                          | Supported | Added by Hologress |
| ------------------------------------------------- | --------- | ------------------ |
| ascii(string)                                     | Yes       | No                 |
| btrim(string text [, characters text])            | Yes       | No                 |
| chr(int)                                          | Yes       | No                 |
| concat(str "any" [, str "any" [, ...] ])          | Yes       | No                 |
| initcap(string)                                   | Yes       | No                 |
| length(string)                                    | Yes       | No                 |
| lpad(string text, length int [, fill text])       | Yes       | No                 |
| ltrim(string text [, characters text])            | Yes       | No                 |
| md5(string)                                       | Yes       | No                 |
| parse_ident(quali_iden text [,...] )              | Yes       | No                 |
| quote_ident(string text)                          | Yes       | No                 |
| quote_literal(string text)                        | Yes       | No                 |
| regexp_matches(string text, pattern text )        | Yes       | No                 |
| regexp_replace(str text, pat text, replace text ) | Yes       | No                 |
| regexp_split_to_array(string text, pattern text ) | Yes       | No                 |
| regexp_split_to_table(string text, pattern text ) | Yes       | No                 |
| repeat(string text, number int)                   | Yes       | No                 |
| replace(string text, from text, to text)          | Yes       | No                 |
| rpad(string text, length int [, fill text])       | Yes       | No                 |
| rtrim(string text [, characters text])            | Yes       | No                 |
| strpos(string, substring)                         | Yes       | No                 |
| substr(string, from [, count])                    | Yes       | No                 |
| starts_with(string, prefix)                       | Yes       | No                 |
| to_hex(number int or bigint)                      | Yes       | No                 |
| translate(string text, from text, to text)        | Yes       | No                 |

## Pattern Matching

| Function              | Supported | Added by Hologress |
| --------------------- | --------- | ------------------ |
| like                  | Yes       | No                 |
| not like              | Yes       | No                 |
| similar to            | Yes       | No                 |
| not similar to        | Yes       | No                 |
| rlike ~               | Yes       | No                 |
| rlike !~*             | Yes       | No                 |
| rlike ~*              | Yes       | No                 |
| rlike !~              | Yes       | No                 |
| substring()           | Yes       | No                 |
| regexp_replace()      | Yes       | No                 |
| regexp_split_to_table | Yes       | No                 |
| regexp_split_to_array | Yes       | No                 |

## Date/Time Formating Functions

| Function                                | Supported | Added by Hologress |
| --------------------------------------- | --------- | ------------------ |
| to_char(timestamp, text)                | Yes       | No                 |
| to_char(int, text)                      | Yes       | No                 |
| to_char(double precision, text)         | Yes       | No                 |
| to_date(text, text)                     | Yes       | No                 |
| to_number(text, text)                   | Yes       | No                 |
| to_timestamp(text, text)                | Yes       | No                 |
| date - date                             | Yes       | No                 |
| clock_timestamp()                       | Yes       | No                 |
| current_date                            | Yes       | No                 |
| current_timestamp                       | Yes       | No                 |
| date_part(text, timestamp)              | Yes       | No                 |
| date_trunc(text, timestamp)             | Yes       | No                 |
| extract(field from timestamp)           | Yes       | No                 |
| isfinite(date)                          | Yes       | No                 |
| isfinite(timestamp)                     | Yes       | No                 |
| isfinite(interval)                      | Yes       | No                 |
| make_date(year int, month int, day int) | Yes       | No                 |
| localtimestamp                          | Yes       | No                 |
| now()                                   | Yes       | No                 |
| statement_timestamp()                   | Yes       | No                 |
| timeofday()                             | Yes       | No                 |
| transaction_timestamp()                 | Yes       | No                 |
| to_timestamp(double precision)          | Yes       | No                 |

## Conditional Expressions

| Function | Supported | Added by Hologress |
| -------- | --------- | ------------------ |
| case     | Yes       | No                 |
| coalesce | Yes       | No                 |
| nullif   | Yes       | No                 |
| greatest | Yes       | No                 |
| least    | Yes       | No                 |

## Array Functions

| Function                            | Supported | Added by Hologress |
| ----------------------------------- | --------- | ------------------ |
| array_append(anyarray, anyelement)  | Yes       | No                 |
| array_dims(anyarray)                | Yes       | No                 |
| array_lower(anyarray, int)          | Yes       | No                 |
| array_prepend(anyelement, anyarray) | Yes       | No                 |
| array_upper(anyarray, int)          | Yes       | No                 |
| unnest(anyarray)                    | Yes       | No                 |

## General-Purpose Aggregate Functions

| Function                          | Supported | Added by Hologress |
| --------------------------------- | --------- | ------------------ |
| array_agg(bigint)                 | Yes       | No                 |
| array_agg(bool)                   | Yes       | No                 |
| array_agg(text)                   | Yes       | No                 |
| array_agg(float8)                 | Yes       | No                 |
| array_agg(float4)                 | Yes       | No                 |
| array_agg(int)                    | Yes       | No                 |
| avg(bigint)                       | Yes       | No                 |
| avg(float8)                       | Yes       | No                 |
| avg(float4)                       | Yes       | No                 |
| avg(int)                          | Yes       | No                 |
| bit_and(bigint)                   | Yes       | No                 |
| bit_and(int)                      | Yes       | No                 |
| bit_or(bigint)                    | Yes       | No                 |
| bit_or(int)                       | Yes       | No                 |
| bool_and(bool)                    | Yes       | No                 |
| bool_or(bool)                     | Yes       | No                 |
| cout(*)                           | Yes       | No                 |
| cout(bigint)                      | Yes       | No                 |
| cout(numeric)                     | Yes       | No                 |
| every(bool)                       | Yes       | No                 |
| max(bigint)                       | Yes       | No                 |
| max(float8)                       | Yes       | No                 |
| max(float4)                       | Yes       | No                 |
| max(int)                          | Yes       | No                 |
| max(numeric)                      | Yes       | No                 |
| min(bigint)                       | Yes       | No                 |
| min(float8)                       | Yes       | No                 |
| min(float4)                       | Yes       | No                 |
| min(int)                          | Yes       | No                 |
| min(numeric)                      | Yes       | No                 |
| sum(bigint)                       | Yes       | No                 |
| sum(float8)                       | Yes       | No                 |
| sum(float4)                       | Yes       | No                 |
| sum(int)                          | Yes       | No                 |
| sum(numeric)                      | Yes       | No                 |
| string_agg(expression, delimiter) | Yes       | No                 |
| corr(Y, X)                        | Yes       | No                 |
| covar_pop(Y, X)                   | Yes       | No                 |
| covar_samp(Y, X)                  | Yes       | No                 |
| regr_avgx(Y, X)                   | Yes       | No                 |
| regr_avgy(Y, X)                   | Yes       | No                 |
| regr_count(Y, X)                  | Yes       | No                 |
| regr_intercept(Y, X)              | Yes       | No                 |
| regr_r2(Y, X)                     | Yes       | No                 |
| regr_slope(Y, X)                  | Yes       | No                 |
| regr_sxx(Y, X)                    | Yes       | No                 |
| regr_sxy(Y, X)                    | Yes       | No                 |
| regr_syy(Y, X)                    | Yes       | No                 |
| stddev(int)                       | Yes       | No                 |
| stddev(numeric)                   | Yes       | No                 |
| stddev(float8)                    | Yes       | No                 |
| stddev_pop(int)                   | Yes       | No                 |
| stddev_pop(numeric)               | Yes       | No                 |
| stddev_pop(float8)                | Yes       | No                 |
| stddev_samp(int)                  | Yes       | No                 |
| stddev_samp(numeric)              | Yes       | No                 |
| stddev_samp(float8)               | Yes       | No                 |
| variance(int)                     | Yes       | No                 |
| variance(numeric)                 | Yes       | No                 |
| var_pop(float8)                   | Yes       | No                 |
| var_pop(int)                      | Yes       | No                 |
| var_pop(numeric)                  | Yes       | No                 |
| var_samp(float8)                  | Yes       | No                 |
| var_samp(int)                     | Yes       | No                 |
| var_samp(numeric)                 | Yes       | No                 |

## Ordered-Set Aggregate Functions

| Function          | Supported | Added by Hologress |
| ----------------- | --------- | ------------------ |
| GROUPING(args...) | Yes       | Yes                |
|                   |           |                    |

## Window Functions

| Function       | Supported | Added by Hologress |
| -------------- | --------- | ------------------ |
| row_number()   | Yes       | No                 |
| rank()         | Yes       | No                 |
| dense_rank()   | Yes       | No                 |
| percent_rank() | Yes       | No                 |
| lag()          | Yes       | No                 |
| lead()         | Yes       | No                 |
| first_value()  | Yes       | No                 |
| last_value()   | Yes       | No                 |

## Subquery Expressions

| Function          | Supported | Added by Hologress |
| ----------------- | --------- | ------------------ |
| EXISTS (subquery) | Yes       | No                 |
| IN (subquery)     | Yes       | No                 |
| NOT IN (subquery) | Yes       | No                 |
| ANY (subquery)    | Yes       | No                 |
| SOME (subquery)   | Yes       | No                 |

## Row and Array Comparisons

| Function            | Supported | Added by Hologress |
| ------------------- | --------- | ------------------ |
| NOT IN (values,...) | Yes       | No                 |
| IN (values,...)     | Yes       | No                 |

## Set Returning functions

| Function                                     | Supported | Added by Hologress |
| -------------------------------------------- | --------- | ------------------ |
| generate_series(start, stop)                 | Yes       | No                 |
| generate_series(start, stop, step)           | Yes       | No                 |
| generate_series(start, stop, step interval)  | Yes       | No                 |
| generate_subscripts(array anyarray, dim int) | Yes       | No                 |

## Session Information Functions

| Function                      | Supported | Added by Hologress |
| ----------------------------- | --------- | ------------------ |
| current_catalog               | Yes       | No                 |
| current_database()            | Yes       | No                 |
| current_query()               | Yes       | No                 |
| current_role                  | Yes       | No                 |
| current_schema[()]            | Yes       | No                 |
| current_schemas(boolean)      | Yes       | No                 |
| current_user                  | Yes       | No                 |
| inet_client_addr()            | Yes       | No                 |
| inet_client_port()            | Yes       | No                 |
| inet_server_addr()            | Yes       | No                 |
| inet_server_port()            | Yes       | No                 |
| pg_backend_pid()              | Yes       | No                 |
| pg_blocking_pids(int)         | Yes       | No                 |
| session_user                  | Yes       | No                 |
| user                          | Yes       | No                 |
| version()                     | Yes       | No                 |
| current_setting(setting_name) | Yes       | No                 |

## Access Privilege Inquiry Functions

| Function                                                 | Supported | Added by Hologress |
| -------------------------------------------------------- | --------- | ------------------ |
| has_any_column_privilege(user, table, privilege)         | Yes       | No                 |
| has_any_column_privilege(table, privilege)               | Yes       | No                 |
| has_column_privilege(user, table, column, privilege)     | Yes       | No                 |
| has_column_privilege(table, column, privilege)           | Yes       | No                 |
| has_database_privilege(user, database, privilege)        | Yes       | No                 |
| has_database_privilege(database, privilege)              | Yes       | No                 |
| has_foreign_data_wrapper_privilege(user, fdw, privilege) | Yes       | No                 |
| has_foreign_data_wrapper_privilege(fdw, privilege)       | Yes       | No                 |
| has_function_privilege(user, function, privilege)        | Yes       | No                 |
| has_function_privilege(function, privilege)              | Yes       | No                 |
| has_language_privilege(user, language, privilege)        | Yes       | No                 |
| has_language_privilege(language, privilege)              | Yes       | No                 |
| has_schema_privilege(user, schema, privilege)            | Yes       | No                 |
| has_schema_privilege(schema, privilege)                  | Yes       | No                 |
| has_server_privilege(user, server, privilege)            | Yes       | No                 |
| has_server_privilege(server, privilege)                  | Yes       | No                 |
| has_table_privilege(user, table, privilege)              | Yes       | No                 |
| has_table_privilege(table, privilege)                    | Yes       | No                 |
| has_tablespace_privilege(user, tablespace, privilege)    | Yes       | No                 |
| has_tablespace_privilege(tablespace, privilege)          | Yes       | No                 |
| has_type_privilege(user, type, privilege)                | Yes       | No                 |
| has_type_privilege(type, privilege)                      | Yes       | No                 |
| pg_has_role(user, role, privilege)                       | Yes       | No                 |
| pg_has_role(role, privilege)                             | Yes       | No                 |

## Public API Functions

Standard PostgreSQL functions cannot meet all business requirements, so Hologres added some new functions as public API which can be used to simplify development process. Next chapter will describe public API functions in detail.

