/*
   Issue Description: CDM-28186
   Category/ Module  :Add expungment button
   Root cause:CW2752527:The expungement button is not working. I need to be able to remove the maltreator's name and replace it with unknown due to a Settlement Agreement. I was able to do this is previous cases. This is a priority issue
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/



update intakeservicerequestdispositioncode set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-28186', updatedon = now() where intakeservicerequestdispositioncodeid = '4febf43f-3f7e-4658-91f7-e458e1f520f4';


INSERT INTO cjams.caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey
, activeflag, startdate, enddate, fromteamid, toteamid, fromldssid, toldssid, statustypekey, assignmenttype, assigndate)
VALUES('586909e6-04f0-4ca8-8434-0a046fbbbad8', 'dffeeac8-06ad-4124-8f8d-8660da1c6262', 'CDM-28186', 'CDM-28186'
, now(),now() , 'servicerequest', '2ff37fd7-aa11-42a4-9c43-cf4d30f7d22e', 'family'
, 1, current_date,null , '0ffb41d9-8397-49f5-9ad8-aba15e52e96b', '0ffb41d9-8397-49f5-9ad8-aba15e52e96b', '34457960-811a-4d35-a416-b8941d6974cc', '34457960-811a-4d35-a416-b8941d6974cc', 'Open', 'W', current_Date);


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'APPL', 'a2b0fb1f-2ffa-4209-b2d3-82584d914cc2', 'dffeeac8-06ad-4124-8f8d-8660da1c6262',
'abb1f2db-e34f-4e98-92c1-99e9749f2239', 'CWSP', 'CWAPPEALCO', '2ff37fd7-aa11-42a4-9c43-cf4d30f7d22e', 15, 1,
'CDM-28186', now(),'CDM-28186',now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, now(), NULL, NULL, NULL, NULL);