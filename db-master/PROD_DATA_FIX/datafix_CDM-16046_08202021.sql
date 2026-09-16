-- CDM-16046 - Accounts Receivable
/*
-- Issue Description: 
   Incorrect GAP Start date 
   
-- Case ID: 3165327 - sherrie.ford@maryland.gov
-- Client ID: 2053311 (CHAUNCY GOLDEN) - b4314855-1837-41cf-800a-758da73ac862
-- Provider ID: 5078675	(April Dortch)
-- GAP ID: 4016 - 06/03/2019 To 05/10/2022 - 8f93f93c-fffb-45ac-ab73-c48b244b0876

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update GAP start date as 2016-06-03 00:00:00 
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '8f93f93c-fffb-45ac-ab73-c48b244b0876'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2016-06-03 00:00:00',
	updatedby = 'CDM-16046',
	updatedon = now()
where gapid = '8f93f93c-fffb-45ac-ab73-c48b244b0876'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select startdate, enddate, approvalstatustypekey, approvaldate, updatedby, updatedon 
	from gapagreementrevision
where gapid = '8f93f93c-fffb-45ac-ab73-c48b244b0876' ;
	
update gapagreementrevision 
set startdate = '2016-06-03 00:00:00',
	approvaldate = now(),
	updatedby = 'CDM-16046',
	updatedon = now()
where gapid = '8f93f93c-fffb-45ac-ab73-c48b244b0876' ;
	