-- CDM-31226 - Pending write off (S20230130050226)
/*
-- Issue Description: 
   User request to forward Receivable Write-Off approval reuest to diff supervisor
   
-- Provider ID: 5090768	(Rhonda Leary) - Local Department Home
-- Receivable Detail ID: 1728284 - 2022-04-01 To 2022-04-27 - $116.64
-- Write-Off request is for $116.64
   
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to forward Receivable Write-Off approval reuest to Janet Adetunji
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Write-Off Request forward to 
-- b8723d80-479b-400b-8e39-6fd94e10ba7e	janet.adetunji1@maryland.gov	Janet Adetunji
-- Team 4cde989e-2c03-40af-b733-a9e9e17310fd
select objectid, eventcode, remarks, tosecurityusersid, teamid, updatedby, updatedon  
	from routing
where routingid = '7c79315b-e804-416a-89be-1a843e7235c4'
	and activeflag = 1
	and routingstatustypeid = 30 ;

update routing
set tosecurityusersid = 'b8723d80-479b-400b-8e39-6fd94e10ba7e',
	teamid = '4cde989e-2c03-40af-b733-a9e9e17310fd',
	updatedby = 'CDM-31226', 
	updatedon  = now()
where routingid = '7c79315b-e804-416a-89be-1a843e7235c4'
	and activeflag = 1
	and routingstatustypeid = 30 ;	