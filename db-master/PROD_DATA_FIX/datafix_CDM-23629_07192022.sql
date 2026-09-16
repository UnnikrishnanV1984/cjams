-- CDM-23629 - GAP subsidy incorrect
/*
-- Issue Description: 
   Tieon Hardy GAP subsidy rate was entered incorrectly for 887. 
   The provider has been approved for 27.95 per day. 
   The subsidy rate needs to be changed. 
   User Request to change subsidy rate as $850
   
-- Case ID: 3094731
-- Client ID: 2696921 (TIEON JERROD HARDY) - 14ef23f5-df9a-4c93-8859-5a55d72e4625
-- GAP ID: 1006049 - 2019-03-06 To 2023-02-27 - e2abc171-d5d5-4fb0-b3a4-9ef00d524c5f
-- Provider ID: 5081899	(Rachquel Winn)

-- Rate Fix to $850.00 (old value is $887.00)
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate
select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid = 'dcc431d4-e647-4b04-94b6-60bdfea79e1f'
	and gapagreementrateid = 'd2c98f79-7586-475d-b8cc-59af9a85d802'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 850.00,
	updatedby = 'CDM-23629',
	updatedon = now()
where gapagreementid = 'dcc431d4-e647-4b04-94b6-60bdfea79e1f'
	and gapagreementrateid = 'd2c98f79-7586-475d-b8cc-59af9a85d802'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = 'e2abc171-d5d5-4fb0-b3a4-9ef00d524c5f'
	and gaprateid = 'd2c98f79-7586-475d-b8cc-59af9a85d802' 
	and activeflag = 1 ;

update gapratesrevision 
set paymentamt = 850.00,
	approvaldate = now(),
	updatedby = 'CDM-23629',
	updatedon = now()
where guardiansubsidyid = 'e2abc171-d5d5-4fb0-b3a4-9ef00d524c5f'
	and gaprateid = 'd2c98f79-7586-475d-b8cc-59af9a85d802' 
	and activeflag = 1 ;
