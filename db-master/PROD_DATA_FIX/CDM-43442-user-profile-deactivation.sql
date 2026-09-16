/*
   Issue Description: CDM-43442 Supervisor requested to remove two workers (Bethany Engle & Kathleen Plant) name from Out of Home Care Unit 1.
   Category/ Module  :  user management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   kathleen.plant@maryland.gov
                bethany.engle2@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-43442
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-43442',
    updatedon = now() 
    where email in ('kathleen.plant@maryland.gov','bethany.engle2@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-43442',
    updatedon = now() 
    where email in ('kathleen.plant@maryland.gov','bethany.engle2@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-43442', 
    updatedon = now() 
    where principalid in ('14880','14914')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-43442', 
    updatedon = now() 
    where userid in ('14880','14914')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-43442', 
    updatedon = now()
    where securityusersid in('cabab98e-b9bf-4ca8-8a12-9da309f13d72','15178b6f-0e39-4a3e-89af-27724ace74e2')
    and activeflag=1;

    update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-43442', 
    updatedon = now()
    where securityusersid in('cabab98e-b9bf-4ca8-8a12-9da309f13d72','15178b6f-0e39-4a3e-89af-27724ace74e2')
    and activeflag=1;

    update securityusers
    set activeflag = 0,
    updatedby = 'CDM-43442', 
    updatedon = now()
    where securityusersid in('cabab98e-b9bf-4ca8-8a12-9da309f13d72','15178b6f-0e39-4a3e-89af-27724ace74e2')
    and activeflag=1;


    update teammember
    set activeflag = 0,
    updatedby = 'CDM-43442', 
    updatedon = now()
    where teammemberid in('ed056813-a1d4-4014-bf43-e2151098e855','831aa329-094c-482f-8d0a-cb47843d0239')
    and activeflag=1;