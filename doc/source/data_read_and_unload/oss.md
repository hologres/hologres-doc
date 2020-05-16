# Dump Query Results to OSS

Object Storage Service (OSS) is massive, safe, low-cost, and reliable cloud storage service. Hologres supports dumping query results to OSS via interactive commands.

## Introduction

Dump to OSS - dump Hologres query result to specific OSS.

## Synopsis

dump to OSS command follows  the following format:

```sql
COPY (query) TO PROGRAM 'hg_dump_to_oss --AccessKeyId <accessid> --AccessKeySecret <accesskey> --Endpoint <ossendpoint> --BucketName <bucketname> --<DirName> <dirname> --BatchSize <xxx> ' DELIMITER <'xxx'>;
```

## Parameters

| Parameters            | Descriptions                                         | Example                              |
| :-------------------- | ---------------------------------------------------- | ------------------------------------ |
| _**query**_           | input query                                          | select * from dual;                  |
| _**AccessKeyId**_     | account username                                     |                                      |
| _**AccessKeySecret**_ | account password                                     |                                      |
| _**Endpoint**_        | oss address                                          | oss-cn-beijing-internal.aliyuncs.com |
| _**BucketName**_      | OSS bucket name                                      | dummy_bucket                         |
| _**DirName**_         | output directory                                     | testdemo/                            |
| _**BatchSize**_       | optional. number of rows in a batch. Default is 1000 | 5000                                 |
| _**DELIMITER**_       | optional. Delimiter between columns. Default is TSV  | ','                                  |

## Limitation

Only Hologres superuser or users having pg_execute_server_program privilege can execute dump to OSS command. A superuser may grant pg_execute_server_program privilege to other users, as follows:

```sql
--Grant pg_execute_server_program
grant pg_execute_server_program to dummy_user;
```

## Examples

The following are some examples of the usage of dump to OSS:

```sql
// Dump Hologres table content to specific OSS
COPY (select * from test LIMIT 2) TO PROGRAM 'hg_dump_to_oss --AccessKeyId <access id> --AccessKeySecret <access key> --Endpoint oss-cn-hangzhou-internal.aliyuncs.com --BucketName <holo-ingestion> --DirName <holotest>/ --BatchSize 3000' DELIMITER ',';

// Dump data to OSS across regions
COPY (select * from bank_data LIMIT 20) TO PROGRAM 'hg_dump_to_oss --AccessKeyId <access id> --AccessKeySecret <access key> --Endpoint oss-cn-beijing-internal.aliyuncs.com --BucketName hologres-demo-oss --DirName demotest/ --BatchSize 3000' DELIMITER ',';
```

## Common errors and solutions

- ERROR:  syntax error at or near ")" LINE 1: COPY (select 1,2,3 from ) TO PROGRAM 'hg_dump_to_oss2 --Acce...

  Query syntax problem. Check input query.

- DETAIL:  child process exited with exit code 255

     wrong OSS network type.

- DETAIL:  command not found

  ```sql
  dump to OSS currently has to set program to be hg_dump_to_oss. Others, such an error occurs.
  ```

- ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 101

  Input AccessKeyId is invalid. Check OSS account.

- ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 102

  input AccessKeySecret is invalid. Check OSS account.

- ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 103

  Input Endpoint is invalid. Verify corresponding OSS host.

- ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 104

  Input BucketName is invalid. Verify bucket name.

- ERROR:  program "hg_dump_to_oss ..." failed，DETAIL:  child process exited with exit code 105

      Missing required parameters. Refer to "Parameter Descriptions" section.

- Data to dump cannot pass 5G in size

- ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 255

  Usually the connection between Holo Server and the specified OSS cannot be established. Try switch OSS domain name (as in classic network).
