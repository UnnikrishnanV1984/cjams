-- CDM-34688 - Missing Flex Funds
/*
-- Issue Description: 
   Users are unable to locate the following Purchase Authorizations for approval on the FINANCE side.
  
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record for Purchase Authorization)
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Note: We are working on the RCA and will do the code fix with CIDM-7885
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the routing records (CDM-34688)

-- Case ID: 202109106985
-- Client ID: 200647820 (Peyton	J Rogers) - 5fb9d7b3-3af0-424b-9ca2-7513955af66e
-- Auth ID: 2561839 - Clothing Purchase (Paid) 
-- Provider ID: 5015769	(Forman Mills)

-- 0	40	Forwarded to Funding Approval	67f71eb5-b2a4-4501-8a3b-4124e442a7ca	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '67f71eb5-b2a4-4501-8a3b-4124e442a7ca'
	and objectid = '2561839'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34688',
	updatedon = now()
where routingid = '67f71eb5-b2a4-4501-8a3b-4124e442a7ca'
	and objectid = '2561839'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
-- Case ID: 3224998
-- Client ID: 1748658 (DAZANELL	L IRBY) - 6f6e1bac-fd78-4c13-9182-75d16fa56dd3
-- Auth ID: 2556252 - Rent Payments/Deposit (Paid) 
-- Provider ID: 5042724	(Highland Village Townhomes)

-- 0	44	Forwarded to Funding Approval	e1896ce1-757d-41b0-a1bf-43d9329564e3	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'e1896ce1-757d-41b0-a1bf-43d9329564e3'
	and objectid = '2556252'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34688',
	updatedon = now()
where routingid = 'e1896ce1-757d-41b0-a1bf-43d9329564e3'
	and objectid = '2556252'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

