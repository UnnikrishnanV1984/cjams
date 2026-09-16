
/*
  Issue Description: CDM-32995 CJAMS issue
   Category/ Module  :  user management
   Root cause: User terminated from sailpoint but showing up in the application
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1 
*/
-- email:'karla.portilla@maryland.gov'
-- id : 13522



update userprofile set activeflag = 0, updatedby = 'CDM-32995', updatedon = now() where email in ('joycet.dalto@maryland.gov', 'ann.harris@maryland.gov');
update muser set activeflag = 0, updatedby = 'CDM-32995', updatedon = now() where email in ('joycet.dalto@maryland.gov', 'ann.harris@maryland.gov');
update rolemapping set activeflag = 0, updatedby = 'CDM-32995', updatedon = now() where principalid in ('9773','9840');
update userresource set activeflag = 0, updatedby = 'CDM-32995', updatedon = now() where userid in ('9773','9840');
 