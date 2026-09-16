/*
  Issue Description: CDM-21187 Unit staff no longer employeed
   Category/ Module  :  user management
   Root cause: Unit staff no longer employeed but active in userprofile table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'kim.marker@maryland.gov','sarinar.smith@maryland.gov','linda.blacker@maryland.gov'
-- id : 4063,4111,7014


update userprofile set activeflag = 0, updatedby = 'CDM-21187', updatedon = now() where email in ('kim.marker@maryland.gov','sarinar.smith@maryland.gov','linda.blacker@maryland.gov');
update muser set activeflag = 0, updatedby = 'CDM-21187', updatedon = now() where email in ('kim.marker@maryland.gov','sarinar.smith@maryland.gov','linda.blacker@maryland.gov');
update rolemapping set activeflag = 0, updatedby = 'CDM-21187', updatedon = now() where principalid in (4063,4111,7014,3976);