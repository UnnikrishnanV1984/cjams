
 /*
  Issue Description: CDM-24000
   Category/ Module  :  Director/my supervisor missing from approvals
   Root cause:
   Pull request# for code fix: Fixed as part of user story
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update teammember set roletypekey='CWSP',
updatedby='CDM-24000', updatedon=now()
where teammemberid='5b3985a2-afda-4626-9836-60f68761c0ac';