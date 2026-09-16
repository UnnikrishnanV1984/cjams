/*
--	Issue Description: CDM-43263-Adoption Subsidy not issued. 
-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted .
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update adoptioncaseagreementrate
set updatedby = 'CDM-43263',
	updatedon = now()
where adoptionagreementrateid = '0e5abc14-6f2b-40a4-b8fa-8752db6bc155'
	and activeflag = 1;
