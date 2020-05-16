# Data Types

Hologres is compatible with PostgresSQL in data types. Currently Hologres supports a subset of data types defined in PostgresSQL. 

## Data Types

The following table lists all supported types:

| Name                     | Alias       | Supported | Length in bytes | Value range                                                  | Description                                                  |
| :----------------------- | :---------- | :-------- | :-------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| integer                  | int, int4   | Yes       | 4               | -2147483648 to +2147483647                                   | signed four bytes integer                                    |
| bigint                   | int8        | Yes       | 8               | -9223372036854775808 to +9223372036854775807                 | signed eight bytes integer                                   |
| boolean                  | bool        | Yes       | 1               | True / False                                                 | logical boolean                                              |
| real                     | float4      | Yes       | 4               | 6 decimal digits precision                                   | single precision floating-point number                       |
| double precision         | float8      | Yes       | 8               | 15 decimal digits precision                                  | double precision floating-point number                       |
| text                     | varchar     | Yes       | variable        | -                                                            | variable length character string                             |
| timestamp with time zone | timestamptz | Yes       | 8               | 4713 BC to 294276 AD                                         | date and time, including timezone, e.g '2004-10-19 10:23:54+02' |
| decimal                  | numeric     | Yes       | variable        | up to 38 digits before decimal point; up to 38 digits after the decimal point | exact numeric with selected precision                        |


For timestamp with time zone type, SQL standard using the number after symbol '+' or '-' as time zone shift. If no time zone is provided, a default one is used.

_**Note**_: Defference between Hologres and PostgresSQL for decimal type:

- Hologres supports precision from 0 to38, scale from 0 toprecision
- decimal type muse provide precision and scale, no default value


Below is an example for timestamptz, date and decimal:

```sql
CREATE TABLE test_data_type (
	tswtz_column timestamp WITH TIME ZONE,
	date_column date,
	decimal_column decimal(38, 10)
);

INSERT INTO test_data_type
VALUES ('2004-10-19 08:08:08', '2004-10-19', 123.456);

SELECT * FROM test_data_type;
```

## Array Types

Hologres currently only support one dimensional array types  listed below: 

- int4[]
- int8[]
- float4[]
- float8[]
- boolean[]
- text[]

### Declaration of array types


```sql
create table array_example(
int4_array int4[],
int8_array int8[],
float4_array float4[],
float8_array float8[],
boolean_array boolean[],
text_array text[]);
```

### Array value input

using ARRAY keyword

```sql
insert into array_example(
int4_array,
int8_array,
float4_array,
float8_array,
boolean_array,
text_array)
values (ARRAY[1, 2, 3, 4],
ARRAY[1, 2, 3, 4],
ARRAY[1.0, 2.0],
ARRAY[1.0, 2.0, 3.0],
ARRAY[true, true, false],
ARRAY['foo1', 'foo2', 'foo3']);
```

using {} expression

```sql
insert into array_example(
int4_array,
int8_array,
float4_array,
float8_array,
boolean_array,
text_array)
values ('{1, 2, 3, 4}',
'{1, 2, 3, 4}',
'{1.0, 2.0}',
'{1.0, 2.0, 3.0}',
'{true, true, false}',
'{"foo1", "foo2", "foo3"}');
```

### Accessing Arrays

access single element of an array

```sql
SELECT int4_array[3] FROM array_example;
```

access a slice of an array

```sql
SELECT int4_array[1:2] FROM array_example;
```