/*
--CDM-22575-cw-casework

-- Issue Description: 
User needs the prefix as null instead of Mrs

-- Root cause: Data fix updated the the prfix to null
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.person
set prefx = null,
	updatedby = 'CDM-22575',
	updateon =now()
where personid = 'abe76c61-c19b-4dd5-94fc-3f64a7c69abd';