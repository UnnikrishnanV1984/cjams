/*
  Issue Description:  CDM-42078
   Category/ Module  : Case Pending Approval
   Root cause: User request to delete the case in case pending approval dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE routing
SET activeflag = 0, 
    updatedby = 'CDM-42078', 
    updatedon = NOW()
WHERE objectid = '5c58fcde-8f7a-4cae-af56-5f2477c15969';