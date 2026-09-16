/*
   Issue Description: CDM-37567
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

	
select * from userprofile where displayname ='Anita Wilkins'; -- 91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e

select * from userprofile where displayname ='Carol Allison'; -- d4a85d02-ca14-409c-9969-2548700e4825

UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-37567',
		updatedon = now()
	WHERE securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825') 
		AND activeflag = 1;
		
select * from muser WHERE securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825') 
		AND activeflag = 1; 	
		
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-37567',
		updatedon = now()
	WHERE securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825') 
		AND activeflag = 1;
	
select * from rolemapping	WHERE principalid IN (select id::character varying 
							from muser 
							where securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;			
		
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'CDM-37567', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser
							where securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;	

select * from teammember WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
				where up.securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;
	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-37567',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
				where up.securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;

	select * from teammemberassignment
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
				where up.securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;	
		
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-37567',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
				where up.securityusersid in ('91fa16c5-ff1b-45ba-8aae-7a77e7c1ad0e', 'd4a85d02-ca14-409c-9969-2548700e4825'))
		and activeflag = 1;	