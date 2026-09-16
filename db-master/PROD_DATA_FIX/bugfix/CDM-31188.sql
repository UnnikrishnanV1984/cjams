/*
  Issue Description: CDM-31188
  Root cause: PP approval is not needed but it is there in users approval inbox
  Fix provided : updated routing table to inactivate this approval request
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update cjams.routing set activeflag=0, updatedby='CDM-31188' ,updatedon=now() where routingid='c9df2c46-91fe-4395-8e8f-5d53cb4b0bf8';
