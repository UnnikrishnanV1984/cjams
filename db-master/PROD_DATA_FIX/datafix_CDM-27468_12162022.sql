-- CDM-27468 - GAP Subsidy Payment
/*
-- Issue Description: 
   User Request to change GAP subsidy most recent rate start date 
   
-- Case ID: 3174793
-- Client ID: 3229641 (KIDEN SUKARA	DISTEFANO) - 1867164d-adb3-4c77-81a4-b1078e6b1b0e
-- GAP ID: 3091 - 2013-12-06 To 2029-04-23 - e49c8ec1-8ea5-4c19-b04b-b3ca32916017
-- Provider ID: 5061667	(Karen Palmer)
-- gapagreementid: '36163185-c833-4c5b-a6b8-5970285fe26c'
-- gapagreementrateid: 8910f725-9a4c-4c2a-ad62-e5af38e884a0
-- update Rate start date as  2022-11-09 05:00:00 (old value 2022-12-06 05:00:00)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Rate Start Date as 2022-11-09 (old value is 2022-12-06)
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '8910f725-9a4c-4c2a-ad62-e5af38e884a0'
	and activeflag = 1 ;

update gapagreementrate 
set startdate = '2022-11-09 05:00:00',
	updatedby = 'CDM-27468',
	updatedon = now()
where gapagreementrateid = '8910f725-9a4c-4c2a-ad62-e5af38e884a0'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '8910f725-9a4c-4c2a-ad62-e5af38e884a0' ;

update gapratesrevision 
set ratestartdate = '2022-11-09 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-27468',
	updatedon = now()
where gaprateid = '8910f725-9a4c-4c2a-ad62-e5af38e884a0' ;

