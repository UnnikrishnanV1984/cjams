/*
    Issue Description: CDM-10748 Redwood 1763285 $312.47 Funding Approval
   Category/ Module  :  purchase authorization
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Back up:
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('16e0e8a6-ab1a-44f1-af06-b13b0427de2d', 'PCAUTHR', 'da23f52d-6348-413b-9e37-0de2ab823825', 'e68284b1-b8c5-4091-94e3-2894b0ebafbc', 'af5a6281-0f7c-497b-a592-60b6359794c6', 'CWSP', 'FNSFS', '1763285', 40, 1, 'da23f52d-6348-413b-9e37-0de2ab823825', '2021-02-20 07:56:31.409', 'da23f52d-6348-413b-9e37-0de2ab823825', '2021-02-20 07:56:31.409', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3144528', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where objectid=1763285 and routingid='16e0e8a6-ab1a-44f1-af06-b13b0427de2d';