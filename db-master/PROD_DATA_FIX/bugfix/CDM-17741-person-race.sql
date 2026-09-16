-- CDM-17741-person-race
/*
-- Issue Description: 
	1. Race is selected as white and unknown instead of white 
-- Root cause: 
---Fix : User Needs race as only white

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update cjams.personracetypemap 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-17741'
where personracetypemapid in ('122900fa-ecb2-4185-b4b3-d34d5897edca','215db8c1-5978-44c8-82a1-f9da6ec098dc');
