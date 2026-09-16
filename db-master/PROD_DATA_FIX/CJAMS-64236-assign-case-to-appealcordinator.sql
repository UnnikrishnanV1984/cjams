/*
Issue: CJAMS-64236 Need case reopened - Circuit court date coming soon
Category/Module: User Profile
Root cause: 241021904778:Case has been closed incorrectly and there is still a pending court order. We need a data fix  open program assigments and assign the case to appeal co-ordinator
Fix provided:  Data fix has been done to make following changes for the case 241021904778
			   1) Remove the Findings Finalization Date and approval record.
			   2) Remove the CPS IR program assignment end date for below clients,
			   Client ID: 2805508 (NICHOLAS LEE MILLER),
			   Client ID: 202805720 (HEATHER MILLER),
		       Client ID: 202805800 (BRYANT THOMAS),
			   Client ID: 202805797 (CAYDEN THOMAS),
			   Client ID: 202805799 (GEMMA THOMAS)
			   3) Assign the CPS IR case with blank responsibility to the appeal coordinator (mallory.churchey1@maryland.gov)
Data/Code fix ticket#: CJAMS-64236
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Case was incorrectly ended and there is a pending court circuit date.
*/

-- Remove the Findings Finalization Date and approval record.

update Investigationallegationmaltreators 
set overrideapprflag = 0,  -- To make the finalization unapproved
	overridefindingtypekey = null,
	finalizeddate = null,
	overridecomments = null,
    updatedon = now(),
    updatedby = 'CJAMS-64236'
	where investigationallegationmaltreatorsid = 'b8bf23a0-d756-4df6-a32a-6accb9634204'
	and activeflag =1;

--Remove the CPS IR program assignment end date for all clients except the Alleged Victim

update personprogramarea
set enddate = null,
	updatedon = now(),
	updatedby = 'CJAMS-64236'
where objectid = 'c8866790-9dc5-413b-b578-f69c59ef068c'
and personid not in ('ff25382c-39da-450b-a38d-604c3a0fa264')
and activeflag =1;   


--Assigning case back to appeal co-ordinator



INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'fbd90a98-e840-4c32-8fd9-55f94384da21', NULL, NULL, '8b7692be-2fbc-49fd-9dce-78666f986886', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CJAMS-64236', 'CJAMS-64236', now(), now(), 'servicerequest', 'c8866790-9dc5-413b-b578-f69c59ef068c'::uuid, NULL, 1, now(), NULL, 'f332e898-8695-4e5e-8a9b-511b7b2fe015'::uuid, '2172e435-e328-4fe8-b187-29f37cbd8e78'::uuid, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'APPL', 'fbd90a98-e840-4c32-8fd9-55f94384da21', '8b7692be-2fbc-49fd-9dce-78666f986886', '2172e435-e328-4fe8-b187-29f37cbd8e78'::uuid, 'CWSP', 'CWSP', 'c8866790-9dc5-413b-b578-f69c59ef068c', 15, 1, 'CJAMS-64236', now(), 'CJAMS-64236', now(), true, '', NULL, 'Appeal Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
