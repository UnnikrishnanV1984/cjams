-- CDM-26127- stuck on dashboard
/*
   File Name: CDM-26127-routing-RemoveApprovedCase
-- Issue Description: 
    For the case 221020246528  - case has been approved but is still visible in the bucket for the user.
    Customer Email ID:pam.scalio@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the case 221020246528

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
	updatedby = 'CDM-26127',
	updatedon = now()
where
	routingid = 'f40dffa4-433e-4193-8bb5-d4e1ef967508';