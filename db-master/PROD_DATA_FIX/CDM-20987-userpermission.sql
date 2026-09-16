/*
  Issue Description: CDM-20987 Supervisor Missing from list
   Category/ Module  :  User managmenent
   Root cause: wrongly updated the roletypekey from openam
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
        
update teammember set roletypekey='CWSP', updatedby='CDM-20987',teamid='745ae733-3929-438f-adb9-6cbd40157bc1',
updatedon=now() where teammemberid='4e4a6a94-dbbf-4144-af43-3c31deddd34d';