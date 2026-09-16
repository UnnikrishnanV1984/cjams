-- CDM-27853-Delete Pending Approval
/*
File Name: CDM-27853-routing-DeletePendingApproval
-- Issue Description: 
   For the Case ID: 3231701 :An adoption annual review for service case 3231701 is in the user case pending approval inbox. 
   This is not in user's service area and came to his inbox by an error and it has to be removed.
   Email ID: stacie.parker@maryland.gov

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
	updatedby = 'CDM-27853',
	updatedon = now()
where
	routingid = '4c0d9971-7b5c-48f4-a6ed-b92d8a69ed0c'
	and activeflag = 1
