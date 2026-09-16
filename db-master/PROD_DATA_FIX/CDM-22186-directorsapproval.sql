 
   /*
  Issue Description:  CDM-22186 Purchase Auth sent to Specific User for Director Approval is not going for Director Approval.
   Category/ Module  :  Service log director approval
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
    update teammember set roletypekey='CWSP', updatedby='CDM-22186', updatedon=now() where teammemberid='6e66d40f-d81f-4207-9768-4fdcbffe6d51';