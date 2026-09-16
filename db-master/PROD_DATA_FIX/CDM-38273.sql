/*
  Issue Description:  CDM-38273
   Category/ Module  :  Services:Service log 
   Root cause: User Unable to end date payment for Provider ID# 5089493 Service type: One-on-One (Paid) for Dec 2023.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

Update tb_service_log 
set end_dt='2023-12-31', update_ts= now(), update_user_id='CDM-38273'
where service_log_id =2991211;