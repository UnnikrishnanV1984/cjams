-- CDM-15264 - Missing adoption case
/*
--	Issue Description: 
	Adoiption case is not displaying under the adoption case dashboard.
    
-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: Partial transaction Data issue - routing record is missing  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To insert missing rounting record  (2 - Accepted)
INSERT INTO cjams.routing
(	routingid, eventcode, fromsecurityusersid, 
	tosecurityusersid, teamid, 
	fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
	remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
	old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
	etl_load_date, entityid, reassignnotes
)
VALUES
(	gen_random_uuid(), 'ADPC', '2787cfb2-d662-4be9-b9f5-de9185968c7e', 
	'c4e49d2b-3ed8-4aea-b0f1-61ba01f73d58', 'bce245a0-d70c-4917-900b-aaabb7f0aab2'::uuid, 
	'CWSP', 'CWCW', '130fdef1-556c-4add-a723-6d6f3bc1de51', 2, 1, 
	'CDM-15264', now(), 'CDM-15264', now(), false, 
	NULL, NULL, NULL, 3296215, NULL, 
	NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL
);
