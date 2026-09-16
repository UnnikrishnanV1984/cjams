
/*
   Issue Description: HiCamila Rodriguez is listed under CPS Unit 5. She has been suspended in sailpoint but her name is still in the unit workload list for CPS Unit 5.
   Category/ Module  :  user management   
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint.
   User list:   camila.rodriguez@montgomerycountymd.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CJAMS-58864
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update  userprofile 
set activeflag = 0, 
    updatedby = 'CJAMS-58864',
    updatedon = now() 
    where email in ('camila.rodriguez@montgomerycountymd.gov')
    and activeflag=1;

update  muser 
set activeflag = 0, 
    updatedby = 'CJAMS-58864',
    updatedon = now() 
    where email in ('camila.rodriguez@montgomerycountymd.gov')
    and activeflag=1;

update  rolemapping 
    set activeflag = 0, 
    updatedby = 'CJAMS-58864', 
    updatedon = now() 
    where principalid in ('14092')
    and activeflag = 1;

update  userresource 
    set activeflag = 0 ,
    updatedby = 'CJAMS-58864', 
    updatedon = now() 
    where userid in ('14092')
    and activeflag = 1;  
   
update userprofileaddress
    set activeflag = 0,
    updatedby = 'CJAMS-58864', 
    updatedon = now()
    where securityusersid in('050d6819-bf99-45e5-b14b-572f495a7718')
    and activeflag=1;

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CJAMS-58864', 
    updatedon = now()
    where securityusersid in('050d6819-bf99-45e5-b14b-572f495a7718')
    and activeflag=1;

 update securityusers
    set activeflag = 0,
    updatedby = 'CJAMS-58864', 
    updatedon = now()
    where securityusersid in('050d6819-bf99-45e5-b14b-572f495a7718')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CJAMS-58864', 
    updatedon = now()
    where teammemberid in('050d6819-bf99-45e5-b14b-572f495a7718')
    and activeflag=1;