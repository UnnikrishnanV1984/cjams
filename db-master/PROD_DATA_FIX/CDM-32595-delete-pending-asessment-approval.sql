/*
  Issue Description: CDM-32595
  Root cause: Assessment is  approved but still on approval inbox 
  Fix provided : updated routing table to inactivate this approval request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update routing set activeflag =0, updatedby ='CDM-32595',updatedon =now() where routingid ='0a5043b0-8007-4301-a8a8-cee9730bcc5b';