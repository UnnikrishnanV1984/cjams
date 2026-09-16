/*
  Issue Description: CJAMS-58491 worker need to be deleted. 
                     Thomas Grazio needs to be deleted from the workload drop down list in LDSS Management 2. 
                     His account grazit01@montgomerycountymd.gov has been suspended in Sailpoint but his name is still in CJAMS.
  Category/ Module : user management
  Root cause: Remove the staff grazit01@montgomerycountymd.gov from the workload as the user is removed from SailPoint. 
              User still showing in the supervisor drop down list on workload. 
  Fix Provided: Data fix has been promoted to Remove the user from cjams profile related table
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- Email: grazit01@montgomerycountymd.gov
--securityuserid: 3194b039-81ff-432e-89d4-5184589a7ac1
-- id : 39289

update userprofile set activeflag = 0, updatedby = 'CJAMS-58491', updatedon = now() 
where securityusersid ='3194b039-81ff-432e-89d4-5184589a7ac1' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-58491', updatedon = now() 
where securityusersid ='3194b039-81ff-432e-89d4-5184589a7ac1' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-58491', updatedon=now()  
where securityusersid ='3194b039-81ff-432e-89d4-5184589a7ac1' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-58491', updatedon=now() 
where securityusersid ='3194b039-81ff-432e-89d4-5184589a7ac1' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-58491', updatedon = now() 
where principalid ='39289' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-58491', updatedon = now() 
where userid =39289 and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-58491', updatedon = now()
where teammemberid = '13b9d6e5-f84d-4bc2-a204-47453b6fd14d' and activeflag = 1; 
