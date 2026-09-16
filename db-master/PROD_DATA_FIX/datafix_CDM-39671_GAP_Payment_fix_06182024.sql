-- CDM-39671 -- GAP SUBSIDY IS NO LONGER LISTED ON PROGRAM.
/*
-- Issue Description: 
   To Trigger Under Over
   
-- Case ID: 3176273
-- Client ID: 2677643 (Damerra jones) - 43a735ef-8332-44d2-8229-bea0b94b406d
-- Rate ID: ffdf45a2-22b1-4a10-8490-0cf904989ca3 - 2024-03-10 To 2025-03-09
-- GAP ID: 3677 - 2015-03-10 - 2027-06-12 - 06b48375-8f00-43f1-913f-79f98d3ef445
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: User Error, person demographic info for the Client ID # 2677643 has been updated bu the user. 
-- Fix Provided: Datafix has been promoted to trigger finance under/over batch for missing payment May 2024 services.	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over 
update cjams.gapratesrevision 
set approvaldate = now(),
    updatedby = 'CDM-39671',
    updatedon = now()
where gaprateid = 'ffdf45a2-22b1-4a10-8490-0cf904989ca3' 
	and approvaldate  is not null;
