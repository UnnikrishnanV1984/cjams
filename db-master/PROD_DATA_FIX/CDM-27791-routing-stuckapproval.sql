-- CDM-27791-stuck approval
/*
File Name: CDM-27791-routing-stuck approval
-- Issue Description: 
   For the Case ID: 3169831:The plan has been appproved yet remains in the approval box.

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
	updatedby = 'CDM-27791',
	updatedon = now()
where
	routingid = 'cd3e1b30-d0ec-4bc0-9210-63630fa6d159'
	and activeflag = 1;
