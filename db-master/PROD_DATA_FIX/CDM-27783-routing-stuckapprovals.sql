-- CDM-27783-stuck approvals
/*
File Name: CDM-27783-routing-stuckapprovals
-- Issue Description: 
   For the Case ID: 3153784:The plan has been appproved yet remains in the approval box.

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
	updatedby = 'CDM-27783',
	updatedon = now()
where
	routingid = '05eacfeb-9337-4037-bc32-8529cc9cd913'
	and activeflag = 1;
