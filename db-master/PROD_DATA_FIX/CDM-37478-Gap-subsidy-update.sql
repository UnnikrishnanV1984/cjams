-- CDM-37478 - Incorrect subsidy rate
/*
-- Issue Description: 
  Incorrect subsidy rate was submitted for 3693726 time period 12/03/23-02/03/24. 
  Rate of $1.00 should be $371.00
   
-- Case ID: 3242293
-- Client ID: MARKAYLIAH DAVIS (PID # 3693726) 
-- GAP ID: 3693726 - 12/03/23-02/03/24
-- Providre ID:5075069

-- Rate Fix to $371.00 (old value is $1)
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the GAP rate as $371.00
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rates


select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = 'e44fd959-fbf1-4625-9f73-bd3da4f98b1f'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 371.00,
	updatedby = 'CDM-37478',
	updatedon = now()
where gapagreementrateid = 'e44fd959-fbf1-4625-9f73-bd3da4f98b1f'
	and activeflag = 1 ;


-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'e44fd959-fbf1-4625-9f73-bd3da4f98b1f';

update gapratesrevision 
set paymentamt = 371.00,
	approvaldate = now(),
	updatedby = 'CDM-37478',
	updatedon = now()
where gaprateid = 'e44fd959-fbf1-4625-9f73-bd3da4f98b1f';