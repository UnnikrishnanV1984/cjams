-- CDM-38250 - Caseworker list is not showing up 
/*
-- Issue Description: User is not able to assign case to Markeita Matthews
-- Category/ Module: Case Assignment
-- Root cause: User role in teammember table is provider role 
-- Resolution: Updated the role to CWCW
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-38250', updatedon=now()
WHERE teammemberid='3e8ffb3f-2797-447e-85b7-5f6b850c32b9';
