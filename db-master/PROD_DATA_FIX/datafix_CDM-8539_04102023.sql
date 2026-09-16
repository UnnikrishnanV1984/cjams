-- CDM-8539 - NIA OLUKAYODE
/*
-- Issue Description: 
	GAP Provider payment for 12/26/2020 - 12/31/2020 is not created.

-- Case ID: 3290500
-- Client ID: 1692933 (NIA IMANI OLUKAYODE) - cf08bdd2-e800-491a-8e31-4ae33c2f919c
-- GAP ID: 5413 - 2019-11-14 To 2021-06-30 - fb95d130-a7d2-489a-aa5d-d6365bde3227
-- Provider ID: 5090944	(Kashaka Olukayode) 
 
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Unknown, the GAP rate was approved back in Dec 2020. 
-- Fix Provided: Datafix has been promoted to trigger the Finance under over batch and re-calculate the payments for this GAP.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over 
-- Rate ID: 12678990-1a40-4288-9c1f-812f0a5e8c36	- 2020-12-25 To 2021-06-30 - $902.00
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid  = 'fb95d130-a7d2-489a-aa5d-d6365bde3227'
	and approvalstatustypekey = '3047'
	and activeflag  = 1
	and gapratesrevisionid  = '362f5b42-bc96-4209-80cf-e93b87e211b4';

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-8539',
	updatedon = now()
where guardiansubsidyid  = 'fb95d130-a7d2-489a-aa5d-d6365bde3227'
	and approvalstatustypekey = '3047'
	and activeflag  = 1
	and gapratesrevisionid  = '362f5b42-bc96-4209-80cf-e93b87e211b4';