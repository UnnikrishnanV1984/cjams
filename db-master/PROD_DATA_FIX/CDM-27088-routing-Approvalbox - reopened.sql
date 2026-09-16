-- CDM-27088 -Approval box
/*
   File Name: CDM-27088-routing-Approvalbox-reopened
-- Issue Description: 
    All these case 221030017802,3256920,3248198,3088733,3281273,3292645,2021010207209,3299702,3188406,221030015626,3289579 have been approved and need to be removed from Approval inbox  
    Customer Email ID:kim.compton@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the above case numbers.

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
	updatedby = 'CDM-27088',
	updatedon = now()
where
	routingid = 'c0802326-7b14-4643-9699-f752a9d719dc';