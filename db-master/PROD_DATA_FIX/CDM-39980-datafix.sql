/*
   Issue Description: CDM-39980
   Category/ Module  :Assesments pending approval
   Root cause: user wants to remove pending approvals
   Pull request# for code fix: 
  explanantion: user wants to delete the pending approvals which are already approved
*/

update routing set activeflag = 0, updatedby = 'CDM-39980', updatedon = now()
where routingid = 'b2c196a9-b0e6-4b4b-ba96-68883480beee' and activeflag = 1;