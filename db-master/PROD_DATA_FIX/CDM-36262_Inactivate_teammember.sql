/*
   Issue Description: CDM-36262
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select * from userprofile where securityusersid in ('41daeea1-38ec-469e-89a3-ea1a498146a7', '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3');
--41daeea1-38ec-469e-89a3-ea1a498146a7  Kathleen Healy -- activeflag 0
--7a6633ab-dfc5-4d90-977c-d1127a0d9ee3 Philip Marini	-- activeflag 1


UPDATE userprofile
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36262'
	WHERE securityusersid = '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3'
		AND activeflag = 1;
		
UPDATE muser
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36262'
	WHERE securityusersid = '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3'
		AND activeflag = 1;

UPDATE securityusers
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36262'
	WHERE securityusersid = '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3'
		AND activeflag = 1;	

UPDATE rolemapping 
	set activeflag = 0,		
		updatedon = now(),
		updatedby = 'CDM-36262'
	WHERE principalid = '14899'
	 AND activeflag = 1;	
	 
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36262',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('41daeea1-38ec-469e-89a3-ea1a498146a7', '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36262',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('41daeea1-38ec-469e-89a3-ea1a498146a7', '7a6633ab-dfc5-4d90-977c-d1127a0d9ee3'));	