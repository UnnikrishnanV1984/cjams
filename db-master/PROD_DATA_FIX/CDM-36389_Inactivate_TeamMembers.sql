/*
   Issue Description: CDM-36389
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select * from userprofile where securityusersid in ('e89d46e4-c475-459c-9ed4-f1519cfcb906', '0f965a3b-0deb-4f0b-bfe5-57a1de320cac');
-- e89d46e4-c475-459c-9ed4-f1519cfcb906 kari.somerville@maryland.gov 	activeflag is 0
-- 0f965a3b-0deb-4f0b-bfe5-57a1de320cac cali.filges@maryland.gov		activeflag is 0

UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36389',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('e89d46e4-c475-459c-9ed4-f1519cfcb906', '0f965a3b-0deb-4f0b-bfe5-57a1de320cac'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36389',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('e89d46e4-c475-459c-9ed4-f1519cfcb906', '0f965a3b-0deb-4f0b-bfe5-57a1de320cac'));	