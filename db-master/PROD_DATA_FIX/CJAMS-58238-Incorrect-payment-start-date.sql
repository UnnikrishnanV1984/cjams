-- CJAMS-58238 Incorrect payment start date
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date and end date
   
-- Adoption Case ID: 241040261190
-- Client ID:202708483 YULIAN CASTILLO HERNANDEZ
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Update Rate Start date as 01/17/2025 -01/16/2026  (Old value 01/18/2026 - 01/17/2027 )

/*
select * from adoptioncaseagreementrate a where adoptionagreementid = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4'
--adoptionagreementrateid : af290b99-b857-458d-b1b7-f3138d51a634
*/
update adoptioncaseagreementrate
set startdate = '2025-01-17 05:00:00.000',
	enddate = '2026-01-16 00:00:00.000',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CJAMS-58238'
where adoptionagreementid = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4'
	and adoptionagreementrateid = 'af290b99-b857-458d-b1b7-f3138d51a634'
	and activeflag =1;
/*
select * from adoptioncaserevision 
where adoptionagreementid = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4'
	and adoptionagreementrateid = 'af290b99-b857-458d-b1b7-f3138d51a634'
	and activeflag =1;
*/
update adoptioncaserevision
set startdate = '2025-01-17 05:00:00.000',
	enddate = '2026-01-16 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CJAMS-58238'
where adoptionagreementid = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4'
	and adoptionagreementrateid = 'af290b99-b857-458d-b1b7-f3138d51a634'
	and activeflag =1;

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CJAMS-58238'
where adoptionagreementid = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4'
	and adoptionagreementrateid = 'af290b99-b857-458d-b1b7-f3138d51a634'
	and approvaldate is not null ;

-- delete rejected record
update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CJAMS-58238'
where adoptionagreementid  = '5f38a2f4-5bbd-48f5-9dcb-fa61c09ebdf4' 
and adoptionrevisionid = '16b36f28-8436-4970-b266-5e7b39f05a56'
	and activeflag =1; 