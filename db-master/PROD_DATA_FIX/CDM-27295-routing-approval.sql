-- CDM-27295 -approval issue
/*
   File Name: CDM-27295-routing-approval
-- Issue Description: 
    For the case 3296624:A GAP disclosure agreement remains in my approval box despite being approved and showing as approved. Needs corrected so it doesn't impact GAP payment.
    Customer Email ID:abbey.niland@maryland.gov
  
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
	updatedby = 'CDM-27295' ,
	updatedon = now()
where
	routingid = '4122240c-4ba7-43e9-af1a-37474fce59cf';