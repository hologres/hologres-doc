��            )   �      �     �  0   �     �  $   	     .  9   H  ^   �  `   �  `   B  `   �  `     `   e  k   �     2  0   ;  0   l  9   �     �  
   �  �   �  �   �  
   X  (   c     �  <   �  �   �  2   ^	  4   �	     �	    �	     �
  0        5     P     n  D   �  c   �  c   3  b   �  c   �  c   ^  c   �  s   &     �      �  6   �  6   �     6     C  �   P  �   H     '  +   4     `  1   m  [   �  8   �  $   4     Y                     	   
                                                                                                                 Common errors and solutions DETAIL:  child process exited with exit code 255 DETAIL:  command not found Data to dump cannot pass 5G in size. Dump Euery Results to OSS Dump to OSS - dump Hologres query result to specific OSS. ERROR:  program "hg_dump_to_oss ..." failed，DETAIL:  child process exited with exit code 105 ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 101 ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 102 ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 103 ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 104 ERROR:  program "hg_dump_to_oss ...” failed，DETAIL:  child process exited with exit code 255 ERROR:  syntax error at or near ")" LINE 1: COPY (select 1,2,3 from ) TO PROGRAM 'hg_dump_to_oss2 --Acce... Examples Input AccessKeyId is invalid. Check OSS account. Input BucketName is invalid. Verify bucket name. Input Endpoint is invalid. Verify corresponding OSS host. Introduction Limitation Object Storage Service (OSS) is massive, safe, low-cost, and reliable cloud storage service. Hologres supports dumping query results to OSS via interactive commands. Only Hologres superuser or users having pg_execute_server_program privilege can execute dump to OSS command. A superuser may grant pg_execute_server_program privilege to other users, as follows: Parameters Query syntax problem. Check input query. Synopsis The following are some examples of the usage of dump to OSS: Usually the connection between Holo Server and the specified OSS cannot be established. Try switch OSS domain name (as in classic network). dump to OSS command follows  the following format: input AccessKeySecret is invalid. Check OSS account. wrong OSS network type Project-Id-Version: Hologres
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2020-05-15 14:43+0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
Last-Translator: 
Language-Team: 
X-Generator: Poedit 2.3.1
Language: zh
 常见问题 报错:  child process exited with exit code 255 报错:  command not found 单次上传不能超过5G。 使用SQL命令导出至OSS dump to oss：把在Hologres中查询的结果dump到指定的oss。 报错:  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 105 报错:  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 101 报错  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 102 报错:  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 103 报错:  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 104 报错:  program “hg_dump_to_oss …” failed，DETAIL:  child process exited with exit code 255 报错:  syntax error at or near “)” LINE 1: COPY (select 1,2,3 from ) TO PROGRAM ‘hg_dump_to_oss2 —Acce。 使用示例 输入的AccessKeyId不合法。 输入的BucketName不合法，请确认bucket name。 输入的BucketName不合法，请确认bucket name。 命令介绍 使用限制 对象存储服务（Object Storage Service，简称 OSS），是一款提供的海量、安全、低成本、高可靠的云存储服务。交互式分析（Hologres）支持通过以命令语句的方式将查询的数据导出到指定的OSS。 只有是当前Hologres实例的superuser或者具备pg_execute_server_program权限的用户，才能使用dump to oss功能。superuser可以为其他账号授权，使其成为pg_execute_server_program，授权如下： 参数说明 输入的query有问题，请检查query。 命令格式 在Hologres中dump to oss的使用示例如下： 一般是holo server和指定的oss网络不通，可以更换oss域名(比如经典网络) 在交互式分析中dump to oss的命令格式如下： 输入的AccessKeySecret不合法。 oss的网络类型选择错误 