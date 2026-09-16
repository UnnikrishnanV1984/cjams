-- CDM-21252 - Payment Issue
/*
-- Issue Description: 
   User request to update GAP Rate Slab Dates as 2/1/2022 - 1/31/2023.

-- Case ID: 3088778
-- Cleint ID: 1549999 (CHASE W SAWYER) - 05e641c5-1fbd-442e-8915-de342cdf1f75
-- GAP ID: 1679 - 2011-07-01 To 2027-10-26 - 616c5234-cdfd-4c48-9b59-0c3519ae9561
-- Provider ID: 5051616	(Rebecca Webster)
-- Rate ID: fa2c59a6-6a02-4970-90a2-aa6b6c469a35 update start date as 2022-02-01

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update most recent GAP Rate Slab Dates as 02/01/2022 To 01/31/2023
-- (Current Rate Dates: 2022-02-23 To 2023-01-31)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'fa2c59a6-6a02-4970-90a2-aa6b6c469a35'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-02-01 15:00:00',
	-- enddate = '2023-01-31 10:00:00',
	updatedon = now(), 
	updatedby = 'CDM-21252'
where gapagreementrateid = 'fa2c59a6-6a02-4970-90a2-aa6b6c469a35'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'fa2c59a6-6a02-4970-90a2-aa6b6c469a35';

update gapratesrevision
set ratestartdate = '2022-02-01 15:00:00',
	-- rateenddate = '2023-01-31 10:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-21252'
where gaprateid = 'fa2c59a6-6a02-4970-90a2-aa6b6c469a35';
