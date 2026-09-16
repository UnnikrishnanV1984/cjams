-- CDM-34917 - Service log stuck in approval stage
/*
-- Issue Description: 
   Service log was sent to an assist. director whom is currently out on medical leave 
   until the 1st of the year and no one is able to approve it so that it can be process and paid.

   User request to re-route the funding approval for service log # 2385709 
   to either Jenny Sibila or Susan Loysen as requested.
  
-- Case ID: 3307700
-- Client ID: 200010953	 (rae'ne walker) - de8b3ee5-feb6-48d6-86fb-2c9011796542
-- Provider ID: 6006156	(Busy Bees Early Learning)
-- Authorization ID: 2385709 - 06/01/2023 To 06/30/2023 - $1155.00 - Child Care (Paid) 
-- Forwarded to Director Approval
-- Baltimore County user: Theresa Cunningham - 130f2fff-c8dc-4958-b92a-a0ee67881931 - theresa.cunningham@maryland.gov

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record for Purchase Authorization)
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Note: We are working on the RCA and will do the code fix with CIDM-7885
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To re-route the Forwarded to Director Approval requests (CDM-34917)
-- 42	Forwarded to Director Approval
select objectid, eventcode, tosecurityusersid, teamid, activeflag, routingstatustypeid, updatedby, updatedon, routingid  
	from routing 
where eventcode = 'PCAUTH' 
	and activeflag  = 1
	and tosecurityusersid = '130f2fff-c8dc-4958-b92a-a0ee67881931' -- theresa.cunningham@maryland.gov
	and routingstatustypeid = 42
 -- and objectid  = '2385709'
order by insertedon desc ;


update routing 
set eventcode = 'PCAUTHR',
	tosecurityusersid = NULL,
	updatedby = 'CDM-34917',
	updatedon = now()
where eventcode = 'PCAUTH' 
	and activeflag  = 1
	and tosecurityusersid = '130f2fff-c8dc-4958-b92a-a0ee67881931' -- theresa.cunningham@maryland.gov
	and routingstatustypeid = 42 ;
 
