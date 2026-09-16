-- CDM-24763 -approval not clearing
/*
   File Name: CDM-24763-routing-Approvalbox
-- Issue Description: 
    For cases 3169831, 3287884, 3128990, 3301353, 3234756, 3268879, The clients name appears on the approval list. The link takes him to case plan. There is no plan to review or approve.
    Customer Email ID:lori.higginbotham@maryland.gov
  
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
	updatedby = 'CDM-24763',
	updatedon = now()
where
	routingid in ('6c1be3cf-e123-4331-aaae-a4b9afb02198',
	'd007541d-5712-42ad-84e3-38d63dad834f',
	'07a52e83-903d-4ee8-945b-cbcc80b93c27',
	'4083ec24-f354-472b-8d85-945a2d3ac830',
	'6661060d-2a26-449d-be7d-cd3b71fa5dcd',
	'6090c488-913c-4791-98f6-5b44b5dd412a',
	'3e800528-3344-42e4-a5cc-f993352d30c4',
	'c3b445b8-8dfd-46e9-8011-13efdb0c66cf',
	'36b56c57-9786-4508-904f-9faf5cc2b7de')
	and activeflag = 1;