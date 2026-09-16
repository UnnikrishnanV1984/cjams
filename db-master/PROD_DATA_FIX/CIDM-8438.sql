/*
   Issue Description: CIDM-8438
   Category/ Module  : Prod data fix to update the decision status
   Pull request# for code fix: 
   Reason : user still needs to complete SDM section and send for approval 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


delete from routing where routingid in ('43db2122-2644-4432-9bc1-4d685409b6bd');


--INSERT INTO cjams.routing (updatedby, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) VALUES('23c42625-6a7e-45bc-9b78-c4cce5463965', '43db2122-2644-4432-9bc1-4d685409b6bd'::uuid, 'XXXX', '23c42625-6a7e-45bc-9b78-c4cce5463965', '70d83cb8-e49d-4c9f-9a5f-654c82446c38', 'ee67e1c9-f94d-44c5-8928-e88e508fbf34'::uuid, 'CWIW', 'CWSP', 'I202000172656', 1, 0, '23c42625-6a7e-45bc-9b78-c4cce5463965', '2020-08-10 16:31:38.762', '23c42625-6a7e-45bc-9b78-c4cce5463965', '2024-02-27 16:13:35.085', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

