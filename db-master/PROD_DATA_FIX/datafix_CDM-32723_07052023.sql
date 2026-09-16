-- CDM-32723 - Manual service log adjustment for $30 - help with approval
/*
-- Issue Description: 
	User is unable to approval the Manual System Adjustment Payment.

-- System Addjustment Payment ID: 3475850 Date: 06/26/2023 -$30.00
-- Provider ID: 5092594 (Christina Hause)
-- Requestor: 474229ae-a4d6-4857-8c68-569349ec9552	joseph.lecompte1@maryland.gov	Joseph LeCompte
-- Supervisor: fbfb568e-6760-4b0b-aabb-856d9c3892db	lisa.smick@maryland.gov			Lisa Smick

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Partail transaction, the supervisor approval request (routing) record is missing. 
-- Fix Provided: Data fix has been promoted to add the missing supervisor approval request (routing) record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before
select routingid, objectid, remarks, routingstatustypeid, insertedby, insertedon
	from routing 
where eventcode = 'ANPAYADJ'
	and objectid = '3475850' ;

	
-- 51	Ancillary Payment Adjustment
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, 
		routeddescription, servicerequestnumber, objecttypekey, old_from_id, 
		old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	cjams.gen_random_uuid(), 'ANPAYADJ', '474229ae-a4d6-4857-8c68-569349ec9552', 
		'fbfb568e-6760-4b0b-aabb-856d9c3892db', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 
		'FNSFS', 'FNSFS', '3475850', 51, 
		1, 'CDM-32723', now(), 'CDM-32723', now(), 
		true, 'Forwarded to Payment Approval', NULL, 
		'Purchase Adjustment Forwarded to Payment Approval', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
	
-- After
select routingid, objectid, remarks, routingstatustypeid, insertedby, insertedon
	from routing 
where eventcode = 'ANPAYADJ'
	and objectid = '3475850' ;
