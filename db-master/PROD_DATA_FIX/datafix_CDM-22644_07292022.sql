-- CDM-22644 - Unable to approve payment for hospital overstay under code 7108 (S20220133040827)
/*
-- Issue Description: 
   Code 7108 Hosptial Overstay Purchase Authorization request approval issue
	
-- Case ID: 3262159 (Cecil County)
-- Client ID: 3163056 (DOMENIC EDWARD RAGAN) - 762600bc-adda-4637-a7bf-c5f12d256a07
-- Provider ID: 5089546	Psychiatric Institute of Washington
-- Service: Hospital Overstay - Inpatient Psychiatric (Paid) 
-- 1833777	2022-01-27	2022-01-31	5866.75		
-- 1833784	2022-02-01	2022-02-28	32853.80	
-- 1833785	2022-03-01	2022-03-31	36373.85	
-- 1833786	2022-04-01	2022-04-30	35200.50	

-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: Veera is working on the code fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- (Cecil County) OHP Unit #3 - 8ec81864-e227-4763-8927-3da344eeeee9
-- 1833777	2022-01-27	2022-01-31	5866.75		Forwarded to Funding Approval
-- 40 - 7c150fa6-dfa5-4ba8-8a24-b0ed150ad908 - Forwarded to Funding Approval
-- toroleid = 'FNSFW'
select objectid, eventcode, routingstatustypeid, tosecurityusersid, fromroleid, toroleid, teamid, updatedby, updatedon
	from routing 
where routingid = '7c150fa6-dfa5-4ba8-8a24-b0ed150ad908'
	and activeflag = 1 ;

update routing
set toroleid = 'FNSFW',
	teamid = '8ec81864-e227-4763-8927-3da344eeeee9',
	updatedby = 'CDM-22644',
	updatedon = now()
where routingid = '7c150fa6-dfa5-4ba8-8a24-b0ed150ad908'
	and activeflag = 1 ;
	
	
-- Insert record for - 40 - 7c150fa6-dfa5-4ba8-8a24-b0ed150ad908 - Forwarded to Funding Approval	
-- 1833784	2022-02-01	2022-02-28	32853.80
select activeflag, routingstatustypeid, remarks,  *
	from routing 
where objectid = 1833784
	and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc ;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	gen_random_uuid(), 'PCAUTHR', '07284a1e-0906-4b45-b3e8-99fbaa294c81', NULL, 
		'8ec81864-e227-4763-8927-3da344eeeee9'::uuid, 'CWSP', 'FNSFW', '1833784', 40, 
		1, 'CDM-22644', now(), 'CDM-22644', now(), 
		true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', 
		'3262159', 'ServiceCase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
	

select authorization_id, sprvsr_approval_status_cd, ads_approval_status_cd, sprvsr_approval_dt, ads_approval_dt, 
	update_ts, update_user_id 
from tb_service_purchase_authorization  
where authorization_id = 1833784
	and delete_sw  = 'N';
	
update tb_service_purchase_authorization
set sprvsr_approval_status_cd = '3047',
	ads_approval_status_cd = '3047',
	sprvsr_approval_dt = '2022-06-13 14:43:30',
	ads_approval_dt = '2022-06-13 14:43:30',
	update_user_id = 'CDM-22644',
	update_ts = now()
where authorization_id = 1833784
	and delete_sw  = 'N';
	
-- 1833785	2022-03-01	2022-03-31	36373.85
select activeflag, routingstatustypeid, remarks,  *
	from routing 
where objectid = 1833785
	and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc ;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	gen_random_uuid(), 'PCAUTHR', '07284a1e-0906-4b45-b3e8-99fbaa294c81', NULL, 
		'8ec81864-e227-4763-8927-3da344eeeee9'::uuid, 'CWSP', 'FNSFW', '1833785', 40, 
		1, 'CDM-22644', now(), 'CDM-22644', now(), 
		true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', 
		'3262159', 'ServiceCase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
	
select authorization_id, sprvsr_approval_status_cd, ads_approval_status_cd, sprvsr_approval_dt, ads_approval_dt, 
	update_ts, update_user_id 
from tb_service_purchase_authorization  
where authorization_id = 1833785
	and delete_sw  = 'N';
	
update tb_service_purchase_authorization
set sprvsr_approval_status_cd = '3047',
	ads_approval_status_cd = '3047',
	sprvsr_approval_dt = '2022-06-13 14:44:31',
	ads_approval_dt = '2022-06-13 14:44:31',
	update_user_id = 'CDM-22644',
	update_ts = now()
where authorization_id = 1833785
	and delete_sw  = 'N';
	
-- 1833786	2022-04-01	2022-04-30	35200.50
select activeflag, routingstatustypeid, remarks,  *
	from routing 
where objectid = 1833786
	and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc ;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	gen_random_uuid(), 'PCAUTHR', '07284a1e-0906-4b45-b3e8-99fbaa294c81', NULL, 
		'8ec81864-e227-4763-8927-3da344eeeee9'::uuid, 'CWSP', 'FNSFW', '1833786', 40, 
		1, 'CDM-22644', now(), 'CDM-22644', now(), 
		true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', 
		'3262159', 'ServiceCase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);

select authorization_id, sprvsr_approval_status_cd, ads_approval_status_cd, sprvsr_approval_dt, ads_approval_dt, 
	update_ts, update_user_id 
from tb_service_purchase_authorization  
where authorization_id = 1833786
	and delete_sw  = 'N';
	
update tb_service_purchase_authorization
set sprvsr_approval_status_cd = '3047',
	ads_approval_status_cd = '3047',
	sprvsr_approval_dt = '2022-06-13 14:50:37',
	ads_approval_dt = '2022-06-13 14:50:37',
	update_user_id = 'CDM-22644',
	update_ts = now()
where authorization_id = 1833786
	and delete_sw  = 'N';

