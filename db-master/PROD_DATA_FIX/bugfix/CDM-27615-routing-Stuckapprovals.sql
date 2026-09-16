-- CDM-27615-Stuck approvals
/*
   File Name: CDM-27615-routing-Stuckapprovals
-- Issue Description: 
   The 2 approvals for Case Plan 2 Review are stuck in the supervisors, Tamra Canfield's approval box. These were approved by another supervisor as needed.
   Customer Email ID: theresa.kleppinger@maryland.gov

-- Resolution: Updated the activeflag to zero in routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	routing
set
	activeflag = 0 ,
	updatedby = 'CDM-27615',
	updatedon = now()
where
	routingid in ('3bf65f3f-d1a1-40eb-bfaa-66623c55514f',
	'27e0786f-2e09-4f9b-8326-365a99e1169b')
	and activeflag = 1;