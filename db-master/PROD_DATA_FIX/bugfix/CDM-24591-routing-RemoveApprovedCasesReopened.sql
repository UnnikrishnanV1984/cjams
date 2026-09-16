-- CDM-24591 - Approved Cases
/*
   File Name: CDM-24591-routing-RemoveApprovedCases-Reopened
-- Issue Description: 
    For the case 3228617  - cases has been approved but is still visible in the bucket for the user.
    Customer Email ID:teresa.boston@maryland.gov
  
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
	activeflag = 0,
	updatedby = 'CDM-24591',
	updatedon = now()
where
	routingid = '2254beb3-2fe6-4a96-84cc-a6cda4c95891'
	and activeflag = 1;