/*
   Issue Description: CDM-44108 Duplicate Sailpoint accounts- V Eneremadu
   Category/ Module  : User Management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:  victoria.enerema@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-44108
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-44108',
    updatedon = now() 
    where email in ('victoria.enerema@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-44108',
    updatedon = now() 
    where email in ('victoria.enerema@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-44108', 
    updatedon = now() 
    where principalid in ('7188')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-44108', 
    updatedon = now() 
    where userid  in ('7188')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-44108', 
    updatedon = now()
    where securityusersid in ('6f547db3-ae7c-4c01-9499-4e4bba47a64c')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-44108', 
    updatedon = now()
    where securityusersid in ('6f547db3-ae7c-4c01-9499-4e4bba47a64c')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-44108', 
    updatedon = now()
    where securityusersid in ('6f547db3-ae7c-4c01-9499-4e4bba47a64c')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CDM-44108', 
    updatedon = now()
    where teammemberid in ('79275705-e658-44a8-8a45-5af6157f3bd8')
    and activeflag=1;