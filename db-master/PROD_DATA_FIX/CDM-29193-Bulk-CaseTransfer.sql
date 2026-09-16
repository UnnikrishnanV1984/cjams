-- CDM-29193 - Transfer Cases
/*
-- Issue Description: 
   User request to transfer all Service cases listed on Anna Jung to Michelle Forney
   
-- Category/ Module: Servicase Transfer (User Management) 
-- Root cause: N/A
-- Pull request# 8228
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Montgomery County
-- From
-- Anna Jung - cd0791b5-b0cd-48c4-9f30-76232793d084

-- To
-- Michelle Forney: a28308ae-8989-4f66-b47c-f26db59c1118
select (select servicecaseid
			from servicecase ad
		where ad.servicecaseid = ca.objectid
		) as servicecasenumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = 'cd0791b5-b0cd-48c4-9f30-76232793d084'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from servicecase ad
		 where ad.servicecaseid = ca.objectid
		) > 0;
		
-- Transfer service cases to Michelle Forney
		
INSERT INTO cjams.caseassignment
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
SELECT gen_random_uuid(), gen_random_uuid(), eventdttmkey_fk, 'cd0791b5-b0cd-48c4-9f30-76232793d084', fromsupervisoridno, 
		fromofficecode, 'a28308ae-8989-4f66-b47c-f26db59c1118', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-29193', 'CDM-29193', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		now(), null, 'cef6965a-8582-4db0-aa99-20cb02e6053c', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1', remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		now(), isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
FROM cjams.caseassignment ca
where ca.toworkeridno = 'cd0791b5-b0cd-48c4-9f30-76232793d084'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from servicecase ad
		 where ad.servicecaseid = ca.objectid
		) > 0  ;
		

-- Close servicecase cases on Anna Jung
update caseassignment 
set enddate = now(),
	updatedby = 'CDM-29193', 
	updatedon = now()
where toworkeridno = 'cd0791b5-b0cd-48c4-9f30-76232793d084'
	and activeflag = 1
	and enddate is null
	and ( select count(*)
				from servicecase ad
		 where ad.servicecaseid = objectid
		) > 0 ;
		