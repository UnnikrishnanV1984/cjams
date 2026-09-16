/*
  Issue Description: CDM-41080
   Category/ Module  : Db
   Root cause: Datafix deactivating the user in cjams db
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41080'
where securityusersid='058cfeb8-31e7-49ef-a1ca-bf28d13d29be';

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41080'
where securityusersid='058cfeb8-31e7-49ef-a1ca-bf28d13d29be';

update rolemapping
set activeflag = 0, updatedby = 'CDM-41080', updatedon = now() 
where principalid = '14908' and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-41080', updatedon = now() 
where userid = 14908 and activeflag = 1;

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-41080', updatedon = now() 
where securityusersid = '058cfeb8-31e7-49ef-a1ca-bf28d13d29be' and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-41080', updatedon = now() 
where securityusersid='058cfeb8-31e7-49ef-a1ca-bf28d13d29be' and activeflag = 1;

