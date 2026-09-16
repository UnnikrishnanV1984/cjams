 /*
  Issue Description:  CDM-19322_B-120639 Unable to complete funding approvals
   Category/ Module  :  Role access
   Root cause: IV-E and case worker wont get finance access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update userresource set activeflag=0, updatedby='CDM-19322', updatedon=now() where userid=14038 and activeflag=1
and permissiongroupid='c0a323eb-9bfa-4cba-ab61-620f56ca1d0c';