-- CDM-21144 - No Payments
/*
-- Issue Description: 
	Payments should have started December 8, 2021 to present. 
	The payments for Toniyah Johnson (2336982) nave not generated. 
	
-- Case ID: 3164797
-- Client ID: 2336982 (TONIYAH TYONA JOHNSON) - fa58b20b-b441-49ea-a5df-a10645e3988e
-- GAP ID: 1005929 - Null To 2023-12-17 - 74c61562-e879-45bc-a1de-8cddb8251116
-- Provider ID: 6003636	(SHARONDA Y JOHNSON)- Local Department Home
-- Start Date: 12/08/2021

-- Category/ Module: GAP (Case Management) 
-- Root cause:  This error was introduced with GAP refinement user story in Dec 2021 
--				and the code fix are done for this issue. This is one of the GAP created back then.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 12/08/2021 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '74c61562-e879-45bc-a1de-8cddb8251116'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-08 04:00:00',
	updatedby = 'CDM-21144',
	updatedon = now()
where gapid = '74c61562-e879-45bc-a1de-8cddb8251116'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '74c61562-e879-45bc-a1de-8cddb8251116' ;

update gapagreementrevision
set startdate = '2021-12-08 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21144',
	updatedon = now()
where gapid = '74c61562-e879-45bc-a1de-8cddb8251116' ;
