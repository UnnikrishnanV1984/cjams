/*
   Issue Description: CDM-37050
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select displayname, email, securityusersid, activeflag 
	from userprofile 
	where securityusersid in ('37254531-a607-418b-a162-4362d92f5908');
--AmandaSwyter	amanda.swyter@maryland.gov	37254531-a607-418b-a162-4362d92f5908	activeflag 1

UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-37050',
		updatedon = now()
	WHERE securityusersid = '37254531-a607-418b-a162-4362d92f5908'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-37050',
		updatedon = now()
	WHERE securityusersid = '37254531-a607-418b-a162-4362d92f5908'
		AND activeflag = 1;
		
		
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'CDM-37050', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser 
							where securityusersid = '37254531-a607-418b-a162-4362d92f5908') 
		and activeflag = 1;	


UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-37050',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid = '37254531-a607-418b-a162-4362d92f5908')
		and activeflag = 1;

		
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-37050',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid = '37254531-a607-418b-a162-4362d92f5908')
		and activeflag = 1;		

