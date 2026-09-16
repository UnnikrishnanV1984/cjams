
/*
   Issue Description: CDM-25887
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.routing set activeflag =0, updatedby ='CDM-25887', updatedon=now()
where routingid ='b6a8f8e1-b4f8-43f8-bd9d-795f192520f9';

INSERT INTO cjams.routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES('00e39198-ff6e-444f-9616-9fe6b4efa42a'::uuid, 'ADPR', '9208693f-7cdf-45ae-983b-e4eaa0a3cb7c', '8a06aed2-7164-477d-979f-071786254036', 'c17315a2-577c-4796-8371-1618255d5117'::uuid, 'CWSP', 'CWCW', '95d3afac-89a2-4a9f-bef5-bfaead822ab8', 16, 1, '8a06aed2-7164-477d-979f-071786254036', now(), 'CDM-25887', now(), true, '', NULL, '', '3252886', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

