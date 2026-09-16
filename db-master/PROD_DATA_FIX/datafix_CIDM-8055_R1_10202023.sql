-- CIDM-8055 - Email swap for user kristen
/*
-- Issue Description: 
   Email swap for user kristen
	Current working email is kristen.hahn@maryland.gov and new email is kristen.hahn1@maryland.gov
	Swap the security user id from old account to new account
  
-- Category/ Module: User Profile
-- Root cause: User request 
-- Fix Provided: Datafix has been promoted to Swap the security user id from old account to new account
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

Steps to swap the security user id from old account to new account:
	1)	Create a new user profile in SailPoint with new email. 
	2)	Swap the security user id from old account to new account using this DML script (CIDM-8055_R1).
	3)	Verify all 3 CJAMS applications are working as expected.
		a.	New ID should have all the same permissions and assignments.
		b.	Old Id should be disabled. 
	4)	Deactivate old account in SailPoint.
*/

-- To swap for user accounts (CIDM-8055_R1)

-- Current: kristen.hahn@maryland.gov - 49ae215c-497c-4ce5-88a6-7b5c087001e7
-- New: kristen.hahn1@maryland.gov - ac4c9da8-bbbc-41b1-954e-970460bce322

-- This update is for FK voilation
update userprofileaddress 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055-2',
		updatedon = now()
where userprofileaddressid = '6abff4fa-aefc-4487-8188-c075f51efe0d' ;

update userprofilephonenumber 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055_2',
		updatedon = now()
where userprofilephonenumberid = '60ef6ec5-200e-4075-b596-4368553f5851' ;
							
select securityusersid, 
	firstname, -- Kristen
	middlename, -- NULL
	lastname, -- Hahn
	fullname, -- Kristen Hahn
	email, -- kristen.hahn@maryland.gov
	updatedby, -- ADMIN
	updatedon  -- 2023-10-11 14:34:48
from userprofile 
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;	
	
update userprofile
set securityusersid = cjams.gen_random_uuid(),	
	activeflag = 0,
	otherfields = 'Old securityusersid : 49ae215c-497c-4ce5-88a6-7b5c087001e7', 
	updatedby = 'CIDM-8055_R1',
	updatedon = now()
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;	

-- This update is for FK voilation
update userprofileaddress 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055_R1'
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
							and up1.activeflag = 1 
						) ;
						
-- This update is for FK voilation	
update userprofilephonenumber 
	set securityusersid = '00000000-0000-0000-0000-000000000000',
		updatedby = 'CIDM-8055_R1'
where securityusersid = ( select up1.securityusersid  
								from userprofile up1
							 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
								and up1.activeflag = 1 
							) ;
	
select securityusersid, 
	firstname, -- Kristen
	middlename, -- NULL
	lastname, -- hahn
	fullname, -- Kristen hahn
	email, -- kristen.hahn1@maryland.gov
	updatedby, -- admin	
	updatedon  -- 2023-10-20 12:04:09
from userprofile 
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
							and up1.activeflag = 1 
						)	
	and activeflag = 1 ;
	
update userprofile
set securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7',
	updatedby = 'CIDM-8055_R1',
	updatedon = now()
where securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
							and up1.activeflag = 1 
						)	
	and activeflag = 1 ;
	
-- This update to revert the FK voilation fix	
update userprofileaddress 
	set securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7',
		updatedby = 'CIDM-8055_R1',
		updatedon = now()
where userprofileaddressid = '6abff4fa-aefc-4487-8188-c075f51efe0d' 
	and updatedby = 'CIDM-8055-2';

/*
update userprofileaddress 
	set securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
							and up1.activeflag = 1 
						)
where securityusersid = '00000000-0000-0000-0000-000000000000'
	and updatedby = 'CIDM-8055_R1';
*/	

-- This update to revert the FK voilation fix
update userprofilephonenumber 
	set securityusersid = ( select up1.securityusersid  
							from userprofile up1
						 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
							and up1.activeflag = 1 
						)
where securityusersid = '00000000-0000-0000-0000-000000000000'
	and updatedby = 'CIDM-8055_R1';
	
-- To update new email in muser table
select email, updatedby, updatedon 
	from muser 
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag  = 1 ;

update muser 
set email = ( select up1.email  
				from userprofile up1
			 where lower(up1.email) = lower('kristen.hahn1@maryland.gov')
				and up1.activeflag = 1 
			),
	updatedby = 'CIDM-8055_R1',
	updatedon = now()		
where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag  = 1 ;
						

-- Delete new muser records	
select activeflag, email, updatedon, updatedby, securityusersid, id 
	from muser 
where email in ( 'kristen.hahn1@maryland.gov',
				 'kristen.hahn@maryland.gov'
				)
	and securityusersid <> '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;

update muser 
set activeflag = 0,
	updatedby = 'CIDM-8055_R1',
	updatedon = now()	
where email in ( 'kristen.hahn1@maryland.gov',
				 'kristen.hahn@maryland.gov'
				)
	and securityusersid <> '49ae215c-497c-4ce5-88a6-7b5c087001e7'
	and activeflag = 1 ;

select principalid, id, roleid, teamtypekey, activeflag, updatedby, updatedon 
	from rolemapping 
where principalid 
	in  ( select id::character varying
			from muser 
		  where email in ( 'kristen.hahn1@maryland.gov',
						   'kristen.hahn@maryland.gov'
						  )
		 )
 and activeflag = 1
 and principalid <> '13476' ;

update rolemapping 
set activeflag = 0,
	updatedby = 'CIDM-8055_R1',
	updatedon = now()	
where principalid 
	in  ( select id::character varying
			from muser 
		  where email in ( 'kristen.hahn1@maryland.gov',
						   'kristen.hahn@maryland.gov'
						  )
		 )
 and activeflag = 1
 and principalid <> '13476' ;
 
 
 
/*
select * from userprofile where securityusersid = '49ae215c-497c-4ce5-88a6-7b5c087001e7' and activeflag = 1 ; 

INSERT INTO cjams.userprofile
	(securityusersid, firstname, lastname, displayname, fullname, activeflag, otherfields, onprobation, expirationdate, "timestamp", email, old_id, title, unavailableflag, userworkstatustypekey, voidedby, voidedon, voidreasonid, calendarkey, insertedby, insertedon, updatedby, updatedon, orgname, orgnumber, usertypekey, autonotification, userphoto, middlename, dob, gendertypekey, teamtypekey, cjamspid, usersignatureurl, name_suffix, primarycountyid, supervisorid, entrydate, exitdate, primarycountycd, primaryteamid, primarylocationid, secondarylocationid, jobtitlecd, unitsupervisorid, issupervisor, ssn, assupervisorid, cwlastlogindatetime, aslastlogindatetime, provlastlogindatetime)
VALUES
	('49ae215c-497c-4ce5-88a6-7b5c087001e7', 'Kristen', 'Hahn', 'KristenHahn', 'Kristen Hahn', 1, NULL, false, NULL, NULL, 'kristen.hahn@maryland.gov', 'kristenhahn', NULL, false, NULL, NULL, NULL, NULL, NULL, 'admin', '2023-10-10 08:54:43.116', 'ADMIN', '2023-10-11 14:34:48.147', NULL, NULL, 'DSDS', false, NULL, NULL, NULL, NULL, 'CW', 202019148, NULL, NULL, NULL, '44f3b85d-8fcb-4db5-870e-820563ea85ed', NULL, NULL, '1434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '78713b21-787c-4125-ad87-bcf3fe3dcff3', '2023-10-20 11:24:56.876', NULL, NULL);


select * from userprofile where securityusersid = 'ac4c9da8-bbbc-41b1-954e-970460bce322' and activeflag = 1 ;

INSERT INTO cjams.userprofile
	(securityusersid, firstname, lastname, displayname, fullname, activeflag, otherfields, onprobation, expirationdate, "timestamp", email, old_id, title, unavailableflag, userworkstatustypekey, voidedby, voidedon, voidreasonid, calendarkey, insertedby, insertedon, updatedby, updatedon, orgname, orgnumber, usertypekey, autonotification, userphoto, middlename, dob, gendertypekey, teamtypekey, cjamspid, usersignatureurl, name_suffix, primarycountyid, supervisorid, entrydate, exitdate, primarycountycd, primaryteamid, primarylocationid, secondarylocationid, jobtitlecd, unitsupervisorid, issupervisor, ssn, assupervisorid, cwlastlogindatetime, aslastlogindatetime, provlastlogindatetime)
VALUES
	('ac4c9da8-bbbc-41b1-954e-970460bce322', 'Kristen', 'Hahn', 'KristenHahn', 'Kristen Hahn', 1, NULL, false, NULL, NULL, 'kristen.hahn1@maryland.gov', 'kristenhahn', NULL, false, NULL, NULL, NULL, NULL, NULL, 'admin', '2023-10-20 13:50:12.294', 'ADMIN', '2023-10-20 13:58:32.205', NULL, NULL, 'DSDS', false, NULL, NULL, NULL, NULL, 'CW', 202069516, NULL, NULL, NULL, 'bcd0eec6-bb5e-4181-a07f-2abca7223434', NULL, NULL, '1434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '78713b21-787c-4125-ad87-bcf3fe3dcff3', NULL, NULL, NULL);
*/	
