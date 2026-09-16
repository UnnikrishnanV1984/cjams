
/*
   Issue Description: CDM-32803
   Category/ Module  : Prod data fix for case plan approval
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('550d79a5-4e95-4d11-bcdc-bda033da98dc'::uuid, 'CPLAN2', '097e343f-cfa4-4d35-8424-cdeb8c553964', '58c1ad2a-07a3-4cc0-9398-1ce1d525bb17', '72083324-dd09-4aa8-afa3-b4d24aa63148'::uuid, 'CWCW', 'CWSP', '69e4ac41-5231-40cd-9ea2-06b12245cab8', 15, 1, '097e343f-cfa4-4d35-8424-cdeb8c553964', '2021-07-20 19:16:56.255', 'CDM-32803', '2021-08-02 13:18:07.583', false, 'Case plan Approved ', NULL, NULL, '3235378', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) on conflict do nothing;
