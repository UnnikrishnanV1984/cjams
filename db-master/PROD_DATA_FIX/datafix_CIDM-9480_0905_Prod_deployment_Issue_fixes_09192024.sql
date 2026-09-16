-- CIDM-9480 - 09/05 Prod deployment Issue fixes
/*
-- Issue Description: 
   09/05 Prod deployment Issue fixes, multiple old datafixes scripts were re-deployed in production in error.

-- CDM-37336 Stuck Service log
-- CDM-37374 - completed approval remaining in in box
-- CDM-37054 - Case-closure - BA to Check 
-- CDM-37027 - Case Closure  - BA to Check 

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: 09/05 Prod deployment Issue fixes, multiple old datafixes scripts were re-deployed in production in error.
-- Fix Provided: Datafix has been promoted to fix the impacted data
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CDM-37336 Stuck Service log		
-- 1	44	Forwarded to Funding Approval	3021824	b8e9b786-fabd-4870-9bd7-d6b03b138668
update routing 
set activeflag = 0,
	updatedby = 'CIDM-9480',
	updatedon = now()
where routingid = 'b8e9b786-fabd-4870-9bd7-d6b03b138668'
	and objectid = '3021824'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and activeflag = 1
	and updatedby = 'CDM-37336'
	and updatedon::date = '2024-09-05'::date ;
	
-- CDM-37374 - completed approval remaining in in box	
-- 1	40	Forwarded to Funding Approval	2773231	7807c449-8707-47cb-bf40-6ab4b1a936e0
update routing 
set activeflag = 0,
	updatedby = 'CIDM-9480',
	updatedon = now()
where routingid = '7807c449-8707-47cb-bf40-6ab4b1a936e0'
	and objectid = '2773231'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and activeflag = 1 ;
	
-- CDM-37054 - Case-closure - BA to Check 
update legislative
set activeflag = 0,
	updatedby = 'CIDM-9480',
	updatedon = now()
where updatedby = 'CDM-37054' 
	and insertedon::date = '2024-09-05'::date
	and activeflag = 1;

-- CDM-37027 - Case Closure  - BA to Check 
update legislative
set activeflag = 0,
	updatedby = 'CIDM-9480',
	updatedon = now()
where updatedby = 'CDM-37027' 
	and insertedon::date = '2024-09-05'::date
	and activeflag = 1;
