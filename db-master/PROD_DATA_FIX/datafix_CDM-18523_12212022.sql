-- CDM-18523 - Service Log Needs To Be Deleted
/*
-- Issue Description: 
   User request to delete the duplicate purchase authorizations, 
   
-- Case ID: 3225322
-- Client ID: 4186107 (ELIJAH CRAMPTON) - 4cad55c2-bade-496f-9b4b-46efab55e836
-- Provider ID: 5094682 (Ashley Daugherty) - Child Care- Informal (Paid)
-- 1802418 - 10/04/2021	To 10/29/2021 - $800.00
-- 1802419 - 10/04/2021 To 10/29/2021 - $800.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Duplicate Authorization (mostly multiple clicks on submit button)
-- Fix Provided: Datafix has been provided to delete the requested Duplicate Purchase Authorizations
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in (1802418, 1802419) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-18523'
where authorization_id in (1802418, 1802419) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
	
select routingid, routingstatustypeid, remarks, objectid, activeflag, updatedby, updatedon
	from routing 
where objectid in ( '1802418', '1802419' )
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;	
	
update routing
set activeflag = 0,
	updatedby = 'CDM-18523',
	updatedon = now()
where objectid in ( '1802418', '1802419' )
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;	
	