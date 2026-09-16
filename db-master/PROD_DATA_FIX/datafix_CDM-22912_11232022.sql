-- CDM-22912 - End Date Not Populating
/*
-- Issue Description: 
   User request to transfer all Family Assignments cases from Marisa Lim's dashboard to Joice Silva.
  
-- Category/ Module: CPS Appeal coordinator Case Assignments (User Management) 
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

-- To transfer all Family Assignments cases from Marisa Lim's dashboard to Joice Silva
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
where ca.objecttypekey  = 'servicerequest'
	and ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null ;
	-- and ca.responsibilitytypekey is null -- to exculde Family Assigments

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
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-22912', 'CDM-22912', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		now(), null, fromteamid, '13c78e66-a0e4-4c7e-87ae-8cf17c1a5bd4', remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		now(), isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
from caseassignment ca
where ca.objecttypekey  = 'servicerequest'
	and ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null ;
--	and ca.responsibilitytypekey is null; -- to exculde Family Assigments
	
-- Close Assignments on Marisa Lim's dashboard
update caseassignment ca
set enddate = now(),
	updatedby = 'CDM-22912', 
	updatedon = now()
where ca.objecttypekey  = 'servicerequest'
	and ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null ;
--	and ca.responsibilitytypekey is null; -- to exculde Family Assigments

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
where ca.objecttypekey  = 'servicerequest'
	and ca.toworkeridno = '40d90111-ad67-494f-8a63-06f5990c9738'
	and ca.activeflag = 1
	and ca.enddate is null ;
--	and ca.responsibilitytypekey is null; -- to exculde Family Assigments	

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
	and ca.updatedby = 'CDM-22912' ;

-- To end date the assignments of Complted Appeal Cases

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
where ca.objecttypekey  = 'servicerequest'
	and ca.activeflag  = 1
	and ca.enddate is null
	and ca.toworkeridno 
		in ( '40d90111-ad67-494f-8a63-06f5990c9738', '22417e18-7b17-4bce-aa0a-e6c68eae7426' )
	and ca.objectid 	
		in ( select intakeserviceid 
				from intakeservicerequest
			 where intakeserviceid  
				in ( select objectid 
						from caseassignment c
					 where activeflag  = 1
						and enddate is null
						and objecttypekey  = 'servicerequest'
						-- Marisa Lim or Joice Silva	
						and toworkeridno in ( '40d90111-ad67-494f-8a63-06f5990c9738', '22417e18-7b17-4bce-aa0a-e6c68eae7426' )
						and objectid::character varying 
							in (  select r.objectid::character varying 
									from routing r
								  where r.eventcode = 'APPL'
									-- joice.silva@montgomerycountymd.gov
									and r.tosecurityusersid  = '22417e18-7b17-4bce-aa0a-e6c68eae7426' 
									and r.activeflag = 0
									and (select count(*) 
											from routing r1
										  where r1.objectid = r.objectid 
											and r1.eventcode = 'APPL'
											and r1.activeflag = 1
										) = 0
								)
					)
			) ;
  
  
update caseassignment ca1
set enddate = now(),
	updatedby = 'CDM-22912', 
	updatedon = now()
where ca1.caseassignmentid 
	in  
		(select ca.caseassignmentid
		from caseassignment ca 
		where ca.objecttypekey  = 'servicerequest'
			and ca.activeflag  = 1
			and ca.enddate is null
			and ca.toworkeridno 
				in ( '40d90111-ad67-494f-8a63-06f5990c9738', '22417e18-7b17-4bce-aa0a-e6c68eae7426' )
			and ca.objectid 	
				in ( select intakeserviceid 
						from intakeservicerequest
					 where intakeserviceid  
						in ( select objectid 
								from caseassignment c
							 where activeflag  = 1
								and enddate is null
								and objecttypekey  = 'servicerequest'
								-- Marisa Lim or Joice Silva	
								and toworkeridno in ( '40d90111-ad67-494f-8a63-06f5990c9738', '22417e18-7b17-4bce-aa0a-e6c68eae7426' )
								and objectid::character varying 
									in (  select r.objectid::character varying 
											from routing r
										  where r.eventcode = 'APPL'
											-- joice.silva@montgomerycountymd.gov
											and r.tosecurityusersid  = '22417e18-7b17-4bce-aa0a-e6c68eae7426' 
											and r.activeflag = 0
											and (select count(*) 
													from routing r1
												  where r1.objectid = r.objectid 
													and r1.eventcode = 'APPL'
													and r1.activeflag = 1
												) = 0
										)
							)
					) 
		);	
