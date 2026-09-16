-- CDM-19158 - Finance
/*
-- Issue Description: 
	Mason Weaver #3240141 - The dates for the GAP Subsidy were entered wrong. 
    Start dates needs to be Sept. 15, 2021 - December 15, 2021. 
    Provider has not received payments for Sept. 15, 2021 to present.

-- Case ID: 3240141
-- Client ID: 3672877 (MASON WEAVER) - e4b5f2bd-00cf-4165-b270-c2440711271d
-- GAP ID: 4036 - 2015-12-16 To 2024-02-08 - 7460ea62-265d-4d44-920c-d20a63fd2dac
-- Provider ID: 5073852	(Kimberly Weaver)
-- Rate slab: 2020-12-16 To 2021-09-15 - $835 - 993ada9d-f9e4-4cf2-8d67-b81d7016321a
-- New End Date:  2021-12-15

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Rate End Date as 2021-12-15 (old value is 2021-09-15)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = '993ada9d-f9e4-4cf2-8d67-b81d7016321a'
	and activeflag = 1 ;
	
update gapagreementrate  
set enddate = '2021-12-15 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19158'
where gapagreementrateid = '993ada9d-f9e4-4cf2-8d67-b81d7016321a'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = '993ada9d-f9e4-4cf2-8d67-b81d7016321a';

update gapratesrevision
set rateenddate = '2021-12-15 00:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-19158'
where gaprateid = '993ada9d-f9e4-4cf2-8d67-b81d7016321a';
