-- CDM-11959 - Non-Payment of February Payment (covering the period of 1/1/21 - 1/31/21) for Kire' McCutheon
/*
-- Issue Description: 
   Missing GAP payment for Jan 2021 
   
   Case ID: 3204479 
   Client ID: 3280031 (KIRE	MCCUTCHEON) - d28c359c-e1d8-4e85-9f87-7d2ba7834a1c
   GAP ID: 2450 - 2012-08-09 to 2024-02-19 - 015432a8-dcfe-4c2b-896a-192b3316c85d
   Provider ID: 5055677	(Maureen Longus)

   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Exception scenario
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to trigger Under/Over for generating Jan 2021 payment
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon 
	from cjams.gapratesrevision 
where gapratesrevisionid = '5aa356e1-abe9-4c4f-9a90-a76cb291ed6b'
	and activeflag = 1 ;
	   
update cjams.gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-11959',
	updatedon = now()
where gapratesrevisionid = '5aa356e1-abe9-4c4f-9a90-a76cb291ed6b'
	and activeflag = 1 ;