--CDM-20050-Removal of Service Cases
/*
   File Name: CDM-20050-routing-RemoveServiceCases
-- Issue Description: 
    For the case 2020025402942, 3164128 - please remove those two cases from the user To Be Assigned dashboard.
	and user wants us to delete from approval box.
    Customer Email ID:tracie.wilson@maryland.gov
  
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
	updatedon = now() ,
	updatedby = 'CDM-20050'
where
	routingid in ('535dbfb5-96d8-4759-95ad-c562dcc11043',
	'e6ecf8de-6584-441c-81ad-407bf9108dd8')
	and activeflag = 1;