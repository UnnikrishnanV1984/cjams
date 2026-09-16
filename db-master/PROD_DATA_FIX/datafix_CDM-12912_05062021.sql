-- CDM-12912 - Removal episode still open on a closed case
/*
-- Issue Description: 
   Closed Service Case with active Removal.
   Datafix to re-open the Service Case so that user can close the removal.
   
   Case ID: 3168600 - 58e3b3ac-1dba-4924-ae44-e9abdfd08735
   Client ID: 3712178 (KILEIAN G COLLINS) - 27389a24-9f39-4729-a953-4b40b3a7459c
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, case was closed prior to Removal Closure (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Re-open the Service case
select enddate, statustypekey, dispositioncode, updatedon, updatedby
	from servicecase
where servicecaseid = '58e3b3ac-1dba-4924-ae44-e9abdfd08735';

update servicecase 
set enddate = null, 
	statustypekey = 'pending', 
	dispositioncode = 'open', 
	updatedon = now(), 
	updatedby = 'CDM-12912'
where servicecaseid = '58e3b3ac-1dba-4924-ae44-e9abdfd08735';

Insert into cjams.servicecasedisposition
(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, 
	dispositioncode, "comments", effectivedate, activeflag, 
	insertedby, insertedon, updatedby, updatedon, expirationdate, 
	old_id, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), '58e3b3ac-1dba-4924-ae44-e9abdfd08735', now(), 'Reopen', 
	'Inprogress', 'Reopening Closed Case to Exit an Active Removal', now(), 1, 
	'CDM-12912', now(), 'CDM-12912', now(), NULL, 
	'3168600', null, null
);

Insert into cjams.caseassignment
(	caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, 
	fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, 
	effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
	foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, 
	updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, 
	startdate, enddate, fromteamid, toteamid, remarks, 
	statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
	assigndate, isrestricted, assigndescription, summary, isnew, 
	expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
)
values
( 	gen_random_uuid(), '58e3b3ac-1dba-4924-ae44-e9abdfd08735', NULL, 'da23f52d-6348-413b-9e37-0de2ab823825', '440', 
	NULL, 'da23f52d-6348-413b-9e37-0de2ab823825', '440', NULL, NULL, 
	NULL, NULL, NULL, NULL, '3168600', 
	NULL, NULL, 'CDM-12912', 'CDM-12912', now(), 
	now(), 'servicecase', '58e3b3ac-1dba-4924-ae44-e9abdfd08735', 'family', 1, 
	now(), NULL, 'd196fdff-ae65-418e-96c4-f5df54ab6e33', 'd196fdff-ae65-418e-96c4-f5df54ab6e33', NULL, 
	NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a', 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a', 'W', '5449130', 
	NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL
);
