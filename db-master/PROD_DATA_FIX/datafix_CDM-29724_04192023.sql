-- CDM-29724 - Correction needed
/*
-- Issue Description: 
   User Request to change GAP Subsidy Agreement start date as 02/16/2023

-- Case ID: 3282867
-- Client ID: 200801490 (Beau Ty Hancock) - ca590fce-08d6-4356-a8e9-3e797b414a20
-- GAP ID: 1008066 - 2023-03-01 To 2039-08-31 - ab1944d9-7742-4dbb-afa0-20126fba8b74
-- Provider ID: 6005739	(Kerrie Strobel) 
-- Rate ID: f0f6ecc6-b9d6-4f58-83b7-6077c29f1afe - 2023-02-16 To 2024-02-15 - $806.04

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
where gapagreementid = '65cdf4ff-34e8-48e2-a9be-4224b5c6a779'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2023-02-16 10:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-29724'
where gapagreementid = '65cdf4ff-34e8-48e2-a9be-4224b5c6a779'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'f0f6ecc6-b9d6-4f58-83b7-6077c29f1afe' ;

update gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-29724',
	updatedon = now()
where gaprateid = 'f0f6ecc6-b9d6-4f58-83b7-6077c29f1afe' ;

