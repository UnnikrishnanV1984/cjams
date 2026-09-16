/*
   Issue Description: CDM-31462
   Category/ Module  :Deactivating one of the duplicate user. Deactivating 'pee123me@yahoo.com'
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new email : emily.mills3@maryland.gov
*/


update cjams.userprofile 
set activeflag = 0, updatedby = 'CDM-31462', updatedon = now()
where securityusersid = 'a6f5a84e-b2a3-4c4b-a0c7-c00943a69ada' and email = 'pee123me@yahoo.com';

update cjams.muser 
set activeflag = 0, updatedby = 'CDM-31462', updatedon = now()
where securityusersid = 'a6f5a84e-b2a3-4c4b-a0c7-c00943a69ada' and id = 13295;

update cjams.rolemapping 
set activeflag = 0, updatedby = 'CDM-31462', updatedon = now()
where principalid = '13295' and activeflag = 1;