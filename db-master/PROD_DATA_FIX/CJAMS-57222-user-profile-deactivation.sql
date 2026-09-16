/*
Issue Description: Please deactivate userprofiles for 
lee.whitcomb@maryland.gov
lee.whitcomb1@maryland.gov
Category/ Module : User Profile Deactivation
Root cause: Request to deactivate user profile as the user is no longer active.This is a know sailpoint issue.
Fix provided : Data fix has been provided to deactivate the user from user profile related tables. 
Regression Impacts: N/A
Data/Code fix ticket#:CJAMS-57222
Is code fix needed : No
Reason why no related code fix: It's a know sailpoint issue and data fix should resolve it.
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CJAMS-57222',
    updatedon = now() 
    where email in ('lee.whitcomb@maryland.gov','lee.whitcomb1@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CJAMS-57222',
    updatedon = now() 
    where email in ('lee.whitcomb@maryland.gov','lee.whitcomb1@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CJAMS-57222', 
    updatedon = now() 
    where principalid in ('37750','14966')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CJAMS-57222', 
    updatedon = now() 
    where userid  in ('37750','14966')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CJAMS-57222', 
    updatedon = now()
    where securityusersid in ('98fa26db-2497-4480-841c-37ed958b60fe','4ea729c9-d86b-45f6-b898-13a964dde367')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CJAMS-57222', 
    updatedon = now()
    where securityusersid in ('98fa26db-2497-4480-841c-37ed958b60fe','4ea729c9-d86b-45f6-b898-13a964dde367')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CJAMS-57222', 
    updatedon = now()
    where securityusersid in ('98fa26db-2497-4480-841c-37ed958b60fe','4ea729c9-d86b-45f6-b898-13a964dde367')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CJAMS-57222', 
    updatedon = now()
    where teammemberid in ('1bd5498c-46cd-497c-8fc8-c6fe9255fbc5','901a1caf-79b4-45a7-9319-4e5ff80098d3')
    and activeflag=1;