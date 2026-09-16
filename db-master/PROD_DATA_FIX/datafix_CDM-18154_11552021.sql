-- CDM-18154 - Moving Cases to another dashboard
/*
-- Issue Description: 
   User request to transfer adoption cases listed on Melinda's dashboard to Pamela Abramson.
   Melinda is leaving Child Welfare and her last day is Friday Nov 5th. 
   
-- Category/ Module: Adoption Case Assignments (User Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Montgomery County
-- Melinda Boodhoo - 93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7 
-- Team ID: c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1

-- Pamela Abramson - 390fe84f-bf06-4f80-9795-065f4d170df3 
-- Team ID: c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1

-- Assigned By: Michelle Forney a28308ae-8989-4f66-b47c-f26db59c1118
*/
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
where ca.toworkeridno = '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7'
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
		fromofficecode, '390fe84f-bf06-4f80-9795-065f4d170df3', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-18154', 'CDM-18154', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		'2021-11-05 17:00:00', null, fromteamid, toteamid, remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		'2021-11-05 17:00:00', isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
FROM cjams.caseassignment ca
where ca.toworkeridno = '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7'
	and ca.activeflag = 1
	and ca.enddate is null
	and ( select count(*)
				from adoptioncase ad
		 where ad.adoptioncaseid = ca.objectid
		) > 0  ;
		

-- Close adoption cases on Melinda's dashboard
update caseassignment ca
set ca.enddate = '2021-11-05 17:00:00',
	ca.updatedby = 'CDM-18154', 
	ca.updatedon = now()
where ca.toworkeridno = '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7'
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
where ca.toworkeridno = '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7'
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
where ca.toworkeridno = '390fe84f-bf06-4f80-9795-065f4d170df3'		
	and ca.updatedby = 'CDM-18154' ;

