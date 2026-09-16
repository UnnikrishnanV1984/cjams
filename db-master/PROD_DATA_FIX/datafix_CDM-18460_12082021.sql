-- CDM-18460 - Subsidy Rate Issue
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date
   
-- Adoption Case ID: 3186233
-- Client ID: 3029156 (TRINITY JADE	KEYES) - f6b2401c-cf85-4f6c-90c9-6e4b9293ec49
-- Adoption ID: 25624 - 04/21/2010 To 02/18/2024 - 28ada9de-d43d-44a7-a289-6544b9bca051
-- Provider ID: 5042957 (Sherrod  Keyes)  
-- Current Rate slab: 2022-08-31 To 2022-08-31 $835 - 76a47f73-d58d-4ce1-a4b2-861d0017da62
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate Start date as 09/01/2021 (Old value 08/31/2022)
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'ba7e4c15-6ac4-4bd9-b01e-1d0f6df42101'
	and adoptionagreementrateid = '76a47f73-d58d-4ce1-a4b2-861d0017da62' ;

update adoptioncaseagreementrate
set startdate = '2021-09-01 04:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18460'
where adoptionagreementid = 'ba7e4c15-6ac4-4bd9-b01e-1d0f6df42101'
	and adoptionagreementrateid = '76a47f73-d58d-4ce1-a4b2-861d0017da62' ;

select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'ba7e4c15-6ac4-4bd9-b01e-1d0f6df42101'
	and adoptionagreementrateid = '76a47f73-d58d-4ce1-a4b2-861d0017da62' ;

update adoptioncaserevision
set startdate = '2021-09-01 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-18460'
where adoptionagreementid = 'ba7e4c15-6ac4-4bd9-b01e-1d0f6df42101'
	and adoptionagreementrateid = '76a47f73-d58d-4ce1-a4b2-861d0017da62' ;

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18460'
where adoptionagreementid = 'ba7e4c15-6ac4-4bd9-b01e-1d0f6df42101'
	and adoptionagreementrateid = '76a47f73-d58d-4ce1-a4b2-861d0017da62'
	and approvaldate is not null ;
