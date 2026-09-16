-- CDM-21979 - Payment
/*
-- Issue Description: 
	The GAP subisdy payments are missing. 
	
-- Case ID: 2020019001739
-- Client ID: 200020378 (RAHMEEK K STEWART) - 3937ea0a-0902-4719-a670-99ff9e620c81
-- GAP ID: 1005852 - NUll To 2037-06-16 - c488231c-1bed-4bd5-a5e1-0e840bb69bc5
-- Provider ID: 6004136	(Deborah Evette Lewis) 
-- gapagreementid: 4d4c9230-e2a8-4e74-89b3-78827769b2cb
-- Start Date: 2021-09-21  

-- Category/ Module: GAP (Case Management) 
-- Root cause: N/A 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 09/21/2021  (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'c488231c-1bed-4bd5-a5e1-0e840bb69bc5'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-09-21 08:00:00',
	updatedby = 'CDM-21979',
	updatedon = now()
where gapid = 'c488231c-1bed-4bd5-a5e1-0e840bb69bc5'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'c488231c-1bed-4bd5-a5e1-0e840bb69bc5' ;

update gapagreementrevision
set startdate = '2021-09-21 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21979',
	updatedon = now()
where gapid = 'c488231c-1bed-4bd5-a5e1-0e840bb69bc5' ;
