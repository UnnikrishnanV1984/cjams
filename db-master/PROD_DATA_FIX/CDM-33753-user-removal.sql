
/*
  Issue Description: CDM-33753 CJAMS issue
   Category/ Module  :  user management
   Root cause: User terminated from sailpoint but showing up in the application
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1 
*/
-- email:'ambrose.iwugo@maryland.gov'


update userprofile set activeflag = 0, updatedby = 'CDM-33753', updatedon = now() where securityusersid ='1157696d-d0e3-45d3-8642-be5c3b2ece0c';
update muser set activeflag = 0, updatedby = 'CDM-33753', updatedon = now() where securityusersid ='1157696d-d0e3-45d3-8642-be5c3b2ece0c';
update rolemapping set activeflag = 0, updatedby = 'CDM-33753', updatedon = now() where principalid ='7094';
update userresource set activeflag = 0, updatedby = 'CDM-33753', updatedon = now() where userid  = '7094';