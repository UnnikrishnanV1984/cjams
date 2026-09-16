-- CDM-25873 - Payment issue - GAP
/*
-- Issue Description: 
   User Request to change GAP subsidy rate start & end dates 
   
-- Case ID: 3184485
-- Client ID: 2218346 (AVIANASHBY ANDRE ATKINSON) - 3cbf4494-adc8-48de-a264-6cb48b9541fb
-- GAP ID: 2437 - 2012-08-22 to 2024-09-03 - 930e8cb9-74d9-4f37-80e5-6435fc1d6e88
-- Provider ID: 5025346 (Ashby Coles) 
-- Rate ID: 556758bf-bee5-44e2-b94b-ebb0387362e0 -$616.00 
-- 			New: 2021-08-22 To 2022-08-21 
-- 			Old: 2022-08-22 To 2023-08-21 
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- GAP Agreement Rate ID: '556758bf-bee5-44e2-b94b-ebb0387362e0'
-- Update Rate
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '556758bf-bee5-44e2-b94b-ebb0387362e0'
	and activeflag = 1 ;

update gapagreementrate 
set startdate = '2021-08-22 07:00:00',	
	enddate = '2022-08-21 07:00:00',
	updatedby = 'CDM-25873',
	updatedon = now()
where gapagreementrateid = '556758bf-bee5-44e2-b94b-ebb0387362e0'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '556758bf-bee5-44e2-b94b-ebb0387362e0' ;

update gapratesrevision 
set ratestartdate = '2021-08-22 07:00:00',	
	rateenddate = '2022-08-21 07:00:00',
	approvaldate = now(),
	updatedby = 'CDM-25873',
	updatedon = now()
where gaprateid = '556758bf-bee5-44e2-b94b-ebb0387362e0' ;
