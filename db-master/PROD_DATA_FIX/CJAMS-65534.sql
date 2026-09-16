/*
CJAMS-65534
Issue Description: 
Remove the Director approval role (DHS_CJAMS_CW_SERVICELOG_APPT_GT_1K,) for Deborah Walsh (deborah.walsh@maryland.gov)
Re-route all pending payment approval and others under Deborah Walsh to Melinda Baldwin
Category/Module: User Profile
Root cause: Deborah Walsh was no  more with the agency and user requested to remove her permisssions 
Fix provided: DB query to deactivate AM flag from the case
Data/Code fix ticket#:CJAMS-65534
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue
Status of the code fix if already submitted and expected prod fix date: 
Backup before update/ delete:Query:
*/


update userresource
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65534'
	where userresourceid = 'f0719dd4-7443-4b9f-aa1e-4528de6fa80a'
		and activeflag = 1;
	
update routing	
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65534'
	where routingid in ('63b8b793-7334-45d6-9495-7f896c9be033',
				'326f1e8d-8fa0-4c4d-9b3c-ff336c7e60fd')
		and activeflag = 1;
				
update caseassignment	
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65534'
	where caseassignmentid in ('36fa2739-b05b-4e8c-bdfa-f7954150fa90')
		and activeflag = 1;
						
update caseassignment	
	set enddate = now(),
		updatedon = now(),
		updatedby = 'CJAMS-65534'
	where caseassignmentid in ('6fcea78c-9fa2-4b4a-96f7-e0c6afb19d68',
						'1f496ec1-b8ce-47dc-93c1-107a8ac72d84');
						
INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES('f4d5aaf9-93f8-4604-a8be-3c488677beed', NULL, '6f9d10f6-2055-4ffb-8667-1b8b84b11ec2', NULL, NULL, '6f9d10f6-2055-4ffb-8667-1b8b84b11ec2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3276834', NULL, NULL, 'CJAMS-65534', 'CJAMS-65534', now(), now(), 'servicecase', 'f4d5aaf9-93f8-4604-a8be-3c488677beed', 'administrative', 1, now(), NULL, '263e4d5d-cf6c-4e7d-8c35-394a62e46028', '263e4d5d-cf6c-4e7d-8c35-394a62e46028', NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc', 'b0ca6422-8241-4d86-bfef-51c7225de2fc', 'W', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES('365e1062-43d3-487e-bd63-455398215b49', NULL, '6f9d10f6-2055-4ffb-8667-1b8b84b11ec2', NULL, NULL, '6f9d10f6-2055-4ffb-8667-1b8b84b11ec2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3031084', NULL, NULL, 'CJAMS-65534', 'CJAMS-65534', now(), now(), 'servicecase', '365e1062-43d3-487e-bd63-455398215b49', 'administrative', 1, now(), NULL, '263e4d5d-cf6c-4e7d-8c35-394a62e46028', '263e4d5d-cf6c-4e7d-8c35-394a62e46028', NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc', 'b0ca6422-8241-4d86-bfef-51c7225de2fc', 'W', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
