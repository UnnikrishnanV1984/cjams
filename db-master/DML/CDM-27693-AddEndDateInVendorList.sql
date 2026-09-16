/*
   Issue Description: CDM-27693
   Category/ Module  :  Adding Enddate in Vendor List
   Root cause: Adding Enddate in Vendor List
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 update tb_service_log set end_dt = '2022-10-28', update_ts = now()::character varying, update_user_id = 'CDM-27693' where service_log_id = '1960949';
