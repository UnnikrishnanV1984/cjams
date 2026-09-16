/*
   Issue Description: assigning case to the appeal coordinator for
   CJAMS-64235 Transfer for completion    
   Category/ Module  : Case assignment
   Root cause: User requested to assign both cases to the respective appeal coordinator (mallory.churchey1@maryland.gov) with blank responsibility.
                      CPS IR # 241021912216 was closed on 04/05/2024 and approved by Jessica Murray-Savage
                      CPS IR # 241021910537 was closed on 04/04/2024 and approved by Lisa Naumann
   Fix provided:Data fix needed to assign both cases to appeal coordinator mallory.churchey1@maryland.gov  
   Data/Code fix ticket#: CJAMS-64235
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User requested for a data fix.
*/

/*
select updatedby,* from caseassignment where objectid='98372bfd-d91c-41fb-8f30-6034660a51cd';
select updatedby,* from routing where objectid='98372bfd-d91c-41fb-8f30-6034660a51cd';
select teamid,countyid,countyname,* from v_userprofile where securityusersid ='8b7692be-2fbc-49fd-9dce-78666f986886';
*/


 --  CPS IR # 241021912216


 INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'da23f52d-6348-413b-9e37-0de2ab823825', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-64235', 'CJAMS-64235', now(), now(), 'servicerequest', '10f96242-610f-48fb-b5a7-8cec012bb8bb'::uuid, NULL, 1, now(), NULL, '745ae733-3929-438f-adb9-6cbd40157bc1'::uuid, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', 'da23f52d-6348-413b-9e37-0de2ab823825', '8b7692be-2fbc-49fd-9dce-78666f986886', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'CWSP', 'CWSP', '10f96242-610f-48fb-b5a7-8cec012bb8bb', 15, 1, 'CJAMS-64235', now(), 'CJAMS-64235', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- CPS IR # 241021910537 was closed on 04/04/2024 and approved by Lisa Naumann

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, '780b2012-4a49-4e6d-9471-d1b2e4026c75', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-64235', 'CJAMS-64235', now(), now(), 'servicerequest', 'c619fb08-1752-4667-9c21-412a27146875'::uuid, NULL, 1, now(), NULL, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', '780b2012-4a49-4e6d-9471-d1b2e4026c75', '8b7692be-2fbc-49fd-9dce-78666f986886', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'CWSP', 'CWSP', 'c619fb08-1752-4667-9c21-412a27146875', 15, 1, 'CJAMS-64235', now(), 'CJAMS-64235', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
