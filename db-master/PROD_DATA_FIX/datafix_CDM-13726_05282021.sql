-- CDM-13726 - Data Fix for Supervisory Appr of Man AR
/*
-- Issue Description: 
	Manual Account receivable with missing routing record.
	NEED DATAFIX to send /assign supervisory approval to Lisa Smick
	
	Provider ID: 6001718 (Carol Toft)
    Receivable Detail ID: 1718721 - $100.64
	
-- Category/ Module: Account Receivables (Finance Management)
-- Root cause: System is allowing the user to proceed without selecting the Supervisor. 
-- Pull request# Code fix is in-progress 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Build
*/
	
insert into cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, 
		routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
values
	(	gen_random_uuid(), 'MANREC', '462dcfba-84ac-4672-924a-db788066371a',
		'fbfb568e-6760-4b0b-aabb-856d9c3892db', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 
		'FNSFS', 'FNSFS', '1718721', 73, 1, 
		'CDM-13726', now(), 'CDM-13726', now(), TRUE, 
		'Manual Account Receivable Request', NULL, 
		'Manual Account Receivable Request for Ancillary payment id (3021890) ', NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, null
	);

