/*
  Issue Description:CDM-39957 CJAMS Access Removal-Amber Frock.
  Category/ Module : User Management
  Root cause: Users are already deactivated in sailpoint. Please do a datafix and deactivate the below users from all user tables in cjams db
  User details
  -------------
  Amber.frock@maryland.gov
  Fix Provided: Data fix has been provided to deactivate users from all the cjams user profile realted tables
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/


update userprofile set activeflag = 0, updatedby = 'CDM-39957', updatedon = now() 
where securityusersid='5184b96b-2578-4e40-baa2-df142c7e8062' and activeflag = 1;

update muser set activeflag = 0, updatedby = 'CDM-39957', updatedon = now() 
where securityusersid='5184b96b-2578-4e40-baa2-df142c7e8062'  and activeflag = 1;

update cjams.securityusers set activeflag=0, updatedby='CDM-39957', updatedon=now()  
where securityusersid='5184b96b-2578-4e40-baa2-df142c7e8062' and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-39957', updatedon=now() 
where securityusersid='5184b96b-2578-4e40-baa2-df142c7e8062' and activeflag = 1;

update teammember 
set activeflag =0,updatedby='CDM-39957', updatedon=now() 
where teammemberid ='8514bed0-8db2-4f2a-be55-1acef6521a42' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CDM-39957', updatedon = now() 
where principalid='15063' and activeflag = 1;






