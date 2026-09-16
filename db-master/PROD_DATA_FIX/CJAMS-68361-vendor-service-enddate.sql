/*
   Issue Description: CJAMS-68361
   Category/ Module: Adding Enddate in Vendor List
   Root cause:  User requested to add Enddate in Vendor List
   Fix provided: Data fix has been provided to enda date a vendor list 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_service_log
set end_dt ='2023-12-31', end_service_reason_cd = '1824', update_user_id ='CJAMS-68361', update_ts =now()
where client_id ='4045365' and service_log_id ='2383849';
