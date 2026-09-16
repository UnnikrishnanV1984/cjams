-- CDM-25796 - Guardianship
/*
-- Issue Description: 
   User Request to change GAP subsidy rate from $887.86 to $887.00
   
-- Case ID: 3266667
-- Client ID: 3926838 (AYLAH RAEL LEEMYERS) - 01a1fc9f-e549-4f01-a390-715e9ea5b26a
-- GAP ID: 1006173 - 2022-09-30 to 2030-03-25 - 0b833714-7603-4d40-a048-a1ee9cd68c59
-- Provider ID: 6004947 (Maryam Abdulaziz)

-- Rate Fix as $887.00 (old value is $887.86 )
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- GAP Agreement Rate ID: '7a27ba10-fffa-4f7a-a6b0-78e28b481172'
-- Update Rate
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '7a27ba10-fffa-4f7a-a6b0-78e28b481172'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 887.00,
	updatedby = 'CDM-25796',
	updatedon = now()
where gapagreementrateid = '7a27ba10-fffa-4f7a-a6b0-78e28b481172'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '7a27ba10-fffa-4f7a-a6b0-78e28b481172' ;

update gapratesrevision 
set paymentamt = 887.00,
	approvaldate = now(),
	updatedby = 'CDM-25796',
	updatedon = now()
where gaprateid = '7a27ba10-fffa-4f7a-a6b0-78e28b481172' ;
