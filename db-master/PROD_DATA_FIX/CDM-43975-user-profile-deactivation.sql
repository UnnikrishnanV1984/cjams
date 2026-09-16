/*
   Issue Description: CDM-43975 Worker no longer in Frederick
   Category/ Module  : User Management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:  tamara.ogunade@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-43975
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-43975',
    updatedon = now() 
    where email in ('tamara.ogunade@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-43975',
    updatedon = now() 
    where email in ('tamara.ogunade@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-43975', 
    updatedon = now() 
    where principalid in ('4034')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-43975', 
    updatedon = now() 
    where userid  in ('4034')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-43975', 
    updatedon = now()
    where securityusersid in ('190aa531-8b1a-4062-9c7c-acf85beda2dc')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-43975', 
    updatedon = now()
    where securityusersid in ('190aa531-8b1a-4062-9c7c-acf85beda2dc')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-43975', 
    updatedon = now()
    where securityusersid in ('190aa531-8b1a-4062-9c7c-acf85beda2dc')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CDM-43975', 
    updatedon = now()
    where teammemberid in ('169bbf75-f9be-41b7-9f03-1d8f61926386')
    and activeflag=1;