/*
   Issue Description: CDM-37057
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select displayname, email, securityusersid, activeflag 
	from userprofile 
	where securityusersid in ('c8ea99a7-11d3-4816-b8bf-2f7678e8bf9f', 'ea686e02-6035-4201-9f80-4ab2fd0ce803');
--NiketaMyers	niketa.myers@maryland.gov	(ea686e02-6035-4201-9f80-4ab2fd0ce803) activeflag -- 0
--LeilaJoy		leila.joy2@maryland.gov		(c8ea99a7-11d3-4816-b8bf-2f7678e8bf9f) activeflag -- 1

UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-37057',
		updatedon = now()
	WHERE securityusersid = 'c8ea99a7-11d3-4816-b8bf-2f7678e8bf9f'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-37057',
		updatedon = now()
	WHERE securityusersid = 'c8ea99a7-11d3-4816-b8bf-2f7678e8bf9f'
		AND activeflag = 1;


-- Bulk update to inactivate all rolemapping records for inactive users	
-- Total records impacted 8511	
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'deactivateuser', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser 
							where activeflag = 0) 
		and activeflag = 1;	

-- Bulk update to inactivate all teammember records for all inactive users	
-- Total records impacted 7457	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'deactivateuser',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.activeflag = 0)
		and activeflag = 1;

-- Bulk update to inactivate all teammemberassignment records for all inactive users	
-- Total Records impacted 7378			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'deactivateuser',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.activeflag = 0)
		and activeflag = 1;
