-- CDM-14150 - Pending purchase authorization
/*
-- Issue Description:
   Service log approved by the supervisor but it has not appeared in the fiscal box for final funding/payment approval. 
   Purchase Authorization Forwarded to Funding Approval with missing routing record 
  
-- Case ID: 3305836
-- Client ID: 3865394 (SHARONDA CHANTEL STINER) - 4b194297-0c3e-488b-b9e7-097fcf7dc515
-- Provider ID: 5045482	(Lead4Life, Inc.)
-- Service Log ID: 1958114 - Mentoring (Paid) 
-- Authorization ID: 1734309 - 2020-04-23 To 2020-05-31- $427.50
	
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Partial Transaction- Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

Insert into cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
values
	(	gen_random_uuid(), 'PCAUTH', 'c3233284-80c4-41a0-8485-d168b93d2a6d', 
		'93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1'::uuid, 
		'CWSP', 'FNSFS', '1734309', 40, 1, 
		'CDM-14150', now(), 'CDM-14150', now(), true, 
		'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3305836', 'ServiceCase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, null
	);

