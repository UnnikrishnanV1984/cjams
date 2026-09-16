
-- CDM-36954 - Remove case from the Dashboard
/*
-- Issue Description: 
	1. User requested to remove Adoption Applicability case from dashboard. Client ID: 2886087

-- Category/ Module: Adoption Applicability
-- Root cause: User requested to remove ACA from dashboard
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select * from adoptionapplicabilityinfo
where clientid = '2886087' and adoptionapplicabilityid = '920f2157-098b-46c3-b240-01457ddf477b' and activeflag = 1;

update adoptionapplicabilityinfo 
set activeflag = 0,
	updatedby = 'CDM-36954',
	updatedon = now()
where clientid = '2886087' and adoptionapplicabilityid = '920f2157-098b-46c3-b240-01457ddf477b' and activeflag = 1;


