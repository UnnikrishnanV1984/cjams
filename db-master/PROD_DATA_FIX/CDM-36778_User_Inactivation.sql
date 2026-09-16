/*
   Issue Description: CDM-36778
   Category/ Module  : User Inactivation 
   Root cause: User inactivated in sail point still visible in approval inbox dropdowns.
   Fix: Data fix to inactivate the user tamra.canfield@maryland.gov (e12d7ff7-c158-45bd-8d59-b84e4485616d)
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select * from userprofile where securityusersid = 'e12d7ff7-c158-45bd-8d59-b84e4485616d';


UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-36778',
		updatedon = now()
	WHERE securityusersid = 'e12d7ff7-c158-45bd-8d59-b84e4485616d'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-36778',
		updatedon = now()
	WHERE securityusersid = 'e12d7ff7-c158-45bd-8d59-b84e4485616d'
		AND activeflag = 1;
	
UPDATE securityusers
	SET activeflag = 0,
		updatedby = 'CDM-36778',
		updatedon = now()
	WHERE securityusersid  = 'e12d7ff7-c158-45bd-8d59-b84e4485616d'
	AND activeflag = 1;
	
UPDATE rolemapping 
	SET activeflag = 0, updatedby = 'CDM-36778', updatedon = now()
	WHERE principalid = '4005' and activeflag = 1;	
	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36778',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid  = 'e12d7ff7-c158-45bd-8d59-b84e4485616d');
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36778',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid = 'e12d7ff7-c158-45bd-8d59-b84e4485616d');	
			