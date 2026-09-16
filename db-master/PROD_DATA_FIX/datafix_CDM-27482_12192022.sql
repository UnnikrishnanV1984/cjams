-- CDM-27482 - Provider Payment
/*
-- Issue Description: 
   User Request to change GAP subsidy most recent rate start date 

-- Case ID: 3159670
-- Client ID: 2200323 (ANIYA ALVARADO) - 2950b80e-cc0e-4fd3-8722-971a3145ed20
-- GAP ID: 4687 - 2017-12-06 To 2025-11-12 - d41b99ba-b508-4c0d-8c6b-1a262214b4da
-- gapagreementid: e3d588fa-5c32-4a9d-b3ad-10de69f01f2a
-- gapagreementrateid: 0020c0aa-764b-41e8-aead-ec85a9006bd9	
-- Rate Salb: 2022-12-06 To	2023-12-05 - $867.00 Approved
-- Update start Date as 2022-10-26 

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Update GAP Rate Start Date as 10/26/2022 (old value is 12/06/2022)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Rate Start Date as 10/26/2022 (old value is 12/06/2022)
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '0020c0aa-764b-41e8-aead-ec85a9006bd9'
	and activeflag = 1 ;

update gapagreementrate 
set startdate = '2022-10-26 05:00:00',
	enddate = '2023-10-25 05:00:00',
	updatedby = 'CDM-27482',
	updatedon = now()
where gapagreementrateid = '0020c0aa-764b-41e8-aead-ec85a9006bd9'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '0020c0aa-764b-41e8-aead-ec85a9006bd9' ;

update gapratesrevision 
set ratestartdate = '2022-10-26 05:00:00',
	rateenddate = '2023-10-25 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-27482',
	updatedon = now()
where gaprateid = '0020c0aa-764b-41e8-aead-ec85a9006bd9' ;

