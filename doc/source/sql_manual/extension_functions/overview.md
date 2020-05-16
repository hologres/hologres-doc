# Public API Functins Overview

Standard PostgreSQL functions cannot meet all business requirements, so Hologres added some new functions as public API which can be used to simplify development process. Next chapter will describe public API functions in detail. Below table lists all those public API functions:

| Function                         | Description              |
| -------------------------------- | ------------------------ |
| APPROX_COUNT_DISTINCT            | Aggregation function     |
| GET_JSON_OBJECT                  | Hive compatible function |
| HG_CREATE_TABLE_LIKE             | Helper function          |
| HG_UPDATE_DATABASE_PROPERTY      | Helper function          |
| SET_TABLE_PROPERTY               | Helper function          |
| HG_SHARD_ID_FOR_DISTRIBUTION_KEY | Helper function          |