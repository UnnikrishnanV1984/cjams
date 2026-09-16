-- CDM-21208 - GAP Approval Issue
/*
-- Issue Description: 
   User is not able to approve the subsidy rate for GAP.
   And another request to change the Rate start date of GAP.

-- Case ID: 3293217
-- Client ID: 4495086 (VICTORIA	JADE NAYLOR-WILLEY) - c0cd74a0-804d-45de-8483-4d07f24c26a9
-- GAP ID: 1005943 - 2021-12-02 To 2036-11-07 - 7aeb995e-98a5-4bac-b738-5fc18b27a231
-- Approval Issue

-- Case ID: 3293217
-- Client ID: 4106238 (LORI	L NAYLOR) - e7e3e43e-a383-41f7-8691-bd9f6ef39408
-- GAP ID: 1005942 - 2021-12-02 To 2035-02-03 - 3404d334-a118-4b67-a6f4-154407345b91
-- Update Rate start date as 2/1/2022

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3293217
-- Client ID: 4495086 (VICTORIA	JADE NAYLOR-WILLEY) - c0cd74a0-804d-45de-8483-4d07f24c26a9
-- GAP ID: 1005943 - 2021-12-02 To 2036-11-07 - 7aeb995e-98a5-4bac-b738-5fc18b27a231
-- Approval Issue

-- Update from user as Tara Feldman 33c6c8d1-e0b7-4227-99bf-6668db2f655e
-- to Supervisor Susan Loysen 4103969d-6c19-4065-8d86-fa7706680634	
-- Team a2311121-a429-497b-91ad-18fdc1574819

select insertedby, updatedby, updatedon, activeflag 
from gapagreementrate
where gapagreementrateid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

update gapagreementrate
set insertedby = '33c6c8d1-e0b7-4227-99bf-6668db2f655e', -- Tara Feldman
	updatedby = 'CDM-21208',
	updatedon = now()
where gapagreementrateid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

select insertedby, updatedby, updatedon, activeflag 
from gapratesrevision 
where gaprateid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

update gapratesrevision
set insertedby = '33c6c8d1-e0b7-4227-99bf-6668db2f655e', -- Tara Feldman
	updatedby = 'CDM-21208',
	updatedon = now()
where gaprateid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

select eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
	insertedby, updatedby, updatedon, activeflag
from routing  
where objectid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

update routing
set fromsecurityusersid = '33c6c8d1-e0b7-4227-99bf-6668db2f655e', -- Tara Feldman
	tosecurityusersid = '4103969d-6c19-4065-8d86-fa7706680634', -- Susan Loysen
	teamid = 'a2311121-a429-497b-91ad-18fdc1574819',
	insertedby = '33c6c8d1-e0b7-4227-99bf-6668db2f655e', -- Tara Feldman
	updatedby = 'CDM-21208',
	updatedon = now()
where objectid = 'd4499393-dfe1-4c33-8aeb-974323cfc45f' ;

--------------------------------
-- Case ID: 3293217
-- Client ID: 4106238 (LORI	L NAYLOR) - e7e3e43e-a383-41f7-8691-bd9f6ef39408
-- GAP ID: 1005942 - 2021-12-02 To 2035-02-03 - 3404d334-a118-4b67-a6f4-154407345b91
-- Update Rate start date as 2/1/2022

-- Update most recent GAP Rate Slab Dates as 2022-02-01 05:00:00 To 2023-01-31 05:00:00
-- (Current Rate Dates: 2021-12-02 05:00:00	2022-12-01 05:00:00)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-02-01 05:00:00',
	enddate = '2023-01-31 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-21208'
where gapagreementrateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93';

update gapratesrevision
set ratestartdate = '2022-02-01 05:00:00',
	rateenddate = '2023-01-31 05:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-21208'
where gaprateid = '9e30de4c-b443-4cb8-9d4f-6cefa8047f93';

