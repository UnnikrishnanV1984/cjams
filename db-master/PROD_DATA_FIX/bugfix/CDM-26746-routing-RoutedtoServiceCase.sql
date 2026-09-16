-- CDM-26746-Routed to Service Case
/*
   File Name: CDM-26746-routing-RoutedtoServiceCase
-- Issue Description: 
    For the intakenumber I221010338897:User tried to assign the case to a worker. The status of the case is showing as "route to service case"
    Customer Email ID:genae.elsey@maryland.gov
  
-- Resolution: Need to update the active flag to zero for existing entry in routing table and create a new entry

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
	routingstatustypeid = '2',
	updatedby = 'CDM-26746',
	updatedon = now()
where
	routingid = '208a4492-e917-4167-834c-1f0f42cdc7d0';