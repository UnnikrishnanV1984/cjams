-- CDM-29308 - Subsidy Rate Issue
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date
   
-- Adoption Case ID: 3184444
-- Client ID: 2965921 (Andria Powell) 
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate Start date as 12/1/2022 (Old value 12/09/0202)
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'bbaeb578-b414-4ed0-a3a6-9f695686912f'
	and adoptionagreementrateid = '56bdc9ba-f80b-4925-a660-a195e5f5c35a';

update adoptioncaseagreementrate
set startdate = '2022-12-01 00:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29308'
where adoptionagreementid = 'bbaeb578-b414-4ed0-a3a6-9f695686912f'
	and adoptionagreementrateid = '56bdc9ba-f80b-4925-a660-a195e5f5c35a';

select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'bbaeb578-b414-4ed0-a3a6-9f695686912f'
	and adoptionagreementrateid = '56bdc9ba-f80b-4925-a660-a195e5f5c35a';

update adoptioncaserevision
set startdate = '2022-12-01 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-29308'
where adoptionagreementid = 'bbaeb578-b414-4ed0-a3a6-9f695686912f'
	and adoptionagreementrateid = '56bdc9ba-f80b-4925-a660-a195e5f5c35a';

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29308'
where adoptionagreementid = 'bbaeb578-b414-4ed0-a3a6-9f695686912f'
	and adoptionagreementrateid = '56bdc9ba-f80b-4925-a660-a195e5f5c35a'
	and approvaldate is not null ;