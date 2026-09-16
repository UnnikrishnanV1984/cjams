/*
Issue: CJAMS-65156 Have Duplicate employees in CJAMS Workload
Category/Module: User Profile
Root cause: User profile john.morant1@maryland.gov is incorrect and needs to be removed from the workload
Fix provided:  Data fix has been done to remove the user from all the user profile related tables.
Data/Code fix ticket#: CJAMS-65156
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User onboarded incorrectly and data fix should resolve it
*/

-- Email: john.morant1@maryland.gov
--securityuserid: f27bdd5e-3edd-47d7-aa4c-0dd876a1362a
-- id : 81097


update userprofile set activeflag = 0, updatedby = 'CJAMS-65156', updatedon = now() 
where securityusersid in ('f27bdd5e-3edd-47d7-aa4c-0dd876a1362a') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-65156', updatedon = now() 
where securityusersid  in ('f27bdd5e-3edd-47d7-aa4c-0dd876a1362a') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-65156', updatedon=now()  
where securityusersid in ('f27bdd5e-3edd-47d7-aa4c-0dd876a1362a') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-65156', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('f27bdd5e-3edd-47d7-aa4c-0dd876a1362a') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-65156', updatedon=now() 
where securityusersid in('f27bdd5e-3edd-47d7-aa4c-0dd876a1362a') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-65156', updatedon = now() 
where principalid in('81097') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-65156', updatedon = now() 
where userid in (81097) and activeflag = 1;