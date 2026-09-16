-- CDM-29723 - Need correction
/*
-- Issue Description: 
   User Request to change GAP Subsidy Agreement start date as 02/16/2023

-- Case ID: 211030011065
-- Client ID: 200809686	(Shayna Clerkin) - 35b8f907-7f6b-4528-b6cf-4432217f76af
-- GAP ID: 1008033 - 2023-03-01 To 2036-10-23 - 84fa96d8-2ac0-4511-84e4-368c334f5ba8
-- Provider ID: 6019875	(Joshua Hernandez) 
-- Rate ID: c953b715-67cf-4e52-8c31-707828b49407 - 2023-02-16 To 2024-02-15 - $799.96 -- Approved	

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update GAP Subsidy Agreement start date as 02/16/2023 (old value is 2023-03-01)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Subsidy Agreement start date as 02/16/2023 (old value is 2023-03-01)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapagreementid = 'ebf12a5d-e95e-4a12-a0f4-9f16ae96e947'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2023-02-16 10:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-29723'
where gapagreementid = 'ebf12a5d-e95e-4a12-a0f4-9f16ae96e947'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'c953b715-67cf-4e52-8c31-707828b49407' ;

update gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-29723',
	updatedon = now()
where gaprateid = 'c953b715-67cf-4e52-8c31-707828b49407' ;

