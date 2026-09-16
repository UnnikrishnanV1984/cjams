-- CDM-22703 - Board rate was entered incorrect
/*
-- Issue Description: 
   Worker entered the wrong board rate under the subsidy rate
   For client EMAHYA BIGESBY, the subsidy rate is mentioned as $29.33. 
   The amount should be changed as $892.

-- Case ID: 3294902
-- Client ID: 4296122 (EMAHYA ANDREYA BIGESBY) - e3b53466-559c-4356-a5d0-3224746aedd3
-- GAP ID :1006028 - 2022-03-17 To 2033-07-06 - fe26d131-32a1-410e-afd4-3784ccd97a05
-- gapagreementid: 6fe1bf38-d1cf-4daf-85ca-7ee32ec08141 
-- gapagreementrateid: 0278d399-c1b1-4218-ba05-4c89f6cb81b9
-- 2022-03-17 To	2023-03-16 - $29.33
-- Update subsidy rate amount is $892
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '0278d399-c1b1-4218-ba05-4c89f6cb81b9'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 892.00,
	updatedby = 'CDM-22703',
	updatedon = now()
where gapagreementrateid = '0278d399-c1b1-4218-ba05-4c89f6cb81b9'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '0278d399-c1b1-4218-ba05-4c89f6cb81b9' ;

update gapratesrevision 
set paymentamt = 892.00,
	approvaldate = now(),
	updatedby = 'CDM-22703',
	updatedon = now()
where gaprateid = '0278d399-c1b1-4218-ba05-4c89f6cb81b9' ;
