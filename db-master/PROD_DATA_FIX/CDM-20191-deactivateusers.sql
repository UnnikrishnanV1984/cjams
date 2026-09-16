
/*
  Issue Description: CDM-20191 Workers
   Category/ Module  :  user management
   Root cause: Users are still active in tables
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'kelly.priest@maryland.gov','kathleen.healy1@maryland.gov'
-- id : 9887,9602

update userprofile set activeflag = 0, updatedby = 'CDM-20191', updatedon = now() where email in ('kelly.priest@maryland.gov','kathleen.healy1@maryland.gov');
update muser set activeflag = 0, updatedby = 'CDM-20191', updatedon = now() where email in ('kelly.priest@maryland.gov','kathleen.healy1@maryland.gov');
update rolemapping set activeflag = 0, updatedby = 'CDM-20191', updatedon = now() where principalid in (9887,9602);
update userresource set activeflag = 0, updatedby = 'CDM-20191', updatedon = now() where userid in (9887,9602);