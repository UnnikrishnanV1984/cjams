/*
Issue Description: CDM-31334
Root Cause :user want  Approval Status added as "Approved" also need to update the Approved by. 
Data fix :yes
*/
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'SCDR', '40f41281-793c-424c-97e6-3eacd2be1f46', '00000000-0000-0000-0000-000000000000', NULL, 'CWSP', 'CWCW', '33ae1a94-b3dd-4e85-ac02-3068d4cac270', 16, 1, '40f41281-793c-424c-97e6-3eacd2be1f46', now(), 'CDM-31334', now(), false, NULL, null, NULL, NULL, NULL, null,null, NULL, NULL, null, null, NULL, NULL);