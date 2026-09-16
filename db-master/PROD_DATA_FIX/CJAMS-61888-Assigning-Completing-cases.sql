/*
   Issue Description: assigning case to the appeal coordinator for
   CW2787065- Assigned from Shelley Sexton - Start date: Today's date - 09/11/2025
    Nigel Gross 231020705207- Assigned from Theresa Kleppinger - Start date: Today's date - 09/11/2025
    Nathan Stephens 241022093211- Assigned from Theresa Kleppinger - Start date: Today's date - 09/11/2025
    Simms Fuller 231020507063- Assigned from Heather Bosley - Start date: Today's date - 09/11/2025
   Category/ Module  : Assignments, Appeal coordinator dashboard
   Root cause: Previous appeal coordinator which was been assinged got deactivated.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

/*
select updatedby,* from caseassignment where objectid='98372bfd-d91c-41fb-8f30-6034660a51cd';
select updatedby,* from routing where objectid='98372bfd-d91c-41fb-8f30-6034660a51cd';
select teamid,countyid,countyname,* from v_userprofile where securityusersid ='8b7692be-2fbc-49fd-9dce-78666f986886';
*/

-- CW2787065
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), '98372bfd-d91c-41fb-8f30-6034660a51cd', NULL, '1287622e-f1a4-4875-accb-d46953efca5c', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CW2787065', NULL, NULL, 'CJAMS-61888', 'CJAMS-61888', now(), now(), 'servicerequest', '98372bfd-d91c-41fb-8f30-6034660a51cd'::uuid, NULL, 1, now(), NULL, 'a00579a8-139b-42ed-9c4d-662dd7cee47c'::uuid, '2172e435-e328-4fe8-b187-29f37cbd8e78'::uuid, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', '1287622e-f1a4-4875-accb-d46953efca5c', '8b7692be-2fbc-49fd-9dce-78666f986886', '2172e435-e328-4fe8-b187-29f37cbd8e78'::uuid, 'CWSP', 'CWSP', '98372bfd-d91c-41fb-8f30-6034660a51cd', 15, 1, 'CJAMS-61888', now(), 'CJAMS-61888', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--231020705207
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-61888', 'CJAMS-61888', now(), now(), 'servicerequest', '7f807c5f-4ee9-47b8-8370-c8f9ff0f7398'::uuid, NULL, 1, now(), NULL, '745ae733-3929-438f-adb9-6cbd40157bc1'::uuid, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--deactivating the previous deactivated APPEAL worker record.
update routing 
set activeflag =0,
	updatedby = 'CJAMS-61888',
	updatedon =now()
where routingid= '1f2e1e1f-f086-4149-80c7-c9dce0a3ac1f' and activeflag=1;

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', '8b7692be-2fbc-49fd-9dce-78666f986886', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'CWSP', 'CWAPPEALCO', '7f807c5f-4ee9-47b8-8370-c8f9ff0f7398', 15, 1, 'CJAMS-61888', now(), 'CJAMS-61888', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--241022093211 -- already has record of appeal worker assignment
update caseassignment
set enddate= null,
	updatedby = 'CJAMS-61888',
	updatedon = now()
where caseassignmentid = '7c58df63-2c06-4482-be8b-6147e7255614'
	and activeflag=1;

update routing
set activeflag = 1,
	updatedby = 'CJAMS-61888',
	updatedon =  now(),
	actiondatetime = null
where routingid = '1352e6d3-52bb-40ba-9622-186ec13f4f3e'
	and activeflag= 0;


--231020507063
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, '0d221a83-4a79-47b0-9e9a-ec7dccaa8844', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-61888', 'CJAMS-61888', now(), now(), 'servicerequest', 'f0987766-ecf8-4743-9e61-5ce91ecb534d'::uuid, NULL, 1, now(), NULL, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--select * from routing where objectid = 'f0987766-ecf8-4743-9e61-5ce91ecb534d';
-- Deactivate user routing status 

update routing 
set activeflag =0,
	updatedby = 'CJAMS-61888',
	updatedon =now()
where routingid= 'e4c96067-e0a4-4859-ab9b-29a8f9ebc064' and activeflag=1;

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', '0d221a83-4a79-47b0-9e9a-ec7dccaa8844', '8b7692be-2fbc-49fd-9dce-78666f986886', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'CWSP', 'CWAPPEALCO', 'f0987766-ecf8-4743-9e61-5ce91ecb534d', 15, 1, 'CJAMS-61888', now(), 'CJAMS-61888', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);