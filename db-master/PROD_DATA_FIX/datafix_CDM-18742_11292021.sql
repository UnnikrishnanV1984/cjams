-- CDM-18742 - Bulk Case Assignment transfer from Barbara to Cromartie Marisa Lim
/*
-- Issue Description: 
   User request to transfer all cases listed on Barbara Cromartie's dashboard to Marisa Lim.
   Melinda is leaving Child Welfare and her last day is Friday Nov 5th. 
   
-- Category/ Module: CPS Case Assignments (User Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Montgomery County
-- Barbara Cromartie - d818ce27-b82f-4d82-b2f1-bbae18d078e1 (barbara.cromartie@montgomerycountymd.gov)
-- Team ID: 9f1d3b42-f3c6-4ed4-bbf3-93df85ff4bd0

-- Marisa Lim - 40d90111-ad67-494f-8a63-06f5990c9738 (marisa.lim@montgomerycountymd.gov) 
-- Team ID: 9f1d3b42-f3c6-4ed4-bbf3-93df85ff4bd0
*/

-- Before
select (select ins.servicerequestnumber 
			from intakeservicerequest ins
		where ins.intakeserviceid = ca.objectid
		) as servicerequestnumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = 'd818ce27-b82f-4d82-b2f1-bbae18d078e1'
	and ca.activeflag = 1
	and ca.enddate is null ;


-- Transfer adoption cases to Marisa Lim
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
SELECT gen_random_uuid(), gen_random_uuid(), eventdttmkey_fk, fromworkeridno, fromsupervisoridno, 
		fromofficecode, '40d90111-ad67-494f-8a63-06f5990c9738', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-18742', 'CDM-18742', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		'2021-11-03 17:00:00', null, fromteamid, toteamid, remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		'2021-11-03 17:00:00', isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
from caseassignment ca
where ca.toworkeridno = 'd818ce27-b82f-4d82-b2f1-bbae18d078e1'
	and ca.activeflag = 1
	and ca.enddate is null ;
		

-- Close Assignments on Barbara Cromartie's dashboard
update caseassignment ca
set ca.enddate = '2021-11-03 17:00:00',
	ca.updatedby = 'CDM-18742', 
	ca.updatedon = now()
where ca.toworkeridno = 'd818ce27-b82f-4d82-b2f1-bbae18d078e1'
	and ca.activeflag = 1
	and ca.enddate is null ;
	

-- For Case 20200202025101 End Date the Marisa Lim's Assignment as of 11/29/2021
-- CPS # 20200202025101 - acb586e1-81d2-46b1-893c-f7d722303e49	
select ca.caseassignmentid,
	ca.enddate,
	ca.updatedby, 
	ca.updatedon
from caseassignment ca
where ca.objectid = 'acb586e1-81d2-46b1-893c-f7d722303e49'
	and ca.enddate is null
	and ca.activeflag  = 1 ;
	
update caseassignment ca
set ca.enddate = '2021-11-29 11:30:00',
	ca.updatedby = 'CDM-18742', 
	ca.updatedon = now()
where ca.objectid = 'acb586e1-81d2-46b1-893c-f7d722303e49'
	and ca.enddate is null
	and ca.activeflag = 1 ;
	
-- After
select (select ins.servicerequestnumber 
			from intakeservicerequest ins
		where ins.intakeserviceid = ca.objectid
		) as servicerequestnumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = 'd818ce27-b82f-4d82-b2f1-bbae18d078e1'
	and ca.activeflag = 1
	and ca.enddate is null ;	
		
select (select ins.servicerequestnumber 
			from intakeservicerequest ins
		where ins.intakeserviceid = ca.objectid
		) as servicerequestnumber,	
		ca.caseassignmentid, 
		ca.objectid, 
		ca.responsibilitytypekey, 
		ca.startdate,
		ca.enddate,
		ca.updatedby, 
		ca.updatedon
from caseassignment ca
where ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null ;
