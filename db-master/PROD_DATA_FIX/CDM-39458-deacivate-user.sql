/*
  Issue Description: CDM-39458 Matlyn Rybak has 2 accounts listed in the workload of Treatment FC. 
                     The second Matyln listed should be deleted. The account is matlyn.rybak@montgomerycountymd.gov. 
                     This account was suspended in sailpoint but is still showing in the unit workload
  Category/ Module : user management
  Root cause: Remove the staff matlyn.rybak@montgomerycountymd.gov from the workload as he is removed from SailPoint. 
              He is still showing in the supervisor drop down list on workload. 
  Fix Provided: Data fix has been promoted to Remove the user from cjams profile related table
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- Email: matlyn.rybak@montgomerycountymd.gov
--securityuserid: 5987409a-c87a-464c-ab45-781ad31ab942 
-- id : 29117

update userprofile set activeflag = 0, updatedby = 'CDM-39458', updatedon = now() 
where securityusersid ='5987409a-c87a-464c-ab45-781ad31ab942' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CDM-39458', updatedon = now() 
where securityusersid ='5987409a-c87a-464c-ab45-781ad31ab942' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CDM-39458', updatedon=now()  
where securityusersid ='5987409a-c87a-464c-ab45-781ad31ab942' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-39458', updatedon=now() 
where securityusersid ='5987409a-c87a-464c-ab45-781ad31ab942' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CDM-39458', updatedon = now() 
where principalid ='29117' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-39458', updatedon = now() 
where userid =29117 and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CDM-39458', updatedon = now()
where teammemberid = '8180854e-c7de-49f5-9813-4e242561e922' and activeflag = 1; 