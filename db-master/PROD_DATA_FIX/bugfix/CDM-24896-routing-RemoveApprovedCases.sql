-- CDM-24896 - Approved case still on my tree
/*
   File Name: CDM-24896-routing-RemoveApprovedCases
-- Issue Description: 
    For the case 211030009429  - cases has been approved but is still visible in the bucket for the user.
    Customer Email ID:cindy.olah@maryland.gov
  
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
	updatedby = 'CDM-24896',
	updatedon = now()
where
	servicerequestnumber = '211030009429'
	and routingid = '002d5bbe-41f9-45f4-8e9f-c2748e0e91b4'
	and objectid = 'd71e6947-23f3-478b-b798-70aaf047d394'
	and activeflag = 1;