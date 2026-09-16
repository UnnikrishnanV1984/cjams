/*
-- CDM-19587 - 

-- Issue Description: Mark the case's active flag as 0
-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update servicecase set activeflag = 0, updatedby = 'CDM-19587', updatedon = now()
where servicecasenumber = '2020024702832'
