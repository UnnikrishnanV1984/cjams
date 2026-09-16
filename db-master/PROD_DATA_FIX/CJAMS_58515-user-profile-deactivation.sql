/*
  Issue Description: CJAMS-58515 worker need to be deleted. 
                     Please do a datafix to deactivate the user ezra.gray2@montgomerycountymd.gov in cjams db
  Category/ Module : User Management
  Root cause: Remove the worker ezra.gray2@montgomerycountymd.gov in cjams db as the user is already deactivated from sailpoint 
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: ezra.gray2@montgomerycountymd.gov
--securityuserid: b01a22eb-152d-4e34-bd0c-f196156addff
-- id : 29018

update userprofile set activeflag = 0, updatedby = 'CJAMS-58515', updatedon = now() 
where securityusersid ='b01a22eb-152d-4e34-bd0c-f196156addff' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-58515', updatedon = now() 
where securityusersid ='b01a22eb-152d-4e34-bd0c-f196156addff' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-58515', updatedon=now()  
where securityusersid ='b01a22eb-152d-4e34-bd0c-f196156addff' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-58515', updatedon=now() 
where securityusersid ='b01a22eb-152d-4e34-bd0c-f196156addff' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-58515', updatedon = now() 
where principalid ='29018' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-58515', updatedon = now() 
where userid =29018 and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-58515', updatedon = now()
where teammemberid = '2716f24c-a275-4a4e-8168-f14e2505af77' and activeflag = 1; 
