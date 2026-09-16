-- CDM-28056 -  HOH/Guardianship/GAP
/*
-- Issue Description: 
   When approved by supervisor, it keeps saying draft.
-- Category/ Module: GAP
-- Root cause: Team roletypekey is not correct
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/
UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-28056', updatedon=now()
WHERE teammemberid='dbb83933-164d-4da7-acca-c94568273554' and activeflag=1;

