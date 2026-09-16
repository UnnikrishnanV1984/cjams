-- CDM-20741 - Payment did not generate
/*
-- Issue Description: 
   The payments for Michael Fulford (4062901) did not generate.

-- Case ID: 3274929
-- Client ID: 4062901 (MICHAEL EDEN	FULFORD) - 1706bf8d-3c63-48c1-a47d-916166ab49fb
-- GAP ID: 1005936 - Null TO 2035-02-26 - b3a44568-e623-4df4-9f8b-ae1a671a4904
-- Provider ID: 5095254	(Candy Lewis)
-- Start Date: 12/13/2021 

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 12/13/202 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'b3a44568-e623-4df4-9f8b-ae1a671a4904'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-13 04:00:00',
	updatedby = 'CDM-20741',
	updatedon = now()
where gapid = 'b3a44568-e623-4df4-9f8b-ae1a671a4904'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'b3a44568-e623-4df4-9f8b-ae1a671a4904' ;

update gapagreementrevision
set startdate = '2021-12-13 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20741',
	updatedon = now()
where gapid = 'b3a44568-e623-4df4-9f8b-ae1a671a4904' ;

