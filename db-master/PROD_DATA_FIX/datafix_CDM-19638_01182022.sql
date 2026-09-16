-- CDM-19638 - Guardianship subsidy review
/*
-- Issue Description: 
	User request to change the GAP Rate Start date as 11/01/2021 for 2 GAP cases

-- Case ID: 3190378
-- Client ID: 3148121 (KENDALL ELSIEJANE PULLIAM) - be6a7c20-a83d-48dc-b890-1fe1fb83e8fc
-- GAP ID: 2347 - 2012-07-11 To 2028-10-27 - fb9dba5b-3008-4f2e-bf74-eb47cd8e0886
-- Provider ID: 5059018 (Toby Pulliam)

-- Case ID: 3191217
-- Client ID: 3119581 (TONI KING) - c4ef6951-2efa-438f-856a-a247d1ad0c4e
-- GAP ID: 3686 - 2015-01-14 To 2028-01-08 - 48ba88b9-601b-4ec4-925e-da2dc9c282dd
-- Provider ID: 5073887	(Melissa King)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3148121 (KENDALL ELSIEJANE PULLIAM) - be6a7c20-a83d-48dc-b890-1fe1fb83e8fc
-- Update GAP Rate Start Date as 11/01/2021 (old value is 12/01/2021)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'be75695f-4824-40e3-8152-6cf48071dbe2'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-11-01 10:00:00',
--	enddate = '2022-10-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19638'
where gapagreementrateid = 'be75695f-4824-40e3-8152-6cf48071dbe2'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'be75695f-4824-40e3-8152-6cf48071dbe2';

update gapratesrevision
set ratestartdate = '2021-11-01 10:00:00',
--	rateenddate = '2022-10-31 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-19638'
where gaprateid = 'be75695f-4824-40e3-8152-6cf48071dbe2';

-- Client ID: 3119581 (TONI KING) - c4ef6951-2efa-438f-856a-a247d1ad0c4e
-- Update GAP Rate Start Date as 11/01/2021 (old value is 12/17/2021)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'fa2af9fa-9176-4481-b67a-3f0983eedd22'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-11-01 10:00:00',
--	enddate = '2022-10-31 08:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19638'
where gapagreementrateid = 'fa2af9fa-9176-4481-b67a-3f0983eedd22'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'fa2af9fa-9176-4481-b67a-3f0983eedd22';

update gapratesrevision
set ratestartdate = '2021-11-01 10:00:00',
--	rateenddate = '2022-10-31 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-19638'
where gaprateid = 'fa2af9fa-9176-4481-b67a-3f0983eedd22';
