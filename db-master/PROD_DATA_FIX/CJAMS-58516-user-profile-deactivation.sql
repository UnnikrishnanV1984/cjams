/*
  Issue Description: CJAMS-58516 worker need to be deleted. 
                     Please do a datafix to deactivate the user tomeka.allen@montgomerycountymd.gov in cjams db
  Category/ Module : User Management
  Root cause: Remove the worker tomeka.allen@montgomerycountymd.gov in cjams db as the user is already deactivated from sailpoint 
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: tomeka.allen@montgomerycountymd.gov
--securityuserid: bf92513c-6a68-4267-afbb-b94373c79e9a
-- id : 27854

update userprofile set activeflag = 0, updatedby = 'CJAMS-58516', updatedon = now() 
where securityusersid ='bf92513c-6a68-4267-afbb-b94373c79e9a' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-58516', updatedon = now() 
where securityusersid ='bf92513c-6a68-4267-afbb-b94373c79e9a' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-58516', updatedon=now()  
where securityusersid ='bf92513c-6a68-4267-afbb-b94373c79e9a' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-58516', updatedon=now() 
where securityusersid ='bf92513c-6a68-4267-afbb-b94373c79e9a' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-58516', updatedon = now() 
where principalid ='27854' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-58516', updatedon = now() 
where userid =27854 and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-58516', updatedon = now()
where teammemberid = 'bae5451d-d6d9-4ed2-827f-df0a85f1703d' and activeflag = 1; 
