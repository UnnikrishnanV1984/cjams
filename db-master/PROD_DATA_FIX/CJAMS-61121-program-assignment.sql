/*
Issue Description: Case assigned to the user are not available on the appeal worker dashboard (cases are listed in the next comment). Need technical analysis on why the cases are not available in the user dashboard and need fix for the same.
Category/ Module : Bug
Root cause: The appeal coordinator Jennifer Kephart who got assigned to the case got deactivated
so user reqeusted to 202101040101295 case to appeal coordinator Mallory Churchey. 
Fix provided :yes, write Db query and provided analysis
Code fix ticket#: Enhancement userstory is under draft.
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', '0cd5f654-875f-4648-8bcc-f43164dbb6da', '8b7692be-2fbc-49fd-9dce-78666f986886', '1bf3e463-8c28-44cc-840f-8c5e43a6dd7b'::uuid, 'CWSP', 'CWSP', '52b47e70-7c30-419a-a12d-752c3aaa0ee2', 15, 1, 'CJMAS-61121', '2025-05-05 16:07:10.998', 'CJMAS-61121', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- not needed as it has been taken care as a part of bulk fix CJAMS-61167
--INSERT INTO cjams.caseassignment
--(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
--VALUES(gen_random_uuid(), gen_random_uuid(), NULL, '0cd5f654-875f-4648-8bcc-f43164dbb6da', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, '2021-06-10 09:38:10.100', '2021-06-10 09:38:10.100', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61121', 'CJAMS-61121', '2025-05-05 16:07:10.998', '2025-05-05 16:07:10.998', 'servicerequest', '52b47e70-7c30-419a-a12d-752c3aaa0ee2'::uuid, NULL, 1, '2025-05-05 16:07:10.998', NULL, '38cdcc5e-4997-4b19-ab41-2ba349d39bb8'::uuid, '38cdcc5e-4997-4b19-ab41-2ba349d39bb8'::uuid, NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e'::uuid, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e'::uuid, 'W', NULL, '2025-05-05 16:07:10.998', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
update caseassignment
set toworkeridno ='8b7692be-2fbc-49fd-9dce-78666f986886',updatedby ='CJAMS-61121',updatedon=now()
where 
objectid  = '52b47e70-7c30-419a-a12d-752c3aaa0ee2' and caseassignmentid = '407f42fa-571f-4753-8542-89046f8448a6'
and activeflag = 1;