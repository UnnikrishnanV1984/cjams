-- CDM-27346 -Approved Case Plan
/*
   File Name: CDM-27346-routing-ApprovedCasePlan
-- Issue Description: 
    For the 221030017064:Case plan shows in approval inbox, but is already approved.
    Customer Email ID:raymond.brown2@maryland.gov
  
-- Resolution: Updated the ActiveFlag to zero in the routing table for the above case numbers.

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
	updatedby = 'CDM-27346' ,
	updatedon = now()
where
	routingid = '6d6dd698-0990-44c5-a72e-0ecc8ccfd413';