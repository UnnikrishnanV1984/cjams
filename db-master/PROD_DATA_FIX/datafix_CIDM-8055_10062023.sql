-- CIDM-8055 - Email swap for user kristen
/*
-- Issue Description: 
   Email swap for user kristen
	Current working email is kristen.berkowich1@maryland.gov and new email is kristen.hahn@maryland.gov
	Swap the security user id from old account to new account
  
-- Category/ Module: User Profile
-- Root cause: User request 
-- Fix Provided: Datafix has been promoted to Swap the security user id from old account to new account
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

Steps to swap the security user id from old account to new account:
	1)	Create a new user profile in SailPoint with new email. 
	2)	Swap the security user id from old account to new account using this DML script (CIDM-8055).
	3)	Verify all 3 CJAMS applications are working as expected.
		a.	New ID should have all the same permissions and assignments.
		b.	Old Id should be disabled. 
	4)	Deactivate old account in SailPoint.
*/

-- To swap for user accounts (CIDM-8055)

-- Current: kristen.berkowich1@maryland.gov - 49ae215c-497c-4ce5-88a6-7b5c087001e7
-- New: kristen.hahn@maryland.gov - 869e7209-1087-4445-bade-526f7bcccd26

-- This update is for FK voilation
update userprofileaddress 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055-1',
		updatedon = now()
where userprofileaddressid = '4a983d4c-2706-4f12-87cc-ebf5d130bf58' ;

select securityusersid, 
	firstname, -- Kristen
	middlename, -- NULL
	lastname, -- Berkowich
	fullname, -- Kristen Berkowich
	email, -- kristen.berkowich1@maryland.gov
	updatedby, -- ADMIN
	updatedon  -- 2023-07-03 15:01:09.400
from userprofile 
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;	
	
update userprofile
set securityusersid = cjams.gen_random_uuid(),	
	activeflag = 0,
	otherfields = 'Old securityusersid : 49ae215c-497c-4ce5-88a6-7b5c087001e7', 
	updatedby = 'CIDM-8055',
	updatedon = now()
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;	

-- This update is for FK voilation
update userprofileaddress 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055'
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
							and up1.activeflag = 1 
						) ;
						
-- This update is for FK voilation	
update userprofilephonenumber 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055'
where securityusersid = ( select up1.securityusersid  
								from userprofile up1
							 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
								and up1.activeflag = 1 
							) ;
	
select securityusersid, 
	firstname, -- kristen
	middlename, -- NULL
	lastname, -- hahn
	fullname, -- kristen hahn
	email, -- kristen.hahn@maryland.gov
	updatedby, -- admin	
	updatedon  -- 2023-10-05 17:32:59.940
from userprofile 
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
							and up1.activeflag = 1 
						)	
	and activeflag = 1 ;
	
update userprofile
set securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7',
	updatedby = 'CIDM-8055',
	updatedon = now()
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
							and up1.activeflag = 1 
						)	
	and activeflag = 1 ;
	
-- This update to revert the FK voilation fix	
update userprofileaddress 
	set securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
							and up1.activeflag = 1 
						)
where securityusersid = '00000000-0000-0000-0000-000000000000'
	and updatedby = 'CIDM-8055';

-- This update to revert the FK voilation fix
update userprofilephonenumber 
	set securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
							and up1.activeflag = 1 
						)
where securityusersid = '00000000-0000-0000-0000-000000000000'
	and updatedby = 'CIDM-8055';
	
-- To update new email in muser table
select email, updatedby, updatedon 
	from muser 
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag  = 1 ;

update muser 
set email = ( select up1.email  
				from userprofile up1
			 where lower(up1.email) = lower('kristen.hahn@maryland.gov')
				and up1.activeflag = 1 
			),
	updatedby = 'CIDM-8055',
	updatedon = now()		
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag  = 1 ;
						
	
/*
select * from userprofile where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7' and activeflag = 1 ; 

INSERT INTO cjams.userprofile
	(securityusersid, firstname, lastname, displayname, fullname, activeflag, otherfields, onprobation, expirationdate, "timestamp", email, old_id, title, unavailableflag, userworkstatustypekey, voidedby, voidedon, voidreasonid, calendarkey, insertedby, insertedon, updatedby, updatedon, orgname, orgnumber, usertypekey, autonotification, userphoto, middlename, dob, gendertypekey, teamtypekey, cjamspid, usersignatureurl, name_suffix, primarycountyid, supervisorid, entrydate, exitdate, primarycountycd, primaryteamid, primarylocationid, secondarylocationid, jobtitlecd, unitsupervisorid, issupervisor, ssn, assupervisorid, cwlastlogindatetime, aslastlogindatetime, provlastlogindatetime)
VALUES
	('49ae215c-497c-4ce5-88a6-7b5c087001e7', 'Kristen', 'Berkowich', 'KristenBerkowich', 'Kristen Berkowich', 1, NULL, false, NULL, NULL, 'kristen.berkowich1@maryland.gov', 'kristenberkowich', NULL, false, NULL, NULL, NULL, NULL, NULL, 'admin', '2021-08-09 08:17:34.110', 'ADMIN', '2023-07-03 15:01:09.400', NULL, NULL, 'DSDS', false, NULL, NULL, NULL, NULL, 'CW', 200791987, NULL, NULL, NULL, '44f3b85d-8fcb-4db5-870e-820563ea85ed', NULL, NULL, '1434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '44f3b85d-8fcb-4db5-870e-820563ea85ed', '2023-10-05 09:44:30.660', '2023-09-22 11:15:34.008', NULL);


select * from userprofile where securityusersid = '869e7209-1087-4445-bade-526f7bcccd26' and activeflag = 1 ;

INSERT INTO cjams.userprofile
	(securityusersid, firstname, lastname, displayname, fullname, activeflag, otherfields, onprobation, expirationdate, "timestamp", email, old_id, title, unavailableflag, userworkstatustypekey, voidedby, voidedon, voidreasonid, calendarkey, insertedby, insertedon, updatedby, updatedon, orgname, orgnumber, usertypekey, autonotification, userphoto, middlename, dob, gendertypekey, teamtypekey, cjamspid, usersignatureurl, name_suffix, primarycountyid, supervisorid, entrydate, exitdate, primarycountycd, primaryteamid, primarylocationid, secondarylocationid, jobtitlecd, unitsupervisorid, issupervisor, ssn, assupervisorid, cwlastlogindatetime, aslastlogindatetime, provlastlogindatetime)
VALUES
	('869e7209-1087-4445-bade-526f7bcccd26', 'kristen', 'hahn', 'kristenhahn', 'kristen hahn', 1, NULL, false, NULL, NULL, 'kristen.hahn@maryland.gov', 'kristenhahn', NULL, false, NULL, NULL, NULL, NULL, NULL, 'admin', '2023-10-05 17:32:59.940', 'admin', '2023-10-05 17:32:59.940', NULL, NULL, 'DSDS', false, NULL, NULL, NULL, NULL, 'CW', 201973196, NULL, NULL, NULL, 'bcd0eec6-bb5e-4181-a07f-2abca7223434', NULL, NULL, '1434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
