-- CDM-17893 - Duplicate approvals for service log
/*
-- Issue Description: 
   To delete the duplicate purchase authorizations 
   
-- Case ID: 211030009325
-- Client ID: 3942671 (ADYSON MORELAND) - 108c0d1d-9496-46d5-a6f1-b297f6ea22fd
-- Service Log ID: 2018243 - Birth Certificate (Paid)
-- Provider ID: 5026062 (Vitalchek)
   
-- Authorization IDs: 1801059, 1801058, 1801057, 1801056 and 1801055
-- Approved Auth ID: 1801060

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in (1801059, 1801058, 1801057, 1801056, 1801055)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-17893'
where authorization_id in (1801059, 1801058, 1801057, 1801056, 1801055)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

-- Delete duplicate routing records for Approved Auth ID: 1801060
/*
1	40	47137ad8-d2ac-4fba-ad61-47cbac100e10	Forwarded to Funding Approval
1	40	93985f48-d279-44e2-80c4-ef237aa345c4	Forwarded to Funding Approval
1	40	71ec7054-8c13-4cf0-a4db-3b37dfe103a1	Forwarded to Funding Approval
1	39	1397081a-e382-41cb-97ed-4a34143a92fd	Forwarded to Case Supervisor
*/

select *
	from routing 
where routingid in ( '47137ad8-d2ac-4fba-ad61-47cbac100e10',
					 '93985f48-d279-44e2-80c4-ef237aa345c4',
					 '71ec7054-8c13-4cf0-a4db-3b37dfe103a1',
					'1397081a-e382-41cb-97ed-4a34143a92fd'
					)
	and objectid = '1801060'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


delete from routing   
where routingid in ( '47137ad8-d2ac-4fba-ad61-47cbac100e10',
					 '93985f48-d279-44e2-80c4-ef237aa345c4',
					 '71ec7054-8c13-4cf0-a4db-3b37dfe103a1',
					'1397081a-e382-41cb-97ed-4a34143a92fd'
					)
	and objectid = '1801060'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1397081a-e382-41cb-97ed-4a34143a92fd', 'PCAUTH', 'be997f35-227d-417f-a4d5-2df232639a24', '68ded231-16ad-4c93-a496-273eb0a62c02', '5331ba88-f394-4423-a641-0af2dc6fbc0a', 'CWCW', 'CWSP', '1801060', 39, 1, 'be997f35-227d-417f-a4d5-2df232639a24', '2021-10-26 14:14:57.279', 'be997f35-227d-417f-a4d5-2df232639a24', '2021-10-26 14:14:57.279', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030009325', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('71ec7054-8c13-4cf0-a4db-3b37dfe103a1', 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332', 'CWSP', 'FNSFW', '1801060', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:20:01.079', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:20:01.079', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030009325', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('93985f48-d279-44e2-80c4-ef237aa345c4', 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332', 'CWSP', 'FNSFW', '1801060', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:22:13.262', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:22:13.262', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030009325', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('47137ad8-d2ac-4fba-ad61-47cbac100e10', 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332', 'CWSP', 'FNSFW', '1801060', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:49:42.452', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-10-26 14:49:42.452', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030009325', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
