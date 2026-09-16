
/*
   Issue Description: CDM-19083
   Category/ Module  : Removing the funding Approval Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


/*
INSERT INTO cjams.routing(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2b454bd8-c3db-4cec-b35b-c1ccc09cbb07'::uuid, 'PCAUTHR', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', NULL, 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1807532', 40, 1, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2021-12-08 16:20:24.472', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '2021-12-08 16:20:24.472', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3265591', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete routing where routingid = '2b454bd8-c3db-4cec-b35b-c1ccc09cbb07';