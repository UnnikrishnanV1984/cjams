-- CDM-18398 - Service Log
/*
-- Issue Description: 
  User is not not able to end date a service log. 
  This case needs to be closed and I am unable to do that until this service log is end-dated.
  And the end date should be 9/30/21.
  
-- Case ID: 3261803
-- Client ID: 1064884 (BRIAN L FOSTER) - fd388781-b764-4e50-8b8c-9ad77238ab73
-- Service Log ID: 931560 - 2019-06-21 To Current 
-- Service: Emergency Shelter (Paid)  
-- Provider ID: 5018393	(Econo Lodge)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue Migarted Service Log (Execption Scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To End date the Service Log
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 931560
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2021-09-30'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-18398'
where service_log_id = 931560
	and delete_sw = 'N';	
