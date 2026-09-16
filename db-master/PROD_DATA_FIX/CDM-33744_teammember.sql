/*
   Issue Description: CDM-33744
   Category/ Module  : User Role
   Root cause: user request 
   Fix Provided: Did data fix to update correct role in teammember
*/

UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-33744', updatedon=now()
WHERE teammemberid='cdd2de1b-aec7-40e3-859c-cfd67aa8800b';
