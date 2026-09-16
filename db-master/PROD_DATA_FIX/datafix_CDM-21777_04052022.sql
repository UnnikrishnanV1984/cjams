-- CDM-21777 - Provider payments not generating
/*
-- Issue Description: 
	The GAP payments are not generating for for Jayden Smith's #4217743
	GAP are not processing for the provider Yolanda Dale #5089089.

-- Case ID: 3286587 - cynthia.cobb@maryland.gov
-- Client ID: 4217743 (JAYDEN SMITH) - 57241a00-0b40-4db4-bcd5-adce2bf2a0d1
-- GAP ID: 1005860 - Null To 2033-09-10 - 96d9e634-1b74-4c6c-a4e0-cdab0cbe0869
-- Provider ID: 5089089	(Yolanda Dale) 
-- Start Date: 2021-06-30
-- gapagreementid: 8c50c9c6-a96a-4842-b1e0-9de0338fc037

-- Category/ Module: GAP (Case Management) 
-- Root cause:  This error was introduced with GAP refinement user story in Dec 2021 
--				and the code fix are done for this issue. This is one of the GAP created back then.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 2021-06-30 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapagreementid = '8c50c9c6-a96a-4842-b1e0-9de0338fc037'	
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-06-30 08:00:00',
	updatedby = 'CDM-21777',
	updatedon = now()
where gapagreementid = '8c50c9c6-a96a-4842-b1e0-9de0338fc037'	
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapagreementid = '8c50c9c6-a96a-4842-b1e0-9de0338fc037' ;

update gapagreementrevision
set startdate = '2021-06-30 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21777',
	updatedon = now()
where gapagreementid = '8c50c9c6-a96a-4842-b1e0-9de0338fc037' ;
