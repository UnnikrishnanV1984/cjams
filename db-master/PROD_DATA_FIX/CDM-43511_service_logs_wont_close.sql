/*
-- Issue Description: 
    Service log can not be ended as the date is overlapping with other service log.
    Data fix is needed to ended the respective service log with the latest Purchase Authorization end-date (09/02/2022).--  Case ID: 3123893
	Client ID: 200155623 (Stanley Lesure)
    Provider ID: 6004469 (Jumoke Behavioral Services, LLC)
    Service: One-on-One (Paid)
    Service Log Begin Date: 10/09/2021
    The Latest Purchase Auth End Date: 09/02/2022
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End date to 2022-09-02.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select end_service_reason_cd,estimated_end_dt,* from cjams.tb_service_log
where service_log_id = 2019555; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-09-02', 
	end_service_reason_cd = '1824', --service completed
	update_user_id='CDM-43511', 
	estimated_end_dt ='2022-09-02',
	update_ts=now() 
WHERE service_log_id = 2019555;

