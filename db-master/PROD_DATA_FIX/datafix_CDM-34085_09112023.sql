-- CDM-34085 - Approval
/*
-- Issue Description: 
   Finance is unable to locate the following Purchase Authorizations for approval on the FINANCE side.
  
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.
--				 Please ask the Baltimore City finance users to approve the same.				
-- Note: Note: CIDM-7885 - Lost Purchase Authorizations ticket is for the code fix.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the routing records (CDM-34085)

-- Case ID: 3243222
-- Client ID: 200926039 (Zi'Kai	Connolly) - 8cb1dee0-1f28-4e8d-affd-9d9313471e77
-- Auth ID: 2494596 - Child Care (Paid)  
-- Provider ID: 5086710 (Y OF CENTRAL MARYLAND)


-- 0	40	Forwarded to Funding Approval	5cb8af3e-bad9-40d1-a883-ffd73b301ff1
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '5cb8af3e-bad9-40d1-a883-ffd73b301ff1'
	and objectid = '2494596'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34085',
	updatedon = now()
where routingid = '5cb8af3e-bad9-40d1-a883-ffd73b301ff1'
	and objectid = '2494596'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 0	
	and updatedby = '7cf77857-7a72-4b32-999d-fd0eacf88f37'	;
