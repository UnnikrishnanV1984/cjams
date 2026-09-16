/*
   Issue Description:CDM-34714
   Category/ Module  : Approval Inbox 
   Root cause: 
   Fix Provided: Did data fix to remove the record from approval inbox
   
*/

update routing set activeflag=0 ,updatedby='CDM-34714',updatedon=now() where routingid='2cbea19c-2760-4949-be95-d48c98aa9614' and 
objectid ='346ccb66-8d9d-4f16-9a20-3639563da47e' and activeflag =1;