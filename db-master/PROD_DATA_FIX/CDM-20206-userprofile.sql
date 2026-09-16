/*
  Issue Description: CDM-20206 Access needed for funding and Payment approvals
   Category/ Module  :  FInance approval
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update userresource set activeflag=0, 
updatedby='CDM-20206',
updatedon=now()
where userid=3490 and activeflag=1 and permissiongroupid='c0a323eb-9bfa-4cba-ab61-620f56ca1d0c';