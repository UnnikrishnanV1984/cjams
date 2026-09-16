/*
   Issue Description: CDM-29774
   Category/ Module  :Chennal Powell - in Box
   Root cause: : 3173691 - approval record not created in routing table 
   Pull request# for It's a data fix. As part of- CDM-29686  Code fix PR raised
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-29774',  updatedon = now() where routingid ='a81f25e1-a49b-40ed-85a2-03ee8f4e7ed5';

INSERT INTO cjams.routing
(eventcode, tosecurityusersid, fromsecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'CPLAN2', '75bb17ca-2dad-4eea-be18-3035df2d57ff', '43ec8597-9ceb-4aa4-8cdf-f81e52a56e94', '0af3203c-5254-407f-a333-36c0acc53457', 'CWSP', 'CWSP', '1f2e2506-bfc5-49a8-8eb0-b33deaf2a957', 16, 1, 'CDM-29774', now(), 'CDM-29774', now(), false, NULL, NULL, NULL, '3173691', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
