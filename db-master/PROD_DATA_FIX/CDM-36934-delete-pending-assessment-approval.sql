/*
  Issue Description: CDM-36934
  Root cause: CPS AR # 241021702322 has been completed/closed, please remove the approval routing from the supervisor assessment dashboard. 
  Fix provided : updated routing table to inactivate this approval request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update routing set activeflag =0, updatedby ='CDM-36934',updatedon =now() where routingid ='efdb08a9-5991-47f9-9813-957411e6cbb7';