-- CDM-21259 - GAP Subsidy Payments missing
/*
-- Issue Description: 
	The GAP subisdy payments are not being generated for Joel Client ID-4360978. 
	The provider is missing the subsidy payments since the case closed on 12/13/21. 
	
-- Case ID: 3298169
-- Client ID: 4360978 (JOEL	R DELGADILLO) - e882b58b-7400-476b-8ea1-4f605e6a1003
-- GAP ID: 1005972 - NUll To 2026-07-15 - ea08d3fa-f2f6-4035-b727-164266ba9cfd
-- Provider ID: 6001573	(Jennifer Delgadillo)
-- Start Date: 2021-12-13

-- Category/ Module: GAP (Case Management) 
-- Root cause:  This error was introduced with GAP refinement user story in Dec 2021 
--				and the code fix are done for this issue. This is one of the GAP created back then.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 12/13/2021 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'ea08d3fa-f2f6-4035-b727-164266ba9cfd'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-13 04:00:00',
	updatedby = 'CDM-21259',
	updatedon = now()
where gapid = 'ea08d3fa-f2f6-4035-b727-164266ba9cfd'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'ea08d3fa-f2f6-4035-b727-164266ba9cfd' ;

update gapagreementrevision
set startdate = '2021-12-13 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21259',
	updatedon = now()
where gapid = 'ea08d3fa-f2f6-4035-b727-164266ba9cfd' ;
