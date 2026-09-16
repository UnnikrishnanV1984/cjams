
/*
   Issue Description: CDM-17888
   Category/ Module  : Removing Pending funding Approval Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('725294ca-ad2c-41f7-85cc-57920e6e4dc9'::uuid, 'PCAUTHR', 'da23f52d-6348-413b-9e37-0de2ab823825', 'e5f2d788-5de8-4fa0-86f6-564ab972a7a5', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1797011', 40, 1, 'da23f52d-6348-413b-9e37-0de2ab823825', '2021-09-28 13:43:58.108', 'da23f52d-6348-413b-9e37-0de2ab823825', '2021-09-28 13:43:58.108', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3210102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


delete routing where routingid = '725294ca-ad2c-41f7-85cc-57920e6e4dc9';