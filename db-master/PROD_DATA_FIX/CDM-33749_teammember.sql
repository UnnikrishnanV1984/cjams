/*
   Issue Description: CDM-33749
   Category/ Module  : User Role
   Root cause: user request 
   Fix Provided: Did data fix to update correct unit in teammember
*/

UPDATE cjams.teammember
SET teamid='db0cf8af-c5f6-4b59-99ee-a748e3fec1f3', updatedby='CDM-33749', updatedon=now()
WHERE teammemberid='9be03d30-d4b1-4483-987e-c77d0b23ccb7' and  roletypekey='CWCW';
