-- CDM-22542-Case opened through glitch
/*
File Name: CDM-22542-adoptioncaseagreement-ProviderIDMissing
-- Issue Description: 
   For the Case ID: 221030015659 this case was opened through a glitch. There are no people attached to it and the assessments cannot be completed. User wants us to remove from CJAMS

-- Resolution: Updated the activeflag to zero in the servicecase, caseassignment, servicecasedisposition, routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	servicecase
set
	activeflag = 0,
	updatedby = 'CDM-22542',
	updatedon = now()
where
	servicecaseid = '61c1774a-f70b-43e5-b574-0a4152959017';

update
	caseassignment
set
	activeflag = 0,
	updatedby = 'CDM-22542',
	updatedon = now()
where
	objectid = '61c1774a-f70b-43e5-b574-0a4152959017'
	and activeflag = 1 ;

update
	servicecasedisposition
set
	activeflag = 0,
	updatedby = 'CDM-22542',
	updatedon = now()
where
	servicecaseid = '61c1774a-f70b-43e5-b574-0a4152959017';

