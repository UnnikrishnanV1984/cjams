/* 
   Issue Description: CJAMS-57864 Burton Dickerson Account
   Category/ Module  : User management
   Root cause: Data fix needed to Remove old staff from the CJAMS DB
               email: burton.dickerson1@maryland.gov 
   Fix Provided : Data fix has been provided Deactive the users from user profile related tables.
   Regression Impacts: N/A
   Is Code fix needed : No
   Reason why no related code fix: It is a known sailpoint issue
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CJAMS-57864'
where securityusersid in ('0e67842f-5ee3-4003-ab07-0b1b6dca3007') and activeflag = 1;

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CJAMS-57864'
where securityusersid in ('0e67842f-5ee3-4003-ab07-0b1b6dca3007') and activeflag = 1;

update rolemapping
set activeflag = 0, updatedby = 'CJAMS-57864', updatedon = now() 
where principalid in ('27620') and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CJAMS-57864', updatedon = now() 
where userid in (27620) and activeflag = 1;

update teammemberassignment 
set activeflag=0,updatedon=now(), updatedby = 'CJAMS-57864'
where securityusersid in ('0e67842f-5ee3-4003-ab07-0b1b6dca3007') and activeflag = 1;

update securityusers 
set activeflag=0,updatedon=now(), updatedby = 'CJAMS-57864'
where securityusersid in ('0e67842f-5ee3-4003-ab07-0b1b6dca3007') and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-57864', updatedon = now()
where teammemberid in ('4b569d04-2b24-4f4a-980a-7bcf41d6dc18') and activeflag = 1;
