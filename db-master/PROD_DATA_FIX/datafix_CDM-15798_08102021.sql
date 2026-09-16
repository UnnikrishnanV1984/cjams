-- CDM-15798 - GAP Rate Exceeds Foster Care Rate
/*
-- Issue Description: 
   Incorrect GAP Rate $866,345 for Case # 3273204 & Client # 4184018
   
-- Case ID: 3273204 
-- Client ID: 4184018 (BRANDON JACKSON) - b62ea007-6313-493f-9396-7343e0aba525
-- GAP ID: 5546 - 06/25/2020 To 12/02/2035 - 3b22c61b-3759-4884-999b-69f4cafda823
-- Rate Fix to $866.45 (old value is $866,345)
-- Provider ID: 5096108	(Charita Jackson-durosinmi) 

   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate
select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid = '678d3974-9d5c-4de6-87c0-2e6d9112601f'
	and gapagreementrateid = '53a07501-1c63-4662-b4a6-1e606a5491f9'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 866.45,
	updatedby = 'CDM-15798',
	updatedon = now()
where gapagreementid = '678d3974-9d5c-4de6-87c0-2e6d9112601f'
	and gapagreementrateid = '53a07501-1c63-4662-b4a6-1e606a5491f9'
	and activeflag = 1 ;


-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = '3b22c61b-3759-4884-999b-69f4cafda823'
	and gaprateid = '53a07501-1c63-4662-b4a6-1e606a5491f9' 
	and activeflag = 1 ;

update gapratesrevision 
set paymentamt = 866.45,
	approvaldate = now(),
	updatedby = 'CDM-15798',
	updatedon = now()
where guardiansubsidyid = '3b22c61b-3759-4884-999b-69f4cafda823'
	and gaprateid = '53a07501-1c63-4662-b4a6-1e606a5491f9' 
	and activeflag = 1 ;
