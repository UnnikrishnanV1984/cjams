-- CDM-22504 Unnamed Maltreater still showing ( Bulk Case Assignment transfer from Marisa Lim to Joice Silva
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
-- Marisa Lim - 40d90111-ad67-494f-8a63-06f5990c9738 (marisa.lim@montgomerycountymd.gov) 
-- Team ID: 9f1d3b42-f3c6-4ed4-bbf3-93df85ff4bd0

-- Joice Silva - 22417e18-7b17-4bce-aa0a-e6c68eae7426 (joice.silva@montgomerycountymd.gov)
-- Team ID: 13c78e66-a0e4-4c7e-87ae-8cf17c1a5bd4
*/

-- Before (Marisa Lim)
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
	and ca.enddate is null
	and ca.responsibilitytypekey is null; -- to exculde Family Assigments


-- Transfer adoption cases to Joice Silva
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
		fromofficecode, '22417e18-7b17-4bce-aa0a-e6c68eae7426', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-22504', 'CDM-22504', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		now(), null, fromteamid, '13c78e66-a0e4-4c7e-87ae-8cf17c1a5bd4', remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		now(), isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
from caseassignment ca
where ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null 
	and ca.responsibilitytypekey is null; -- to exculde Family Assigments
		

-- Close Assignments on Marisa Lim's dashboard
update caseassignment ca
set ca.enddate = now(),
	ca.updatedby = 'CDM-22504', 
	ca.updatedon = now()
where ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null 
	and ca.responsibilitytypekey is null; -- to exculde Family Assigments

-- After (Marisa Lim)
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
	and ca.enddate is null 
	and ca.responsibilitytypekey is null; -- to exculde Family Assigments	

-- Joice Silva		
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
where ca.toworkeridno = '22417e18-7b17-4bce-aa0a-e6c68eae7426'
	and ca.activeflag = 1
	and ca.enddate is null 
	and ca.updatedby = 'CDM-22504' ;
