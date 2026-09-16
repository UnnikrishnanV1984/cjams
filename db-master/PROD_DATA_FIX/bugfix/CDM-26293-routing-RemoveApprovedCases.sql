-- CDM-26293 - Approved case still on my tree
/*
   File Name: CDM-26293-routing-RemoveApprovedCases
-- Issue Description: 
    For the case 221020246525 - case has been approved but is still visible in the bucket for the user.
    Customer Email ID:antwan.chambers@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the servicerequestnumbers ('221020246525')

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
	updatedby = 'CDM-26293',
	updatedon = now()
where
	routingid = '11559bfb-7bc7-4c74-826c-a38b5c6dacc5'
	and activeflag = 1
	and objectid = '6d58efad-7014-47a8-8d2a-0634ad424320';