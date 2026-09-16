-- CDM-25266 - Duplicate approvals in inbox
/*
   FileName: CDM-25266-Routing-Removing-Duplicate-Approvals
-- Issue Description: 
	for the Case number 3288225 and 3231587  duplicate approvals in the inbox-need to be deleted. 

    Customer Email ID:brooke.davis@maryland.gov
  
-- Resolution: Updated the activeflag to zero in the routing table for the servicerequestnumber 3288225
	and deleting the duplicate request from the routing table for the servicerequestnumber 3231587

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

Back up insert script

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('4f4de5ae-c18c-45a0-93cb-c2f09a55fe6f'::uuid, 'PCAUTH', '49f817a4-264b-45c3-9fc7-957bee22e423', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '887a9853-369f-4cf5-bde2-908322c0785d'::uuid, 'CWCW', 'CWSP', '1848684', 39, 1, '49f817a4-264b-45c3-9fc7-957bee22e423', '2022-08-18 11:02:44.348', '49f817a4-264b-45c3-9fc7-957bee22e423', '2022-08-18 11:02:44.348', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3288225', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('6ea915e9-993f-4b96-ab1d-aff4c34a0394'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1848684', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2022-08-29 08:35:29.554', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2022-08-29 08:35:29.554', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3288225', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('57453323-ef53-412f-90b2-b2e75370c0c1'::uuid, 'PCAUTHR', '194def4d-9603-4b10-87eb-c7242ddaa119', 'adc5892a-0392-4ae8-b74e-d389b4bbcf15', '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'FNSFS', 'FNSFS', '1848684', 43, 0, '194def4d-9603-4b10-87eb-c7242ddaa119', '2022-08-18 13:01:03', '194def4d-9603-4b10-87eb-c7242ddaa119', '2022-08-29 08:35:29', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/


DELETE FROM cjams.routing WHERE routingid='6ea915e9-993f-4b96-ab1d-aff4c34a0394'::uuid;

DELETE FROM cjams.routing WHERE routingid='4f4de5ae-c18c-45a0-93cb-c2f09a55fe6f'::uuid;

DELETE FROM cjams.routing WHERE routingid='57453323-ef53-412f-90b2-b2e75370c0c1'::uuid;

update routing set activeflag = 0 where routingid = 'd704b2dd-0603-4fa1-8605-ace8b630588e' and objectid= 'da6fa532-8652-4986-a9a9-ff42adff5e23';