-- CDM-18336 - Ancillary Pmt Adj
/*
-- Issue Description: 
	Worker created an ancillary payment adjustment for provider ID 5055592, Client ID 3634701, 
	Orig Pmt ID 3107145 in the amount of $0.40, but payment cannot be found for approval. 

-- Org Payment ID: 3107145
-- Client ID: 3634701 (JAYDEN LESTER) - 3c2f5271-166b-4f4a-9c8e-e1ff71a22229
-- Adj Payment ID: 3108351
-- Provider ID: 5055592	(Celebree Learning Center)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Partail transaction, the supervisor approval request (routing) record is missing 
-- Fix Provided: Data fix has been promoted to add the missing supervisor approval request (routing) record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before
select routingid, objectid, remarks, routingstatustypeid, insertedby, insertedon
	from routing 
where eventcode = 'ANPAYADJ'
	and objectid = '3108351' ;

	
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
	(	cjams.gen_random_uuid(), 'ANPAYADJ', 'bf93883d-7176-446d-89ac-d631d63c9400', 
		'462dcfba-84ac-4672-924a-db788066371a', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 
		'FNSFS', 'FNSFS', '3108351', 51, 
		1, 'CDM-18336', now(), 'CDM-18336', now(), 
		true, 'Forwarded to Payment Approval', NULL, 
		'Purchase Adjustment Forwarded to Payment Approval', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
	
-- After
select routingid, objectid, remarks, routingstatustypeid, insertedby, insertedon
	from routing 
where eventcode = 'ANPAYADJ'
	and objectid = '3108351' ;
