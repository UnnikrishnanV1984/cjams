/* 
    Issue Description: CDM-37374
   Category/ Module  : completed approval remaining in in box
   Root cause: The purchase auth has been approved by the supervisor in the approval history but still showed as Pending for supervisor approval, 
   and this purchase auth still listed in the supervisor approval inbox.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/
-- Deleting the duplicate pending record

delete from routing 
where routingid='6e89fbff-5fc5-4cfc-86af-f686300d10d6' 
and objectid='2773231' and eventcode='PCAUTH'-- and activeflag = 1
;

-- Making the record active and status to pending , As no Funding supervisior approval details available in purchase auth table

update routing set activeflag=1
where routingid='7807c449-8707-47cb-bf40-6ab4b1a936e0'
and objectid='2773231'and eventcode='PCAUTHR';

/*
-- To Revert the data if needed 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6e89fbff-5fc5-4cfc-86af-f686300d10d6', 'PCAUTH', '31455a75-542a-4f82-a7eb-d97a6189945a', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '3800ed0f-5b2e-438c-8e80-9cb06b5d494f', 'CWCW', 'CWSP', '2773231', 39, 1, '31455a75-542a-4f82-a7eb-d97a6189945a', '2023-11-29 11:23:36.832', '31455a75-542a-4f82-a7eb-d97a6189945a', '2023-11-29 11:23:36.832', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3224050', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/