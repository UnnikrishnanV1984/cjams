/*
  Issue Description: CDM-32583
  Root cause: Permanency plan review is  approved but still on approval inbox 
  Fix provided : updated routing table to inactivate this approval request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
update routing set activeflag =0,updatedby ='CDM-32583',updatedon =now() where routingid ='945e1660-22c5-4092-b126-1e3850ded5a8';