-- CDM-20283 - Payment hasn't generated for Provider
/*
-- Issue Description: 
   The Payment for the Provider ( Nyeshia Brunson) has not populated although the Subsidy Rate has been approved.

-- Case ID: 3282459
-- Client ID: 4165398 (JAYLEN MCKOY) - 03a96cd3-ff6c-4a5f-b71b-a56d9d3b786d
-- GAP ID: 1005875 - NULL To 2026-12-26 - 71db41ae-5350-423c-b5a0-1770ed7b808e
-- Provider ID: 5088666	(Nyeshia Brunson)
-- Strat Date: 10/08/2021

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 10/08/2021 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '71db41ae-5350-423c-b5a0-1770ed7b808e'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-10-08 04:00:00',
	updatedby = 'CDM-20283',
	updatedon = now()
where gapid = '71db41ae-5350-423c-b5a0-1770ed7b808e'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '71db41ae-5350-423c-b5a0-1770ed7b808e' ;

update gapagreementrevision
set startdate = '2021-10-08 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20283',
	updatedon = now()
where gapid = '71db41ae-5350-423c-b5a0-1770ed7b808e' ;
