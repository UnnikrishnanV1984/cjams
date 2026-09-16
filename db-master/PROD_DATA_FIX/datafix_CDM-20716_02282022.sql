-- CDM-20716 - GAP Payment Issue
/*
-- Issue Description: 
   User request to update GAP Rate Slab Dates as 02/01/2022 To 01/31/2023

-- Case ID: 3293217
-- Client ID: 4106238 (LORI	L NAYLOR) - e7e3e43e-a383-41f7-8691-bd9f6ef39408
-- GAP ID: 1005942 - 2021-12-02 To 2035-02-03 0 3404d334-a118-4b67-a6f4-154407345b91
-- Approved Rate need fix: 02/01/2022 To 12/01/2022

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update most recent GAP Rate Slab Dates as 02/01/2022 To 01/31/2023 (Current Rate Dates: 2021-12-02 To 2022-12-01)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-02-01 00:00:00',
	enddate = '2023-01-31 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-20716'
where gapagreementrateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93';

update gapratesrevision
set ratestartdate = '2022-02-01 00:00:00',
	rateenddate = '2023-01-31 05:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-20716'
where gaprateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93';

-- Update GAP Start Date as 02/01/2022 (current value is 2021-12-02)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '3404d334-a118-4b67-a6f4-154407345b91'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2022-02-01 04:00:00',
	updatedby = 'CDM-20716',
	updatedon = now()
where gapid = '3404d334-a118-4b67-a6f4-154407345b91'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '3404d334-a118-4b67-a6f4-154407345b91' ;

update gapagreementrevision
set startdate = '2022-02-01 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20716',
	updatedon = now()
where gapid = '3404d334-a118-4b67-a6f4-154407345b91' ;
