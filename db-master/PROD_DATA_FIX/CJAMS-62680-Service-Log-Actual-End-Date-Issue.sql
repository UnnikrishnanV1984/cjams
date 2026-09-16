/*
Issue Description: :221030018224:We are trying to close this case and unable to add the actual end date to three of the service log requests in this case under Azora Lawson and Dominic Lawson (child).
Category/Module: Support
Root cause: User Request, user requested to end the service log and to update the routing funding approval to  Beverly Brice (beverly.brice@maryland.gov) instead of Debra Danbridge
Fix provided: DB queries to update  record in tb_service_log table and routing table.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

--"07/02/2025"
/*Provider ID: 6223449 (Price Busters)
Service: Furniture (Paid)
Service Log Actual End Date should be updated 07/02/2025
*/
UPDATE cjams.tb_service_log
SET end_dt='2025-07-02', 
	estimated_end_dt = '2025-07-02',
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-62680', 
	update_ts=now() 
WHERE service_log_id = 3720653;

--"06/30/2025"
/*Provider ID: 5065754 (Mary Pittman)
Service: Child Care (Paid)
Service Log Actual End Date should be updated 06/30/2025
*/

UPDATE cjams.tb_service_log
SET end_dt='2025-06-30', 
	estimated_end_dt = '2025-06-30',
	end_service_reason_cd = '1824', --service completed
	update_user_id='CJAMS-62680', 
	update_ts=now() 
WHERE service_log_id = 2657163;

/*
Provider ID: 5036607 (Baltimore City Department of Social Services)
Auth ID: 2632299 - Forwarded to Funding Approval
APPROVED/DENIED BY should be routed to Beverly Brice (beverly.brice@maryland.gov) instead of Debra Danbridge
*/
--select routingstatustypeid,fromsecurityusersid,tosecurityusersid,* from routing where objectid = '2632299';

update routing
set tosecurityusersid = '676ac1ec-f338-4646-a786-b3af379986f9',--df4e91fc-5824-45b0-baae-788cacf3bc79
	updatedby = 'CJAMS-62680',
	updatedon = now()
where routingid = '60ac004c-680d-472e-8899-63d8c81efa92' 
	and activeflag = 1;
