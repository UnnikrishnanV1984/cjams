/*
   Issue Description: CDM-28878
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '4864db09-5b54-4317-bda3-9c52b47ae4ea', '8cfdea99-2e4f-41b6-9b1d-bbc29062f52e', NULL, 'CWSP', 'CWCW', '421f2216-49e4-4e51-a01b-1eebfcc37c4b', 16, 1, '4864db09-5b54-4317-bda3-9c52b47ae4ea', now(), 'CDM-28878', now(), false, NULL, '3290414', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
