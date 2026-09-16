-- CDM-38587 - Caseworker list is not showing up 
/*
-- Issue Description: User is not able to see the other caseworker's name in the list while doing the placement validation
-- Category/ Module: Placement Validation
-- Root cause: User role in teammember table is provider role 
-- Resolution: Updated the role to CWSP
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-38587', updatedon=now()
WHERE teammemberid='bdc26477-028f-4224-ac3b-ae4995493728';
