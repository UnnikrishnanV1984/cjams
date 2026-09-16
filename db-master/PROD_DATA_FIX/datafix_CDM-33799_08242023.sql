-- CDM-33799 - Authorization Approval
/*
-- Issue Description: 
   Purchase Authorization approval requests are missing
   
-- Case ID: 211030009304
-- Client ID: 200773440 (Riley S Knox) - d963460c-0fde-4b06-8d8f-390be52a7c3c
-- Auth ID: 2438010 - 2023-08-01 To 2023-08-01 - $250.00 - Food (Paid) 
-- Provider ID: 6006485 (Save A Lot)
-- Forwarded to Funding Approval

-- Case ID: 3139039
-- Client ID: 3994124 (ANTONIO WARD) - 6b95dbe6-b227-4a44-a347-7b21df103b8d
-- Auth ID: 2431376 - 2023-08-21 To 2023-08-28 - $116.50 - Food (Paid) 
-- Provider ID: 6006485 (Save A Lot)
-- Forwarded to Payment Approval
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.
--				 Please ask the Baltimore City finance users to apporv the same.				
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the routing records (CDM-33799)
-- Auth ID: 2438010 - 2023-08-01 To 2023-08-01 - $250.00 - Food (Paid) 
-- 0	40	Forwarded to Funding Approval	c6fbdaeb-0971-49ff-ad68-3c9bf08495e5 - PCAUTHR - Forwarded to Funding Approval
-- 0	39	Forwarded to Case Supervisor	cbb00ccf-d751-48d7-89c0-4dae5d107903 - Forwarded to Case Supervisor


select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'c6fbdaeb-0971-49ff-ad68-3c9bf08495e5'
	and objectid = '2438010'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-33799',
	updatedon = now()
where routingid = 'c6fbdaeb-0971-49ff-ad68-3c9bf08495e5'
	and objectid = '2438010'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
-- Auth ID: 2431376 - 2023-08-21 To 2023-08-28 - $116.50 - Food (Paid) 
-- 0	41	Forwarded to Payment Approval	753af337-a84c-4d87-8aab-2b385d77eb5d - PCAUTHR - Forwarded to Payment Approval
-- 0	40	Forwarded to Funding Approval	b501b2a1-1fbf-4a8c-b9c5-ed14a4a0ec48 - Forwarded to Funding Approval
-- 0	39	Forwarded to Case Supervisor	a4beb8bc-9d45-4f5e-9c4d-ef4712c2b1b8 - Forwarded to Case Supervisor

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '753af337-a84c-4d87-8aab-2b385d77eb5d'
	and objectid = '2431376'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-33799',
	updatedon = now()
where routingid = '753af337-a84c-4d87-8aab-2b385d77eb5d'
	and objectid = '2431376'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
