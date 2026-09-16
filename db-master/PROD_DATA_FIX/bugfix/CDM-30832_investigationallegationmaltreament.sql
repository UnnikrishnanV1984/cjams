-- CDM-30832 - Appeal Data missing
/*
-- Category/ Module: Response Timer  (Investigation Finding) 
-- Root cause:    
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

UPDATE cjams.investigationallegationmaltreators
SET activeflag=0, updatedon=now(), updatedby = 'CDM-30832'
WHERE intakeservicerequestactorid='9bdc49ea-3ae8-400d-8656-825e456dbe39' and
investigationallegationmaltreatorsid in ('51652fed-ddb3-45cc-85d2-71692d7f1726', '888bf48b-7a1d-4da5-a1f2-84711994aebb', 'd43cf186-79b3-4940-917c-2f5673ca2bd9');
