-- CDM-25121-SAFE-C keeps showing up for approval despite having been approved multiple times
/*
File Name: CDM-25121-routing-SAFE-C-Approvalduplicate
-- Issue Description: 
   For the Case ID: 221020247261:SAFE-C keeps showing up for approval despite having been approved multiple times. Every time supervisor approves it, another one pops up in review and in draft. It also keeps showing up in supervisor's assessments to be approved inbox.

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
	routingstatustypeid = 16,
	updatedby = 'CDM-25121',
	updatedon = now()
where
	routingid = '39396185-ce49-4dfc-af61-5c7c05d41dc9'
	and activeflag = 1;

