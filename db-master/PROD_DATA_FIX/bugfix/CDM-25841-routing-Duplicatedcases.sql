--CDM-25841-duplicated cases
/*
   File Name: CDM-25841-routing-Duplicatedcases
-- Issue Description:
	duplicate case (# 221020255949) from user dashboard need to be Removed.
    Customer Email ID:brenda.carr@maryland.gov
  
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
	updatedby = 'CDM-25841',
	updatedon = now()
where
	routingid = '8ef5bf86-f4cb-4e8e-a76e-04731cc65500'
	and activeflag = 1;