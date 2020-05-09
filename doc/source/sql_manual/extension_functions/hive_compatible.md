# GET_JSON_OBJECT

## Introduction

GET_JSON_OBJECT：Extracts an JSON object from a JSON string. 

GET_JSON_OBJECT is provided by hive_compatible extension. To use it, it required to create the hive_compatible extension.

## Synopsis

```sql
create extension hive_compatible;
select get_json_object ( json_string, path )
```

## Parameters

_**json_string**_：An valid JSON text.

_**path**_：A JSON path that specified the object to extract. The dollar sign($) represents a JSON variable. The dot operator(.) and the square brackets are used to access a member or an array element. NULL is returned if the json_string is invalid.

## Example

```sql
create extension hive_compatible;
data =
{"store":{
	 "fruit":[{"weight":8,"type":"apple"}, {"weight":9,"type":"pear"}],
   "bicycle":{"price":19.95,"color":"red"}},
 "email":"amy@only_for_json_udf_test.net",
 "owner":"amy"
}

select get_json_object(data, '$.owner') from test;
Result: amy

select get_json_object(data, '$.name.bicycle.price') from test;
Result: 19.95

select get_json_object(data, '$.store.fruit[0]') from test;
Result: {"weight":8, "type":"apple"}
```

