/*
  Issue Description: CDM-25329 Staff personal cell # is showing in documents
   Category/ Module  :  user management
   Root cause: Incorrect phonenumber in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 4434770727 
*/


update userprofilephonenumber
set phonenumber ='4434015459', updatedon = now(), updatedby ='CDM-25329'
where securityusersid ='6a532667-d49b-4014-8094-50eee1ef078d';