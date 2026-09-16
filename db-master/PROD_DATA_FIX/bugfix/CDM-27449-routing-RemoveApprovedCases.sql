--CDM-27449-Approved cases still showing in approval box
/*
   File Name: CDM-27449-routing-RemoveApprovedCases
-- Issue Description: 
    For the case 3163902, 3109455, 3301602 , 3210142 - cases has been approved but is still visible in the tab for the user.
	and user wants us to delete from approval box.
    Customer Email ID:shaquan.brown@maryland.gov
  
-- Resolution: Updated the activeflag to zero in the routing table for the case 3163902, 3109455, 3301602 , 3210142

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
	updatedby = 'CDM-27449'
where
	routingid in ('13887154-22b4-4ae7-81fb-2f7887b32687',
	'5cd5c09b-6f35-4147-b5cf-01b43cde4b14',
	'dfbc53b9-d1bd-40c5-ba19-d7b4661be538',
	'86224228-ea2a-4795-aa91-e608b2d78674')
	and activeflag = 1;