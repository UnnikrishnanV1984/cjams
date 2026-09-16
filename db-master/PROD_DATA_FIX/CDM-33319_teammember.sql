/*
   Issue Description: CDM-333196
   Category/ Module  : User Role
   Root cause: user request 
   Fix Provided: Did data fix to update correct role in teammember
*/

UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-33319', updatedon=now()
WHERE teammemberid='669bc2e8-7063-4ddc-9970-32fab0fb3e1e';
