/*
   Issue Description:CDM-34680
   Category/ Module  : Approval Inbox 
   Root cause: 
   Fix Provided: Did data fix to remove the record from approval inbox
   
*/

UPDATE routing
SET  activeflag=0,  updatedby='CDM-34680', updatedon=now()
WHERE routingid='086a97cd-a1df-4fd4-a2bc-78b596eba30c'  and objectid='62630e9f-a82d-474c-89ba-fd09df61b16c';