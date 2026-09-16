/*
   Issue Description: CDM-19156
   Category/ Module  : Bulk case transfer
   Root cause: user retiring and wants to trnasfer all cps cases
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select routingid, eventcode, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid::uuid =  'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and eventcode = 'APPL'
	and activeflag = 0  ;
  		
-- Close adoption cases on PAM's dashboard
update routing 
set tosecurityusersid = 'f29992db-931a-4770-b538-e3316f992715',
	updatedby = 'CDM-19156', 
	updatedon = now()
where tosecurityusersid::uuid =  'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and eventcode = 'APPL'
	and activeflag = 0 ;
	

select routingid, eventcode, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid::uuid =  'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and eventcode = 'APPL'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
-- Close adoption cases on Pam's dashboard
update routing 
set tosecurityusersid = 'f29992db-931a-4770-b538-e3316f992715',
	updatedby = 'CDM-19156', 
	updatedon = now()
where tosecurityusersid::uuid =  'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and eventcode = 'APPL'
	and activeflag = 1 
	and routingstatustypeid = 15 ;

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
		fromofficecode, 'f29992db-931a-4770-b538-e3316f992715', tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
		foldergroupindc, cmfldrgrpasgnkey, 'CDM-19156', 'CDM-19156', now(), 
		now(), objecttypekey, objectid, responsibilitytypekey, activeflag, 
		'2021-12-17 17:00:00', null, fromteamid, toteamid, remarks, 
		statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
		'2021-12-17 17:00:00', isrestricted, assigndescription, summary, isnew, 
		expungementflag, entityopendate, etl_userid, etl_load_date, servicetype
from caseassignment ca
where ca.toworkeridno = 'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and ca.activeflag = 1
	and ca.enddate is null ;

-- Close Assignments on Pam Martin's's dashboard
update caseassignment ca
set ca.enddate = '2021-12-17 17:00:00',
	ca.updatedby = 'CDM-19156', 
	ca.updatedon = now()
where ca.toworkeridno = 'dd5c1a15-0de3-4cf3-b283-914dc4198607'
	and ca.activeflag = 1
	and ca.enddate is null ;