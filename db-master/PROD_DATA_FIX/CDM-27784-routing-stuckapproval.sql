-- CDM-27784-stuck approval
/*
File Name: CDM-27784-routing-stuckapproval
-- Issue Description: 
   For the Case ID: 3210142:The plan has been appproved yet remains in the approval box.

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
	updatedby = 'CDM-27784',
	updatedon = now()
where
	routingid = '1bad1249-532f-4c2a-811b-e608b196a444'
	and activeflag = 1;
