/*
   Issue Description: CDM-35037
   Category/ Module  :Services
   Root cause : to change service log enddate
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update tb_service_log set end_dt ='2023-10-05',update_ts =now(),update_user_id ='CDM-35037' where service_log_id in (2196878 ,2061877 ,2061867,2061218,2196878,2061147);