-- CDM-19363 - Duplicate Service Voucher
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3089333
-- Client ID: 1289108 (CLAYTON EUGENE LEO Lytle)
-- Service Log ID: 2019353 -  2021-11-03 To 2021-11-03  - Consumer Education (Paid) 
-- Provider ID: 5006715	(Widmyer Driving School)
-- Authorization ID: 1802542
-- Payment ID: 3108179 Date: 11/08/2021 - $350.00   

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
1	40	Forwarded to Funding Approval	65f7ed8a-df62-468a-8769-ac8f0ff48663
1	40	Forwarded to Funding Approval	60fa6adf-1d09-45a4-bc44-8a61b0beb585
1	40	Forwarded to Funding Approval	2631b1d0-b35f-41db-bb06-868be104063f
1	40	Forwarded to Funding Approval	255c1ff9-6c23-4fb7-a80d-cd2b0a01ce16
1	40	Forwarded to Funding Approval	86dd56a1-b6cf-4de4-9113-1bfccd786cb2
1	40	Forwarded to Funding Approval	089e5a0b-004f-4783-9a06-07345aa9b624
1	39	Forwarded to Case Supervisor	7a7debdc-d349-4eb6-95de-9c83a54ed47a
*/

select *
	from routing 
where routingid  in
	(	'65f7ed8a-df62-468a-8769-ac8f0ff48663',
		'60fa6adf-1d09-45a4-bc44-8a61b0beb585',
		'2631b1d0-b35f-41db-bb06-868be104063f',
		'255c1ff9-6c23-4fb7-a80d-cd2b0a01ce16',
		'86dd56a1-b6cf-4de4-9113-1bfccd786cb2',
		'089e5a0b-004f-4783-9a06-07345aa9b624',
		'7a7debdc-d349-4eb6-95de-9c83a54ed47a'
	)
	and objectid = '1802542'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'65f7ed8a-df62-468a-8769-ac8f0ff48663',
		'60fa6adf-1d09-45a4-bc44-8a61b0beb585',
		'2631b1d0-b35f-41db-bb06-868be104063f',
		'255c1ff9-6c23-4fb7-a80d-cd2b0a01ce16',
		'86dd56a1-b6cf-4de4-9113-1bfccd786cb2',
		'089e5a0b-004f-4783-9a06-07345aa9b624',
		'7a7debdc-d349-4eb6-95de-9c83a54ed47a'
	)
	and objectid = '1802542'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7a7debdc-d349-4eb6-95de-9c83a54ed47a'::uuid, 'PCAUTH', 'eb3cda0a-c28d-4292-9a5b-d01fa9b7bcc9', '68ded231-16ad-4c93-a496-273eb0a62c02', '5331ba88-f394-4423-a641-0af2dc6fbc0a'::uuid, 'CWCW', 'CWSP', '1802542', 39, 1, 'eb3cda0a-c28d-4292-9a5b-d01fa9b7bcc9', '2021-11-03 14:54:20.082', 'eb3cda0a-c28d-4292-9a5b-d01fa9b7bcc9', '2021-11-03 14:54:20.082', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('65f7ed8a-df62-468a-8769-ac8f0ff48663'::uuid, 'PCAUTHR', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 14:02:57.174', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 14:02:57.174', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('60fa6adf-1d09-45a4-bc44-8a61b0beb585'::uuid, 'PCAUTHR', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:58:56.986', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:58:56.986', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2631b1d0-b35f-41db-bb06-868be104063f'::uuid, 'PCAUTHR', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:58:18.549', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:58:18.549', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('255c1ff9-6c23-4fb7-a80d-cd2b0a01ce16'::uuid, 'PCAUTHR', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:36:35.833', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2021-12-03 13:36:35.833', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('86dd56a1-b6cf-4de4-9113-1bfccd786cb2'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-11-22 13:44:59.769', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-11-22 13:44:59.769', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('089e5a0b-004f-4783-9a06-07345aa9b624'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1802542', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-11-03 16:07:10.730', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-11-03 16:07:10.730', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089333', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	


