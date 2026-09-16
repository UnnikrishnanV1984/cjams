/*
   Issue Description: CDM-43954 removal of worker
   Category/ Module  : User Management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   jennifer.nichols@maryland.gov, lindsay.elias@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-43954
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-43954',
    updatedon = now() 
    where email in ('jennifer.nichols@maryland.gov','lindsay.elias@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-43954',
    updatedon = now() 
    where email in ('jennifer.nichols@maryland.gov','lindsay.elias@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-43954', 
    updatedon = now() 
    where principalid in ('4116','38114')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-43954', 
    updatedon = now() 
    where userid  in ('4116','38114')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-43954', 
    updatedon = now()
    where securityusersid in ('183e0ad9-ecf2-4081-9c9b-53511f8a0773','f7e1d03e-c49f-46ee-ad7c-b06b97932ed4')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-43954', 
    updatedon = now()
    where securityusersid in ('183e0ad9-ecf2-4081-9c9b-53511f8a0773','f7e1d03e-c49f-46ee-ad7c-b06b97932ed4')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-43954', 
    updatedon = now()
    where securityusersid in ('183e0ad9-ecf2-4081-9c9b-53511f8a0773','f7e1d03e-c49f-46ee-ad7c-b06b97932ed4')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CDM-43954', 
    updatedon = now()
    where teammemberid in ('f3ca4ad8-62b0-465b-bd76-282342265e35','f7e1d03e-c49f-46ee-ad7c-b06b97932ed4')
    and activeflag=1;

