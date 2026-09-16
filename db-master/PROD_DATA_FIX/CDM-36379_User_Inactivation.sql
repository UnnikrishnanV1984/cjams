/*
   Issue Description: CDM-36379
   Category/ Module  : WorkLoad 
   Root cause: Old Staff still shown on Workload list.
   Fix: Data fix to inactivate the team member records
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select * from userprofile where securityusersid in ('0d221a83-4a79-47b0-9e9a-ec7dccaa8844', '35e29d33-2aed-4079-acfb-3a616699cec1');
-- Kristi Alexander (35e29d33-2aed-4079-acfb-3a616699cec1) activeflag -- 0
-- Heather Bosley (0d221a83-4a79-47b0-9e9a-ec7dccaa8844) activeflag -- 1

UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-36379',
		updatedon = now()
	WHERE securityusersid = '0d221a83-4a79-47b0-9e9a-ec7dccaa8844'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-36379',
		updatedon = now()
	WHERE securityusersid = '0d221a83-4a79-47b0-9e9a-ec7dccaa8844'
		AND activeflag = 1;
	
UPDATE securityusers
	SET activeflag = 0,
		updatedby = 'CDM-36379',
		updatedon = now()
	WHERE securityusersid IN ('0d221a83-4a79-47b0-9e9a-ec7dccaa8844', '35e29d33-2aed-4079-acfb-3a616699cec1')
	AND activeflag = 1;
	
UPDATE rolemapping 
	SET activeflag = 0, updatedby = 'CDM-36379', updatedon = now()
	WHERE principalid IN  ('4070', '4096') and activeflag = 1;	
	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-36379',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('0d221a83-4a79-47b0-9e9a-ec7dccaa8844', '35e29d33-2aed-4079-acfb-3a616699cec1'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-36379',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('0d221a83-4a79-47b0-9e9a-ec7dccaa8844', '35e29d33-2aed-4079-acfb-3a616699cec1'));	
			
			
			