/*
-- CDM-29177 - adoption agreement/provider
-- Issue Description: 
   To update Provider Info on the Adoption Case

   3194783:Worker extended the adoption subsidy agreement for Ethan after his birthday. 
   I then completed a new rate. Worker did not notice that the provider did not populate 
   
   The Provider ID is missing in the Adoption Agreement and the Subsidy Rate Screen:

	Case # 3194783.
	Provider ID # 5031967
   

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Provider ID: 5031967 (Tracy Lynn Worden)
select *, adoptionagreementid,  providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '834ec39d-e112-4563-98cc-b2d75c3cc766'
	and activeflag  = 1 ;

--This parent1providername = 'Tracy Lynn Worden' is from Provider module
--for you to validate
--URL: https://stag3.prov.cjams.mdthink.maryland.gov/
--user: tyra.barnes@maryland.gov

update adoptioncaseagreement 
set providerid = 5031967, 
	parent1providerid = 5031967, 
	parent1providername = 'Tracy Lynn Worden', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-29177',
	updatedon = now()
where adoptioncaseid = '834ec39d-e112-4563-98cc-b2d75c3cc766'
	and activeflag  = 1 ;

select provider_id, adoptionagreementrateid, startdate, enddate
from adoptioncaseagreementrate
where adoptionagreementid =
(select adoptionagreementid
from adoptioncaseagreement     
where adoptioncaseid = '834ec39d-e112-4563-98cc-b2d75c3cc766'    
)
and activeflag = 1
order by startdate desc;
	
-- Update Provider ID as 5031967
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5031967,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29177'
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d';

update adoptioncaserevision
set provider_id = 5031967,
	updatedon = now(), 
	updatedby = 'CDM-29177'
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d';

update adoptioncaserevision
set provider_id = 5031967,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29177'
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d'
	and approvaldate is not null
	and activeflag = 1 ;