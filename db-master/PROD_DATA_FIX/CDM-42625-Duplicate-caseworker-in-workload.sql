/*
   Issue Description: CDM-42625 CJAMS issue. Need to deactivate duplicaate user
   Category/ Module  :  user management
   Root cause: Removal of people no longer employed with Howard County DSS
   User list:  marissa.sears1@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment and securityusers tables
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where securityusersid='31df383b-b631-4d8c-ac58-95198df7d642' and activeflag=1;

update muser
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where securityusersid='31df383b-b631-4d8c-ac58-95198df7d642' and activeflag=1;

update rolemapping
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where principalid='55122' and activeflag=1;

update userprofileaddress
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where securityusersid='31df383b-b631-4d8c-ac58-95198df7d642' and activeflag=1;

update securityusers
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where securityusersid='31df383b-b631-4d8c-ac58-95198df7d642' and activeflag=1;


update teammemberassignment
set activeflag=0, updatedby='CDM-42625', updatedon=now()
where securityusersid='31df383b-b631-4d8c-ac58-95198df7d642' and activeflag=1;