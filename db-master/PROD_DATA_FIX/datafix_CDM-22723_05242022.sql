-- CDM-22723 - Change subsidy begin date
/*
-- Issue Description: 
   User request to update the GAP rate start date as The 03/14/2022 for Successor Guardian

-- Case ID: 3206373
-- Client ID: 3376073 (JARRETT A MCBURROUGHS) - 86029950-15fd-41a6-9b6f-1fe84155abc8
-- GAP ID: 4392 - 2017-02-02 To 2029-11-21 - 1b16eb8a-d3c3-4e8a-bd28-a29510e66811
-- Successor Provider ID: 6006138 (Ivan	Beauchamps)
-- Old Provider ID: 5073693	(Velesha L Burke) - Local Department Home
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate end date as 03/13/2022 - (5073693)
-- Old Values 2022-02-02 To 2022-05-20 
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '31a7a5c3-68bc-4853-b7a6-427b4895a2c0'
	and activeflag = 1 ;

update gapagreementrate 
set enddate = '2022-03-13 04:00:00',
	updatedby = 'CDM-22723',
	updatedon = now()
where gapagreementrateid = '31a7a5c3-68bc-4853-b7a6-427b4895a2c0'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select providerid, approvalstatustypekey, approvaldate, ratestartdate, rateenddate, 
		paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '31a7a5c3-68bc-4853-b7a6-427b4895a2c0' ;

update gapratesrevision 
set rateenddate = '2022-03-13 10:00:00',
	approvaldate = now(),
	updatedby = 'CDM-22723',
	updatedon = now()
where gaprateid = '31a7a5c3-68bc-4853-b7a6-427b4895a2c0' ;


-- update start & end dates as 03/14/2022 To 03/13/2023 - (6006138)
-- Old Values 2022-05-21 To 2023-05-20 
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '324e3abe-cbae-4aef-896a-7d6868054d26'
	and activeflag = 1 ;

update gapagreementrate 
set startdate = '2022-03-14 08:00:00',
	enddate = '2023-03-13 04:00:00',
	updatedby = 'CDM-22723',
	updatedon = now()
where gapagreementrateid = '324e3abe-cbae-4aef-896a-7d6868054d26'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select providerid, approvalstatustypekey, approvaldate, ratestartdate, rateenddate, 
		paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '324e3abe-cbae-4aef-896a-7d6868054d26' ;

update gapratesrevision 
set ratestartdate = '2022-03-14 08:00:00',
	rateenddate = '2023-03-13 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-22723',
	updatedon = now()
where gaprateid = '324e3abe-cbae-4aef-896a-7d6868054d26' ;
