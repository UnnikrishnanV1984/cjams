/*
   Issue Description: CJAMS-68466
   Category/ Module  : service log
   Root cause:Service log Date needs to be changed from 5/22 to 5/211 and keep the end date open, this way user should be able to add multiple purchase authorizations of start date as 5/21
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log
set start_dt = '2026-05-21',--null
    end_dt = null,
	update_ts = now(),
	update_user_id = 'CJAMS-68466', 
	end_service_reason_cd = null
where client_id = '3265860' 
and service_log_id =4217319;