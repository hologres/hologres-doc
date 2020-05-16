# ALTER DATABASE

## Introduction

ALTER DATABASE -- change an existing database

## Synopsis

```sql
ALTER DATABASE <dbname> SET configuration_parameter { TO | = } { value | DEFAULT }
ALTER DATABASE <dbname> SET configuration_parameter FROM CURRENT
ALTER DATABASE <dbname> RESET configuration_parameter
ALTER DATABASE <dbname> RESET ALL
```

## Parameters

_**configuration_parameter**_:  The configuration parameter of hologres.

_**value**_: The value of the specified configuration parameter.

_**DEFAULT**_: The default value of the specified configuration parameter which is the system-wide default setting.

_**RESET**_: It is equivalent to set configuration parameter to DEFAULT which is the system-wide default setting.

_**RESET ALL**_: Reset all configuration parameters to DEFAULT.

_**SET FROM CURRENT**_ : Save the session's current value of the parameter as the database-specific value.

## Example

set time zone to GMT+8 (Beijing standard time) which is 8 hours earlier than GMT.

```sql
ALTER DATABASE postgres SET timezone='GMT+8:00';
```



