 /*
  Issue Description: CDM-33973 -- Funding approval list
   Category/ Module  :  Staff management
   Root cause: Finance read only ACCESS
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
update cjams.userresource u set activeflag =0, updatedby='CDM-33973', updatedon =now() where userid ='14539' and activeflag =1
and permissiongroupid ='c0a323eb-9bfa-4cba-ab61-620f56ca1d0c';