/*
   Issue Description: CJAMS-68406
   Category/ Module  :Approval stuck in queue
   Root cause: user wants toremove pending approvals
   Fix Provided: Data fix has been provided by deleting the pending record from pending approval inbox
   Pull request# for code fix: 
  explanantion: user wants to delete the pending approvals which are already approved
*/

update routing 
set activeflag=0, updatedby='CJAMS-68406', updatedon=now()
where routingid='e750f5d6-f379-46cc-83ff-4b1bda76c29d' and objectid='0e530367-1b08-481f-bc2b-c6fda6e7483f' and activeflag=1;