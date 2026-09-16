/*
  Issue Description: CDM-42789  Service logs
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
-- Case# 3305995, Client ID: 4412685 (AYLIN ZELAYA)
/*
1. Provider ID: 5016954 (Value City Furniture)
Service: Furniture (Paid)
Service log begin date: 10/21/2024
Purchase Auth End-Date: 10/21/2024
Purchase Auth Status: Forwarded to Program Manager Approval
Service log Estimated and Actual End needs to be - 10/21/2024.
*/

/*
select end_service_reason_cd,* from cjams.tb_service_log
where service_log_id = 3537551; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-10-21', 
	update_user_id='CDM-42789', 
	estimated_end_dt ='2024-10-21',
	end_service_reason_cd = 1824,
	update_ts=now() 
WHERE service_log_id = 3537551;



/*
2. Provider ID: 5087075 (Immigration Legal Services, Esperanza Center)
Service: Family Conferencing (Paid)
Service log begin date: 09/17/2024
Purchase Auth End-Date: 10/30/2024{}
Service log Estimated and Actual End needs to be - 10/30/2024.
*/

/*
select end_service_reason_cd,* from cjams.tb_service_log
where service_log_id = 3525488; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-10-30', 
	update_user_id='CDM-42789', 
	estimated_end_dt ='2024-10-30',
	end_service_reason_cd = 1824,
	update_ts=now() 
WHERE service_log_id = 3525488;


/*
3. Provider ID: 5036607 (Baltimore City Department of Social Services)
Service: Financial Management (Paid)
Service log begin date: 07/01/2024
Purchase Auth End-Date: 10/31/2024{}
Service log Estimated and Actual End needs to be - 10/31/2024.
*/

/*
select end_service_reason_cd,* from cjams.tb_service_log
where service_log_id = 3265750; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-10-31', 
	update_user_id='CDM-42789', 
	estimated_end_dt ='2024-10-31',
	end_service_reason_cd = 1824,
	update_ts=now() 
WHERE service_log_id = 3265750;

/*
4. Provider ID: 5036607 (Baltimore City Department of Social Services)
Service: Rent Payments/Deposit (Paid)
Service log begin date: 11/15/2023
Purchase Auth End-Date: 10/31/2024{}
Service log Estimated and Actual End needs to be - 10/31/2024.
*/

/*
select end_service_reason_cd,* from cjams.tb_service_log
where service_log_id = 2892638; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-10-31', 
	update_user_id='CDM-42789', 
	estimated_end_dt ='2024-10-31',
	end_service_reason_cd = 1824,
	update_ts=now() 
WHERE service_log_id = 2892638;
