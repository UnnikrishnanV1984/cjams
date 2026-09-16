-- CDM-22241 - Transfer Cases
/*
-- Issue Description: 
   User request to transfer all Adoption cases listed on Pamela Abramson's dashboard to Sara Blanco.
   
-- Category/ Module: Adoption Case Assignments (User Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Montgomery County
-- From
-- Pamela Abramson - 390fe84f-bf06-4f80-9795-065f4d170df3 
-- Team ID: c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1

-- To
-- Sara Blanco - 435fbe97-d6a6-4ca9-854b-c4332b48137d 
-- Team ID: c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1

-- Assigned By: Michelle Forney a28308ae-8989-4f66-b47c-f26db59c1118

-- Before
select (select ad.adoptioncasenumber 
			from adoptioncase ad
		where ad.adoptioncaseid = ca.objectid
		) as adoptioncasenumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = '390fe84f-bf06-4f80-9795-065f4d170df3'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from adoptioncase ad
		 where ad.adoptioncaseid = ca.objectid
		) > 0  ;


-- Transfer adoption cases to Pamela Abramson. 
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
SELECT gen_random_uuid(), gen_random_uuid(), eventdttmkey_fk, 'a28308ae-8989-4f66-b47c-f26db59c1118', fromsupervisoridno, 
		fromofficecode, '435fbe97-d6a6-4ca9-854b-c4332b48137d', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-22241', 'CDM-22241', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		now(), null, fromteamid, toteamid, remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		now(), isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
FROM cjams.caseassignment ca
where ca.toworkeridno = '390fe84f-bf06-4f80-9795-065f4d170df3'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from adoptioncase ad
		 where ad.adoptioncaseid = ca.objectid
		) > 0  ;
		

-- Close adoption cases on Melinda's dashboard
update caseassignment ca
set ca.enddate = now(),
	ca.updatedby = 'CDM-22241', 
	ca.updatedon = now()
where ca.toworkeridno = '390fe84f-bf06-4f80-9795-065f4d170df3'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from adoptioncase ad
		 where ad.adoptioncaseid = ca.objectid
		) > 0 ;
		
-- After
select (select ad.adoptioncasenumber 
			from adoptioncase ad
		where ad.adoptioncaseid = ca.objectid
		) as adoptioncasenumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = '390fe84f-bf06-4f80-9795-065f4d170df3'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from adoptioncase ad
		 where ad.adoptioncaseid = ca.objectid
		) > 0  ;		
		
		
select (select ad.adoptioncasenumber 
			from adoptioncase ad
		where ad.adoptioncaseid = ca.objectid
		) as adoptioncasenumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = '435fbe97-d6a6-4ca9-854b-c4332b48137d'		
	and ca.updatedby = 'CDM-22241' ;

