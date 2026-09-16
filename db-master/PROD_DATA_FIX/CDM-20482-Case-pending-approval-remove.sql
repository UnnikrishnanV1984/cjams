/*
-- CDM-20482- 

-- Issue Description: 
 Approvals not deleting from case pending approval inbox
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select *
	from routing 
where routingid 
	in ( 
			'ddd80551-a25a-4c45-9b80-a3532a4d9344',
			'7172984e-4dda-4317-b98a-ae8703d73415',
			'7c4a57dc-db9c-4253-a671-db2508d81b18',
			'b17cd3d0-3a41-459a-9619-41c2cea23110',
			'532a801a-fa6e-4a97-97fc-2be60bc32738',
			'2b0cf246-19e8-4f11-b27f-575a6000818f',
			'5e7449f7-bbb5-417c-b750-127adaad9362',
			'bc316f4f-7ec1-4f96-b533-42b1c33a0052'
		)	
	and objectid = '1817730'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	;
	
delete from routing   
where routingid 
	in ( 
			'ddd80551-a25a-4c45-9b80-a3532a4d9344',
			'7172984e-4dda-4317-b98a-ae8703d73415',
			'7c4a57dc-db9c-4253-a671-db2508d81b18',
			'b17cd3d0-3a41-459a-9619-41c2cea23110',
			'532a801a-fa6e-4a97-97fc-2be60bc32738',
			'2b0cf246-19e8-4f11-b27f-575a6000818f',
			'5e7449f7-bbb5-417c-b750-127adaad9362',
			'bc316f4f-7ec1-4f96-b533-42b1c33a0052'
		)	
	and objectid = '1817730'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	;
	


/*
-- To Revert the data if needed 1817730

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ddd80551-a25a-4c45-9b80-a3532a4d9344'::uuid, 'PCAUTH', 'b939e204-9cb1-497d-9e31-addd05f958c3', '262f71d0-64d5-4eaf-bd7a-b0901803706c', 'f85f15df-2eff-486e-8a6a-d8a6327f4dbe'::uuid, 'CWCW', 'CWSP', '1817730', 39, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 10:46:53', 'b939e204-9cb1-497d-9e31-addd05f958c3', '2022-02-07 10:46:53', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7c4a57dc-db9c-4253-a671-db2508d81b18'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '55f4400e-7151-48f5-958b-33bd82b0ece5', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7172984e-4dda-4317-b98a-ae8703d73415'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '55f4400e-7151-48f5-958b-33bd82b0ece5', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b17cd3d0-3a41-459a-9619-41c2cea23110'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '55f4400e-7151-48f5-958b-33bd82b0ece5', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('532a801a-fa6e-4a97-97fc-2be60bc32738'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '55f4400e-7151-48f5-958b-33bd82b0ece5', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5e7449f7-bbb5-417c-b750-127adaad9362'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-04-07 15:05:42.017', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bc316f4f-7ec1-4f96-b533-42b1c33a0052'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-04-07 15:05:42.017', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2b0cf246-19e8-4f11-b27f-575a6000818f'::uuid, 'PCAUTHR', '262f71d0-64d5-4eaf-bd7a-b0901803706c', 'a43d0423-d1ff-4ae3-8df0-00e756a27979', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFS', '1817730', 40, 1, '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', '262f71d0-64d5-4eaf-bd7a-b0901803706c', '2022-02-07 14:23:47', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3277242', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	
