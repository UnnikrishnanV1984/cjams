-- CDM-21963 - Finance issue: Adjustment did not generate
/*
-- Issue Description: 
   User request to update the below 2 GAP Rates:

-- Case ID: 3253794 - kellie.warnick@maryland.gov

-- Client ID: 3668315 (JASMINE WOODING) - aca0aa86-41c4-45cb-8d91-e3367de9b6bc
-- GAP ID: 1005969 - 2022-02-08 To 2026-03-24 - 23f722ee-d9b6-4965-ae8e-4a3bfcd38a0e
-- Update subsidy rate amount is $269

-- Client ID: 3668313 (KHLOE M COSNER) - 440b8c7f-3a3c-438c-a9f7-9e3fc5b7ab01
-- GAP ID: 1005970 - 2022-02-08 To 2029-07-26 - c8854a92-5ba7-4498-ba7e-0ee3bdaccefd
-- Update subsidy rate amount is $1
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3668315 (JASMINE WOODING) - aca0aa86-41c4-45cb-8d91-e3367de9b6bc
-- GAP ID: 1005969 - 2022-02-08 To 2026-03-24 - 23f722ee-d9b6-4965-ae8e-4a3bfcd38a0e
-- Update subsidy rate amount is $269
-- gapagreementid = 'c131bb2a-f924-4dca-8e3e-16195a89a4e2'

select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid = 'c131bb2a-f924-4dca-8e3e-16195a89a4e2'
	and gapagreementrateid = 'cb075a71-7bd3-4809-bbc0-c7c493a951d9'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 269.00,
	updatedby = 'CDM-21963',
	updatedon = now()
where gapagreementid = 'c131bb2a-f924-4dca-8e3e-16195a89a4e2'
	and gapagreementrateid = 'cb075a71-7bd3-4809-bbc0-c7c493a951d9'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = '23f722ee-d9b6-4965-ae8e-4a3bfcd38a0e'
	and gaprateid = 'cb075a71-7bd3-4809-bbc0-c7c493a951d9' 
	and activeflag = 1 ;

update gapratesrevision 
set paymentamt = 269.00,
	approvaldate = now(),
	updatedby = 'CDM-21963',
	updatedon = now()
where guardiansubsidyid = '23f722ee-d9b6-4965-ae8e-4a3bfcd38a0e'
	and gaprateid = 'cb075a71-7bd3-4809-bbc0-c7c493a951d9' 
	and activeflag = 1 ;


-- Client ID: 3668313 (KHLOE M COSNER) - 440b8c7f-3a3c-438c-a9f7-9e3fc5b7ab01
-- GAP ID: 1005970 - 2022-02-08 To 2029-07-26 - c8854a92-5ba7-4498-ba7e-0ee3bdaccefd
-- Update subsidy rate amount is $1
-- gapagreementid = '57a82a4e-a44e-4c74-bd25-7b9525d5f2cc'

select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid = '57a82a4e-a44e-4c74-bd25-7b9525d5f2cc'
	and gapagreementrateid = '1e8f4388-312f-4a44-a1c0-bebc6eb6cb46'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 1.00,
	updatedby = 'CDM-21963',
	updatedon = now()
where gapagreementid = '57a82a4e-a44e-4c74-bd25-7b9525d5f2cc'
	and gapagreementrateid = '1e8f4388-312f-4a44-a1c0-bebc6eb6cb46'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = 'c8854a92-5ba7-4498-ba7e-0ee3bdaccefd'
	and gaprateid = '1e8f4388-312f-4a44-a1c0-bebc6eb6cb46' 
	and activeflag = 1 ;

update gapratesrevision 
set paymentamt = 1.00,
	approvaldate = now(),
	updatedby = 'CDM-21963',
	updatedon = now()
where guardiansubsidyid = 'c8854a92-5ba7-4498-ba7e-0ee3bdaccefd'
	and gaprateid = '1e8f4388-312f-4a44-a1c0-bebc6eb6cb46' 
	and activeflag = 1 ;
