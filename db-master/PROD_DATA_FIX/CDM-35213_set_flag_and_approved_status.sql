-- CDM-35213 - Set activeflag and routingstatustypeid
/* Issue Description:231020638833:Not able to process for approval. 

-- Case ID: 231020638833 - fe5c6b2f-64f4-4e6e-bc51-551a7daaaa5

-- Category/ Module: Decision/Disposition

-- Root cause: Active flag was not set to 1 and routingstatustypeId was given as 15 instead of 16
-- Fix Provided: Fixing the issue by inserting new record in reversing the fromsecurityusersid and tosecurityusersid. # 231020638833
-- Pull request# N/A
*/

 INSERT INTO routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
 fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
 remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid)
VALUES(gen_random_uuid(), 'INDR', 'c078eed8-fab6-490d-b099-47f9b968a5dc', '4cc34ec2-2913-452e-8a67-722d1ac3a03b', '602c7ed5-5692-459e-9e9c-a6c1c83bce80',
	   'CWSP', 'LDSSRW','9db26c71-1623-44b6-a15e-9cd15de5ffc6', 16, 1, 'Datafix user as per CDM-35213', now(), 'Datafix user as per CDM-35213', now(), true, 
	   '', null, '', '231020638833', null, null, null, null, null, null, null, null);