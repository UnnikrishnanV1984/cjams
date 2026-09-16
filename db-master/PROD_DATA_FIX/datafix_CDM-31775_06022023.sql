-- CDM-31775 - Service Log Issue
/*
-- Issue Description: 
   User request to delete the returned Authorization
   
-- Case ID: 3189768
-- Client ID: 200881523 (Mydon'yah Parker) - 687974a3-5bf5-4293-a4a0-255e998932e0
-- Auth ID: 1833772 - 2022-05-20 To 2022-05-20 - Child Care (Paid)  - $200.00
-- Provider ID: 6000507	(JASMINE JOY SOLOMON)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the requested un-apporved Authorization 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the un-apporved Purchase Authorizations (CDM-31775)
select authorization_id, service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1833772
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-31775'
where authorization_id = 1833772
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

select routingid, routingstatustypeid, remarks, updatedby, updatedon  
	from routing 
where objectid = '1833772'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-31775', 
	updatedon = now() 
where objectid = '1833772'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
