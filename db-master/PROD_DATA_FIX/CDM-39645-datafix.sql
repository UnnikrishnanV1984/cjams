/*
  Issue Description:  CDM-39645
   Category/ Module  :  Application
   Root cause: user requested to remove inactive number 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update userprofile set activeflag = 0, updatedby = 'CDM-39645', updatedon = now()
where securityusersid ='1bb0ae09-dbfa-4006-a4a4-a986416996a0' and activeflag =1;

update cjams.securityusers set activeflag=0, updatedby = 'CDM-39645', updatedon = now()
where securityusersid ='1bb0ae09-dbfa-4006-a4a4-a986416996a0' and activeflag =1;

update muser 
set activeflag = 0, updatedby = 'CDM-39645', updatedon = now()
where securityusersid ='1bb0ae09-dbfa-4006-a4a4-a986416996a0' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby = 'CDM-39645', updatedon = now()
where securityusersid ='1bb0ae09-dbfa-4006-a4a4-a986416996a0' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CDM-39645', updatedon = now()
where principalid = '44432' and activeflag =1;

update userresource set activeflag = 0, updatedby = 'CDM-39645', updatedon = now()
where userid=44432 and activeflag = 1; 

update teammember set activeflag = 0, updatedby = 'CDM-39645', updatedon = now()
where teammemberid = '1bb0ae09-dbfa-4006-a4a4-a986416996a0' and activeflag = 1;