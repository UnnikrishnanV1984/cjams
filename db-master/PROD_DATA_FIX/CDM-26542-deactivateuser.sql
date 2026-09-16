/*
  Issue Description: CDM-26542 Delete Worker
   Category/ Module  :  user management
   Root cause: User is deactivated in sailpoint and but active in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26542'
where securityusersid='177f49ea-86b2-4600-9e1a-0a79da146323';

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26542'
where securityusersid='177f49ea-86b2-4600-9e1a-0a79da146323';

update rolemapping
set activeflag = 0, updatedby = 'CDM-26542', updatedon = now() 
where principalid = '13443' and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-26542', updatedon = now() 
where userid = 13443 and activeflag = 1;

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-26542', updatedon = now() 
where securityusersid = '177f49ea-86b2-4600-9e1a-0a79da146323' and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-26542', updatedon = now() 
where securityusersid='177f49ea-86b2-4600-9e1a-0a79da146323' and activeflag = 1;