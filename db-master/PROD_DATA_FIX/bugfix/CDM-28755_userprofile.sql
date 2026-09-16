/*
   Issue Description: CDM-28755
   Category/ Module  :Deactivating one of the duplicate user. Confirmed with user. Deactivating 'emily.mills@maryland.gov'
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new email : emily.mills3@maryland.gov
*/

update cjams.userprofile 
set activeflag = 0, updatedby = 'CDM-28755', updatedon = now()
where securityusersid = 'bfddb141-6c2b-4e58-85d9-081230e3d67f' and email = 'emily.mills@maryland.gov';

update cjams.muser 
set activeflag = 0, updatedby = 'CDM-28755', updatedon = now()
where securityusersid = 'bfddb141-6c2b-4e58-85d9-081230e3d67f' and id = 17356;

update cjams.rolemapping 
set activeflag = 0, updatedby = 'CDM-28755', updatedon = now()
where principalid = '17356' and activeflag = 1;