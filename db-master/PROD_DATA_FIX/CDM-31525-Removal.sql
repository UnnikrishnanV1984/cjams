
/*
-- Category/ Module: Child Removal
-- Root cause: user request .   
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/


UPDATE cjams.intakeservreqchildremoval
SET activeflag = 0, updatedby = 'CDM-31525', updatedon = now()
WHERE intakeservreqchildremovalid in ('5aa38dc4-6c43-4fba-8249-176705a24c59');

UPDATE cjams.intakeservreqchildremoval_history
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-31525'
WHERE intakeservreqchildremovalid in ('5aa38dc4-6c43-4fba-8249-176705a24c59') and activeflag = 1;

--No routing becuase it's a draft record 