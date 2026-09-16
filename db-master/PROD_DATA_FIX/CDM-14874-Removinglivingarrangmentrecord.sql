/*
-- Category/ Module: Removal/Placement 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement set activeflag = 0, updatedby = 'CDM-14874', updatedon = now() where placementid = '7717af4b-e6ac-4f92-9fc5-127c72c0cb7d';
update livingarrangement set activeflag = 0, updatedby = 'CDM-14874', updatedon = now() where livingid = '9d4cfdbe-e38e-4d75-9173-ed2cf3166cf5';

