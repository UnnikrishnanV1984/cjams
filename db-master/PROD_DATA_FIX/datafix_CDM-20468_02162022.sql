-- CDM-20468 - Cannot Submit Subsidy rate
/*
-- Issue Description: 
   To Update most recent GAP Rate Slab Dates as 03/01/2022 To 02/28/2023

-- Case ID: 3173201
-- Client ID: 2606154 (JOHN	R RIDGLEY) - b608bff0-0aae-4939-86e3-0b7b533e547e
-- GAP ID: 1198 - 2010-06-14 To 2024-03-27 - 7375afa7-592a-4a7c-9ee4-5ef1252aba98
-- Provider ID: 5042366	(Laurie Ridgley)

-- 72415af5-d9f0-4524-9a18-5e32abef9410	2021-03-01 00:00:00	2022-02-28 05:00:00
-- 2022-03-01 00:00:00	2023-02-28 05:00:00

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update most recent GAP Rate Slab Dates as 2022-03-01 To 2023-02-28 (old value 2021-03-01 To 2022-02-28)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = '72415af5-d9f0-4524-9a18-5e32abef9410'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-03-01 00:00:00',
	enddate = '2023-02-28 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-20468'
where gapagreementrateid = '72415af5-d9f0-4524-9a18-5e32abef9410'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = '72415af5-d9f0-4524-9a18-5e32abef9410';

update gapratesrevision
set ratestartdate = '2022-03-01 00:00:00',
	rateenddate = '2023-02-28 05:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-20468'
where gaprateid = '72415af5-d9f0-4524-9a18-5e32abef9410';
