/*
   Issue Description: CDM-30474
   Category/ Module  : Services
   Root cause: user requested to change the enddate in service log -Vendor services
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/
update 
      tb_service_log 
set
    end_dt = '2023-03-25', 
    update_user_id = 'CDM-30474',
    update_ts =now() 
where 
service_log_id ='2026943';