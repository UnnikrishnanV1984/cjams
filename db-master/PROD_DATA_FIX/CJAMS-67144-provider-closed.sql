/*
   Issue Description: CJAMS-67144
   Category/ Module: Provider Service log
   Root cause: User accidentally closed the service log of CJAMS client Keon Champagne - Head of Household Alena Ketchel - the Howard County Taxi Cab provider
   Fix Provided: Data fix has been provided by reopening the service log as requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_service_log 
set end_dt =null, end_service_reason_cd=null, update_user_id ='CJAMS-67144', update_ts =now()
where client_id ='3467878' and service_log_id ='3586025' and end_dt ='2026-03-18';