-- CDM-36322 - Finance issue: Adjustment did not generate
/*
-- Issue Description: 
   User request to update the below the GAP Rates:

-- Case ID: 2020020901987 - morgan.evans@maryland.gov

-- Client ID: 2264213 (Mijae A Moore) - 7c714913-8957-4234-bd46-9e603bb7c44b
-- GAP ID: 12/27/2023 12/26/2024 ae587227-c0eb-4a07-9ad6-109e39db78b8
-- Update subsidy rate amount from $887 to $902
-- gapagreementid = '75ba562d-d855-4d96-8134-0526fcfc116b'

  
-- Category/ Module: Permanancy Plan 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid = '75ba562d-d855-4d96-8134-0526fcfc116b'
	and gapagreementrateid = 'facff86f-91bc-4c19-b086-17bc6239e115'
	and activeflag = 1;

update gapagreementrate 
set paymentamout = 902.00,
	updatedby = 'CDM-36322',
	updatedon = now()
where gapagreementid = '75ba562d-d855-4d96-8134-0526fcfc116b'
	and gapagreementrateid = 'facff86f-91bc-4c19-b086-17bc6239e115'
	and activeflag = 1;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = 'ae587227-c0eb-4a07-9ad6-109e39db78b8'
	and gaprateid = 'facff86f-91bc-4c19-b086-17bc6239e115'
	and activeflag = 1;

update gapratesrevision 
set paymentamt = 902.00,
	approvaldate = now(),
	updatedby = 'CDM-36322',
	updatedon = now()
where guardiansubsidyid = 'ae587227-c0eb-4a07-9ad6-109e39db78b8'
	and gaprateid = 'facff86f-91bc-4c19-b086-17bc6239e115'
	and activeflag = 1;
