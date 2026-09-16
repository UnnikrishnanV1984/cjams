-- CDM-27901-Need to be removed 
/*
File Name: CDM-27901-routing-RemoveApprovedCases
-- Issue Description: 
   All three of these cases - 3217903, 3283970, 3072572 are all stuck with nothing to approve. Need to be removed from approvals.
   CLient Email ID :amanda.bates1@maryland.gov

-- Resolution: Updated the activeflag to zero in the routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-27901',
	updatedon = now()
where
	routingid in ('e7e25339-81f7-4795-92ab-1ad0cd8e4e35',
	'e55ca34f-18b2-4c50-869a-8e121f1d567b',
	'c00033c2-b80c-4bb4-bdb2-98e19e1d7b2f')
	and activeflag = 1;
