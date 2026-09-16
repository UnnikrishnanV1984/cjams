--CDM-26259 - Sup unable to approve annual review
/*
-- Issue Description: 
   Supervisor unable to see the Review request in Approval inbox
   
-- Case ID: 3250582

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ADYR', '73999176-0c94-4d08-9ef2-0efe966ce506', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '8b52b065-f31c-49cd-a3e5-815ea83dab8e', 'CWCW', 'CWSP', 'd2b3b43e-ef70-4df8-b46d-292bdce462b4', 15, 1, '73999176-0c94-4d08-9ef2-0efe966ce506', now(), 'CDM-26259', now(), true, 'Adoption Annual Review Submitted for Review', NULL, 'Adoption Annual Review Submitted for Review', '3250582', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
