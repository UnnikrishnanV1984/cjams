-- CDM-20083 - Gap start date
/*
-- Issue Description: 
	User request to change the GAP Rate Start date as 11/01/2021 for 2 GAP cases

-- Case ID: 3275316
-- Client ID: 3991613 (LAMONT DREWELL CAREY) - 742b86dd-1d5b-47aa-bdf7-560047336a27
-- GAP ID: 4814 - 2018-03-07 To 2024-01-28 - bbed3588-af24-43d1-94f5-2578ca13198c
-- Provider ID: 5088481	(Faith Brown)
-- Rate ID: b18b3ef4-2c99-41ab-8bb7-72b47b6c9a66

-- Case ID: 3191217
-- Client ID: 3169937 (KIARYN EL KING) - b6cfc34e-1803-43ac-b855-33c01673cd07
-- GAP ID: 3685 - 2015-01-14 To 2027-03-03 - aaaee832-58ad-4120-96a0-0dc1f0d63307
-- Provider ID: 5073887	(Melissa King)
-- Rate ID: d9c82684-3366-43ce-aebd-dcfffed92fc5 

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3991613 (LAMONT DREWELL CAREY) - 742b86dd-1d5b-47aa-bdf7-560047336a27
-- Update GAP Rate Start Date as 11/01/2021 (old value is 12/01/2021)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'b18b3ef4-2c99-41ab-8bb7-72b47b6c9a66'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-11-01 10:00:00',
--	enddate = '2022-10-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-20083'
where gapagreementrateid = 'b18b3ef4-2c99-41ab-8bb7-72b47b6c9a66'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'b18b3ef4-2c99-41ab-8bb7-72b47b6c9a66';

update gapratesrevision
set ratestartdate = '2021-11-01 10:00:00',
--	rateenddate = '2022-10-31 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-20083'
where gaprateid = 'b18b3ef4-2c99-41ab-8bb7-72b47b6c9a66';

-- Client ID: 3169937 (KIARYN EL KING) - b6cfc34e-1803-43ac-b855-33c01673cd07
-- Update GAP Rate Start Date as 11/01/2021 (old value is 12/17/2021)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'd9c82684-3366-43ce-aebd-dcfffed92fc5'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-11-01 10:00:00',
--	enddate = '2022-10-31 08:00:00',
	updatedon = now(), 
	updatedby = 'CDM-20083'
where gapagreementrateid = 'd9c82684-3366-43ce-aebd-dcfffed92fc5'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'd9c82684-3366-43ce-aebd-dcfffed92fc5';

update gapratesrevision
set ratestartdate = '2021-11-01 10:00:00',
--	rateenddate = '2022-10-31 08:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-20083'
where gaprateid = 'd9c82684-3366-43ce-aebd-dcfffed92fc5';
