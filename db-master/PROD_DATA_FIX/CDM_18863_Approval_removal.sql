/*
   Issue Description: CDM-18863
   Customer Email ID: terri.lowther@maryland.gov
   Category/ Module  : pending approvals
   Root cause: user wants to remove pending approvals
   Pull request# for code fix: N/A
   explanantion: user wants to delete the pending approvals which are already approved
*/

update routing  set activeflag = 0 , updatedby ='CDM-18863',updatedon = now() 
	where routingid in ('3d6e1b83-19d3-49d4-846a-cd6025fd60ea', 'cf0b5c63-6a39-4b48-ae7c-08a64e278dbf');