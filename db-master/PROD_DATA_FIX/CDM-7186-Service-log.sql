 /*  Issue Description: CDM-7186-Service log
   Category/ Module  :  Service log purchase authorization
   Root cause: Unable to reproduce it.So making data fix for removind the unwanted routing
   Pull request# for code fix: Unable to reproduce it.
   Reason why no related code fix: Unable to reproduce it.
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup for deletion: 
   INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6b44d872-2e26-41d8-9075-9a0d2e56005b', 'PCAUTHR', '7a8cd264-8789-4016-9bb1-353a27d24785', '194def4d-9603-4b10-87eb-c7242ddaa119', '94195b2e-5043-4293-b60f-8d3c719b8bbe', 'CWSP', 'FNSFS', '1750133', 40, 1, '7a8cd264-8789-4016-9bb1-353a27d24785', '2020-11-10 11:43:47.169', '7a8cd264-8789-4016-9bb1-353a27d24785', '2020-11-10 11:43:47.169', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3142364', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
 delete from routing where objectid=1750133 and routingstatustypeid=40 and activeflag=1 and routingid = '6b44d872-2e26-41d8-9075-9a0d2e56005b';
