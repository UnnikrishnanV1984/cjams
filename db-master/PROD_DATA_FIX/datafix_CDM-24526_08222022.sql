-- CDM-24526 - Erroneous purch auth
/*
-- Issue Description: 
   Purchase authorization pending routing record where Srevice Log is a deleted record 
   
-- Case ID: 3277988
-- Client ID: 3478272 (JOHN HUEMMER) - 57b1ab30-7c51-4b6c-9952-26835367cc91
-- Service Log ID: 2020212 - Drug/Alcohol Assessment (Non-Paid)
-- Provider ID: 5009658	Health Dept. ( Cecil County )
-- Authorization ID: 1803660 - 2021-09-09 To 2021-09-09 

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1803660
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-24526'
where authorization_id = 1803660
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
	
-- Delete 
-- 1	39	Forwarded to Case Supervisor	7dec9cca-c63f-4a40-9f68-f581c458d7b0
-- 0	42	Forwarded to Director Approval	a6620b18-8de0-4c74-94dc-a4a31e5dca09

select *
	from routing 
where routingid  = 'ec336a51-3669-4f96-ab2b-5456db5d264f'
	and objectid = '1803660'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  = 'ec336a51-3669-4f96-ab2b-5456db5d264f'
	and objectid = '1803660'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ec336a51-3669-4f96-ab2b-5456db5d264f', 'PCAUTH', 'ecbae51c-ea05-4f05-bd78-67461d1b7e64', 'bcd0eec6-bb5e-4181-a07f-2abca7223434', 'f2d84715-e9cd-414c-a9d9-276d2182204b', 'CWCW', 'CWSP', '1803660', 39, 1, 'ecbae51c-ea05-4f05-bd78-67461d1b7e64', '2021-11-09 16:47:37.361', 'ecbae51c-ea05-4f05-bd78-67461d1b7e64', '2021-11-09 16:47:37.361', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3277988', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
	