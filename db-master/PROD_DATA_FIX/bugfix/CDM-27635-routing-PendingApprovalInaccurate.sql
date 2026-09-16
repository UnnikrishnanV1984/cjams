-- CDM-27635-pending approval is inaccurate
/*
   File Name: CDM-27635-routing-PendingApprovalInaccurate
-- Issue Description: 
   case plan 2 has been completed for the case and approved, case has been closed but will not leave supervisors approval screen.
   Customer Email ID: kim.compton@maryland.gov

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
	activeflag = 0,
	updatedby = 'CDM-27635',
	updatedon = now()
where
	routingid = 'c0802326-7b14-4643-9699-f752a9d719dc'
	and activeflag = 1;