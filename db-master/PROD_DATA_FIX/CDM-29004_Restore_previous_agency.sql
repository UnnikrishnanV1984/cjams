/*
   Issue Description: CDM-29004
   Category/ Module  : Restore previous Agency provided service
   Root cause:I erroneously deleted an agency provider service from 2007. Is there anyway to restore this information?
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update tb_service_log set delete_sw ='N' , update_ts=now(), update_user_id ='CDM-29004' where service_log_id = 48169;


