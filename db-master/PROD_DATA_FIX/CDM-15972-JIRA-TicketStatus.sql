/*
   Issue Description: CDM-15972
   Category/ Module  : JIRA status
   Root cause: user wants to update the JIRA status
   Pull request# for code fix: 7390
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/
update defecttracking.supportlog 
set status = 'Closed', updatedby = 'CDM-15972', updatedon = now()
where supportlogid = 'e040d69b-2004-416e-ba3e-5ab4a7cc6cc2';