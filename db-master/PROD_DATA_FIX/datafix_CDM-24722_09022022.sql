-- CDM-24722 - Cannot end date payment
/*
-- Issue Description: 
  User is not not able to end date a service log. 
  User request to end date teh Service Log with 08/29/2022.
  
-- Case ID: 3142741
-- Client ID: 1764886 (GARY S ACE) - 4db7eb7e-76ec-4e1a-9744-9ce5c9436bc1
-- Service Log ID: 954540 - 2019-09-03 TO Current - Educational-High School (Paid) 
-- Provider ID: 5000486 (Arrow Child & Family - Ascension Place)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue Migarted Service Log (Execption Scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To End date the Service Log
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 954540
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2022-08-29'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-24722'
where service_log_id = 954540
	and delete_sw = 'N';	
