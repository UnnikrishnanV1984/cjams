/*
Issue: CJAMS-64390 Have Duplicate employees in CJAMS Workload
Category/Module: User Profile
Root cause: User profile kayla.cox@maryland.gov is incorrect and needs to be removed from the workload
Fix provided:  Data fix has been done to remove the user from all the user profile related tables.
Data/Code fix ticket#: CJAMS-64390
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User onboarded incorrectly and data fix should resolve it
*/

-- Email: kayla.cox@maryland.gov
--securityuserid: 95c455f3-d95e-4ac7-a991-3bbdc9079eaa
-- id : 69614


update userprofile set activeflag = 0, updatedby = 'CJAMS-64390', updatedon = now() 
where securityusersid in ('95c455f3-d95e-4ac7-a991-3bbdc9079eaa') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-64390', updatedon = now() 
where securityusersid  in ('95c455f3-d95e-4ac7-a991-3bbdc9079eaa') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-64390', updatedon=now()  
where securityusersid in ('95c455f3-d95e-4ac7-a991-3bbdc9079eaa') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-64390', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('95c455f3-d95e-4ac7-a991-3bbdc9079eaa', '24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-64390', updatedon=now() 
where securityusersid in('95c455f3-d95e-4ac7-a991-3bbdc9079eaa') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-64390', updatedon = now() 
where principalid in('69614') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-64390', updatedon = now() 
where userid in (69614) and activeflag = 1;