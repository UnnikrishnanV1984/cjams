-- CDM-16864 - Checks
/*
-- Issue Description: 
   The guardian is not receiving her checks (June, July, and August)

-- Case ID: 3283756 - 89385aea-ce65-422f-a21e-ff7e0812fc06
-- Client ID: 4121544 (AMELIA M	DALTON) - b3baf387-e54b-4811-974f-995472b1237e
-- GAP ID: 1005657 - 2021-01-04 To 2036-08-21 - 9b2023a1-4803-4491-a820-19a9c2762f5f
-- Provider ID: 6002048	(Mary Bladen)
   
-- Category/ Module: GAP Accounts Payable (Finance Management) 
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Note: This GAP was having a data issue, inactive actor id in the permanencyplan table.
-- That was fixed as part of CDM-16033,

-- This fix is to trigger Under/Over 
select startdate, enddate, approvalstatustypekey, approvaldate, updatedby, updatedon 
	from gapagreementrevision
where gapid = '9b2023a1-4803-4491-a820-19a9c2762f5f' ;
	
update gapagreementrevision 
set approvaldate = now(),
	updatedby = 'CDM-16864',
	updatedon = now()
where gapid = '9b2023a1-4803-4491-a820-19a9c2762f5f' ;
