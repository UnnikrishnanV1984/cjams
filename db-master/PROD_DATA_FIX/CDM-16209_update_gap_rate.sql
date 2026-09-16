-- CDM-16209 - GAP Rate Exceeds Foster Care Rate
/*
-- Issue Description: 
   Incorrect GAP Rate $29.16
   
-- Case ID: 3252018 
-- Client ID: 3128184
-- Rate Fix to $887 (old value is $29.16)
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate
update gapagreementrate 
set paymentamout = 887,
	enddate = '2022-06-30 04:00:00',
	updatedby = 'CDM-16209',
	updatedon = now()
where gapagreementid = '5c9da59a-a810-4511-a479-afb5df7f6a16'
	and gapagreementrateid = '256d97bd-619e-43fa-ac47-0745855c0b75'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
update gapratesrevision 
set paymentamt = 887,
	rateenddate = '2022-06-30 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-16209',
	updatedon = now()
where guardiansubsidyid = '8467196c-5ee0-43b8-ae2a-886b3cf6d1e6'
	and gaprateid = '256d97bd-619e-43fa-ac47-0745855c0b75' 
	and activeflag = 1 ;
