/*
   Issue Description: CJAMS-62296, 221030015398:Not able to close service log with an end date of 3/25/2025 because this entry overlaps with a previous entry that started January 16, 2024.
   Category/ Module  : Removing person from case
   Root cause: As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
    CJAMS application is currently not allowing the users to create a new service log or end date the service log if there is an open or overlapping with the prior service log begin & end date.
    In this case, there is an overlapping service log created for the same provider and service so data fix is needed to ended the service log with 03/25/2025.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE cjams.tb_service_log
SET end_dt='2025-03-25', 
	end_service_reason_cd = 1824, --service completed
	estimated_end_dt = '2025-03-25',
	update_user_id='CJAMS-62296',
	update_ts=now() 
WHERE service_log_id = 2748622 
and delete_sw = 'N';