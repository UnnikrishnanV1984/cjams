-- CDM-32496 - Funding Request
/*
-- Issue Description: 
   Unable to approve the Payment Authorization Purchase 
   
-- Case ID: 3275681
-- Client ID: 4077150 (AMIYAH L	CAZER) - aca9e97c-66f7-4f0e-9f86-6685bd321b0a
-- Auth ID: 2151790 - 2023-05-25 To 2023-05-31 - $1123.50 -  Financial Management (Paid) 
-- Provider ID: 5008901	(Anne Arundel Co. DSS - Admin)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Purchase Authorization Supervisory Apporval (#39) record is msiing in the routing table. (TBD) 
-- Fix Provided: Datafix has been promoted to add the missing Purchase Authorization Supervisory Apporval record.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- jennifer.gardner@maryland.gov - 4941b61a-c71b-48d1-9337-26ed83001910
-- rachael.maconachy@maryland.gov - a37cfda9-e898-4c94-8eef-7f565e129bf2
select count(*) 
	from cjams.routing 
where insertedby = 'CDM-32496' 
	and eventcode = 'PCAUTH';
	
delete from cjams.routing 
	where insertedby = 'CDM-32496' 
and eventcode = 'PCAUTH';

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid,
		tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, 
		principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'PCAUTH', '4941b61a-c71b-48d1-9337-26ed83001910', 
		'a37cfda9-e898-4c94-8eef-7f565e129bf2', 
		'8d6c4246-e1ce-44c0-81de-c93d70ba126e', 'CWSP', 'CWSP', '2151790', 39, 
		0, 'CDM-32496', -- '4941b61a-c71b-48d1-9337-26ed83001910',
		'2023-05-22 10:30:00.196', 
		'CDM-32496', -- '4941b61a-c71b-48d1-9337-26ed83001910', 
		now(), -- '2023-05-22 15:29:03.285', 
		true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', 
		'3275681', 'ServiceCase', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL
	);


select routingstatustypeid, fromsecurityusersid, remarks, updatedby, updatedon
	from routing
where routingid = 'b6fa23d0-5596-46a9-8525-525bb14061d2' ;

update routing
set fromsecurityusersid = 'a37cfda9-e898-4c94-8eef-7f565e129bf2', -- rachael.maconachy@maryland.gov
	updatedby = 'CDM-32496',
	updatedon = now()
where routingid = 'b6fa23d0-5596-46a9-8525-525bb14061d2' ;	


-- Case ID: 3223180
-- Client ID: 3270683
-- Auth ID: 1822354 -2022-02-01	To 2022-02-07 - $361.08 - Special Education (Paid)
-- Provider ID: 5000543	(Associated Catholic Charities Inc.)

-- 967e1d70-c77b-43fa-b4e5-78136189b1b0	Tawanna N. Tilghman
-- cc06cfea-6136-4b28-bddf-51861be48926	Gregory Hinton
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, 
		principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'PCAUTH', 'cc06cfea-6136-4b28-bddf-51861be48926', 
		'967e1d70-c77b-43fa-b4e5-78136189b1b0', '3d26c9ae-8513-43ac-8084-ea2f5b30524d', 'CWCW', 'CWSP', '1822354', 39, 
		0, 'CDM-32496', -- 'cc06cfea-6136-4b28-bddf-51861be48926', 
		'2022-05-19 13:52:21.491', 
		'CDM-32496', -- 'cc06cfea-6136-4b28-bddf-51861be48926',
		now(), -- '2023-05-24 15:31:16.936', 
		true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', 
		'3223180', 'ServiceCase', NULL, NULL,
		NULL, NULL, NULL, NULL, NULL, NULL
	);
