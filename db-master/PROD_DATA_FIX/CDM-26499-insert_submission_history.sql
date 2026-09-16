/*
   Issue Description: CDM-26499
   Category/ Module  : Intake submission
   Root cause: user wants to insert a row in submission history
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('XXXX', 'c6f24452-2d82-4b22-b04c-f961d04b9824', '0ae86a6f-5365-4bb2-b079-f85eb391a2ae', '38396fb7-2cef-4e5d-98a0-8a05d5ea8344'::uuid, 'CWIW', 'CWSP', 'I221010329346', 1, 1, 'CDM-26499', now(), 'CDM-26499', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	