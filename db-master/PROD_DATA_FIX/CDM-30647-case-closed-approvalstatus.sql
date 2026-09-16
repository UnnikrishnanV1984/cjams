/*
   Issue Description: CDM-30647
   Category/ Module  : Decision- update the Approval status and Approvedby
   Root cause:  Approval Status and Approved By info not there in Decision screen
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'SCDR', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', NULL, 'CWSP', 'CWCW', '6c0e29c7-0990-441e-a897-11a30f73db39', 16, 1, 'CDM-30647', now(), 'Migration_child_removal', '2019-11-12 09:34:43.000', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Data Migration', NULL, NULL, NULL);