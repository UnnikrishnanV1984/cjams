-- CDM-39966 - Adoption subsidy payment
/*
-- Issue Description: 
   User error, Data fix to update the rate end date. 

-- Case ID: 3218628
-- Client ID: 3446367 (MEADOW MACKEY) - c5281c51-7002-4c49-ae82-dda0c639e0af
-- Current Provider ID: 5020134	(Lisa Mackey)
-- New Provider ID: 6114081	(William  Mackey) 
-- Rate ID: fab2cc52-585c-4c68-9699-788342dea8f0 - 2023-07-20 To 2024-07-19 - 5020134
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User error, provider switch was done the adoption rate end date was adjusted in CJAMS.
-- Fix Provided: Datafix has been promoted to update the end date as 06/30/2024, to pay the new provider starting 07/01/2024.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update the rate end date (CDM-39966)
update adoptioncaseagreementrate
set enddate = '2024-06-30 00:00:00', -- 2024-07-19 00:00:00
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-39966'
where adoptionagreementrateid = 'fab2cc52-585c-4c68-9699-788342dea8f0'
	and activeflag = 1 ;

update adoptioncaserevision
set enddate = '2024-06-30 00:00:00', -- 2024-07-19 00:00:00
	updatedon = now(), 
	updatedby = 'CDM-39966'
where adoptionagreementrateid = 'fab2cc52-585c-4c68-9699-788342dea8f0'
	-- and activeflag = 1 
	;	
	