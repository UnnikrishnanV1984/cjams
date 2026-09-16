/*
Issue: CJAMS-64770 Unable to Assign Appeal - IR 2021082094234
Category/Module: Case assignment
Root cause: CPS-IR : 2021082094234 was closed on 05/07/2021 and approved by Adrianne Saba. The respective supervisor is no longer working with the agency so the CPS IR will not be available under the Completed case to be assigned to the Appeal coordinator.
            Data fix needed to assign the CPS-IR : 2021082094234 to the mentioned appeal coordinator (Jeanne Baxter)
Fix provided:  Data fix has been done to assign CPS-IR : 2021082094234 to the mentioned appeal coordinator (Jeanne Baxter)
Data/Code fix ticket#: No
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Supervisor is no longer available and data fix needed.
*/


INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'f54a55fd-9720-443e-a3a0-ff8ebbdb2841', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-64770', 'CJAMS-64770', now(), now(), 'servicerequest', '1e34ee96-37dc-4ed1-a324-e179f5c4426b'::uuid, NULL, 1, now(), NULL, 'de12a5e3-d28e-4618-ad95-1b739145fc97'::uuid, '2172e435-e328-4fe8-b187-29f37cbd8e78'::uuid, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, '13235932-5e81-4427-a9d0-affbc6001410'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', 'f54a55fd-9720-443e-a3a0-ff8ebbdb2841', '22f78177-19c0-4bb2-a921-c133de3590cd', '13235932-5e81-4427-a9d0-affbc6001410'::uuid, 'CWSP', 'CWSP', '1e34ee96-37dc-4ed1-a324-e179f5c4426b', 15, 1, 'CJAMS-64770', now(), 'CJAMS-64770', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
