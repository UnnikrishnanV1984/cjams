/*
Issue Description: CJAMS-61613 Returned service log
Category/Module: GAP Subsidy
Root cause: User requested to update the servicelog status to denied Case ID: 3303415
Client ID: 4389101 (SKYLAR RADAR)
Provider ID#: 5013914 (Abigail Hamlin)
Auth ID#: 1761015
Fix provided: Data fix has been done to update the servicelog status to denied Case ID: 3303415
Data/Code fix ticket#: CJAMS-61613
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be Decided
Reason why no related code fix: This is a know issue and agreement start date is fetched from latest court order for GAP agreement 
                                but it is not getting updated in the subsidy rate. Data fix should fix it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update tb_service_purchase_authorization
set funding_approval_dt = current_date,
	funding_approval_status_cd = '3281',
	update_user_id = 'CJAMS-61613',
	update_ts = now()	
where delete_sw = 'N'
	and authorization_id = 1761015 ;

update routing 
set routingstatustypeid = 62,
	updatedby = 'CJAMS-61613',
	remarks = 'Denied',
	updatedon = now()	
where routingid = '0878da34-a376-42af-b13b-d288f2e84403'
and	eventcode = 'PCAUTH'
and objectid = '1761015'
and activeflag = 1;