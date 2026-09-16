-- CDM-16890 - Service Log Date Issue
/*
-- Issue Description: 
  Service Log with incorrect year number in the end date column.
	
-- Service Log ID	Case ID	Client ID	Start Date	End Date		Correct Date
-- 763966			3162954	1410019		2016-11-15	20201-06-21		(2021-06-21)
-- 2000613			3269050	1047342		2021-05-20	21021-05-20		(2021-05-20)
-- 2004006			3246904	4459452		2021-06-24	20221-06-24		(2021-06-24)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue (Execption Scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- re-commited
*/

-- Service Log ID	Case ID	Client ID	Start Date	End Date		Correct Date
-- 763966			3162954	1410019		2016-11-15	20201-06-21		(2021-06-21)
select service_log_id, case_id, client_id, start_dt, end_dt,
	update_ts, update_user_id 
from tb_service_log sl
where delete_sw = 'N'
	and service_log_id = 763966
	and length(end_dt) > 10 ; 
	
	
update tb_service_log
set end_dt = '2021-06-21'::date,
	update_ts = now(), 
	update_user_id = 'CDM-16890'
where delete_sw = 'N'
	and service_log_id = 763966
	and length(end_dt) > 10 ; 


-- Service Log ID	Case ID	Client ID	Start Date	End Date		Correct Date
-- 2000613			3269050	1047342		2021-05-20	21021-05-20		(2021-05-20)
select service_log_id, case_id, client_id, start_dt, end_dt,
	update_ts, update_user_id 
from tb_service_log
where delete_sw = 'N'
	and service_log_id = 2000613
	and length(end_dt) > 10 ; 
	
	
update tb_service_log
set end_dt = '2021-05-20'::date,
	update_ts = now(), 
	update_user_id = 'CDM-16890'
where delete_sw = 'N'
	and service_log_id = 2000613
	and length(end_dt) > 10 ; 


-- Service Log ID	Case ID	Client ID	Start Date	End Date		Correct Date
-- 2004006			3246904	4459452		2021-06-24	20221-06-24		(2021-06-24)
select service_log_id, case_id, client_id, start_dt, end_dt,
	update_ts, update_user_id 
from tb_service_log
where delete_sw = 'N'
	and service_log_id = 2004006
	and length(end_dt) > 10 ; 
	
	
update tb_service_log
set end_dt = '2021-06-24'::date,
	update_ts = now(), 
	update_user_id = 'CDM-16890'
where delete_sw = 'N'
	and service_log_id = 2004006
	and length(end_dt) > 10 ;
	
	