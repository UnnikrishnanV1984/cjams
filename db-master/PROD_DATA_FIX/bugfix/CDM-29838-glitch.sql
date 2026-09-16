/*
-- Issue Description: 
	CDM-29838-glitch
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update Investigationmaltreatment set activeflag =0, updatedby = 'CDM-29838', updatedon = now() 
where maltreatmentid in ('5115378e-859f-4f99-817c-496249a5b69d','27645d0e-3e3a-4d01-ba52-f37b15c1bf11');