/*
  Issue Description: CDM-22830 New person incorrectly added to workload
   Category/ Module  :  user management
   Root cause: Test users added in table 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email: test@countytest.gov
-- id : 14638	bba2b04f-c96b-479b-8e93-9668e4e78fed

update userprofile set activeflag = 0, updatedby = 'CDM-22830', updatedon = now() where email = 'test@countytest.gov';
update muser set activeflag = 0, updatedby = 'CDM-22830', updatedon = now() where email = 'test@countytest.gov';
update rolemapping set activeflag = 0, updatedby = 'CDM-22830', updatedon = now() where principalid = 14638 ;
update teammemberassignment set activeflag =0, updatedby = 'CDM-22830', updatedon = now() where securityusersid = 'bba2b04f-c96b-479b-8e93-9668e4e78fed';