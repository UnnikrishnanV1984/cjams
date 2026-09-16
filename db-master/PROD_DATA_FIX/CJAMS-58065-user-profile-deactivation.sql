/*
Issue Description: Please deactivate userprofiles for tawney.emerick@maryland.gov
Category/ Module : User Profile Deactivation
Root cause: Request to deactivate user profile as the user is no longer active.This is a know sailpoint issue.
Fix provided : Data fix has been provided to deactivate the user from user profile related tables. 
Regression Impacts: N/A
Data/Code fix ticket#:CJAMS-58065
Is code fix needed : No
Reason why no related code fix: It's a know sailpoint issue and data fix should resolve it.
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CJAMS-58065',
    updatedon = now() 
    where email in ('tawney.emerick@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CJAMS-58065',
    updatedon = now() 
    where email in ('tawney.emerick@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CJAMS-58065', 
    updatedon = now() 
    where principalid in ('49277')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CJAMS-58065', 
    updatedon = now() 
    where userid  in ('49277')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CJAMS-58065', 
    updatedon = now()
    where securityusersid in ('a59d44b1-2dae-440b-a645-dc99dc7d0e46')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CJAMS-58065', 
    updatedon = now()
    where securityusersid in ('a59d44b1-2dae-440b-a645-dc99dc7d0e46')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CJAMS-58065', 
    updatedon = now()
    where securityusersid in ('a59d44b1-2dae-440b-a645-dc99dc7d0e46')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CJAMS-58065', 
    updatedon = now()
    where teammemberid in ('c8fd5550-08af-44d1-96a6-c7f50e2e47e4')
    and activeflag=1;