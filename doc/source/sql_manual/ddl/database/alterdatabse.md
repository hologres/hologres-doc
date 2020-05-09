# ALTER DATABASE

# Introduction
ALTER DATABASE -- change an existing database
<a name="hUApP"></a>
# Synopsis
```sql
ALTER DATABASE <dbname> SET configuration_parameter { TO | = } { value | DEFAULT }
ALTER DATABASE <dbname> SET configuration_parameter FROM CURRENT
ALTER DATABASE <dbname> RESET configuration_parameter
ALTER DATABASE <dbname> RESET ALL
```


<a name="niigV"></a>
# Parameters
_**configuration_parameter:**_ The configuration parameter of hologres.<br />_**value：**_The value of the specified configuration parameter.<br />_**DEFAULT：**_The default value of the specified configuration parameter which is the system-wide default setting.<br />_**RESET：**_It is equivalent to set configuration parameter to DEFAULT which is the system-wide default setting.<br />_**RESET ALL：**_Reset all configuration parameters to DEFAULT.<br />SET FROM CURRENT：Save the session's current value of the parameter as the database-specific value.
<a name="gNGta"></a>
# Example
set time zone to GMT+8 (Beijing standard time) which is 8 hours earlier than GMT.
```sql
ALTER DATABASE postgres SET timezone='GMT+8:00';
```

<br />

