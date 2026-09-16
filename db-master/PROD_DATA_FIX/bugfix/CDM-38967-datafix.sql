/* 
    Issue Description: CDM-38967
  Category/ Module  : Services: Service Log
  Root cause: User request to change the end dates
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update tb_service_log set end_dt ='2024-02-15', update_ts =now(),update_user_id ='CDM-38967' where service_log_id = '3046707';
update tb_service_log set end_dt ='2024-02-12', update_ts =now(),update_user_id ='CDM-38967' where service_log_id = '3046755';
update tb_service_log set end_dt ='2024-01-31', update_ts =now(),update_user_id ='CDM-38967' where service_log_id = '3028591';