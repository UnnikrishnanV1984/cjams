-- CDM-24686 - Adoption subsidy payment
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Adoption Case ID: 3085984
-- Client ID: 1445984 (EMILY A BREIGHNER) - 59098a15-e40a-45b1-9953-15ddf583f5c0
-- Adoption ID: 6775 - 2005-06-14 To 2023-09-28 - 4f749782-af8c-4af1-bcf4-7836d2c9f0be
-- Provider ID: 5008042 (Bonnie Breighner)

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update -- Provider ID: 5008042 (Bonnie Breighner) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '4f749782-af8c-4af1-bcf4-7836d2c9f0be'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5008042, 
	parent1providerid = 5008042, 
	parent1providername = 'Bonnie Breighner', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-24686',
	updatedon = now()
where adoptioncaseid = '4f749782-af8c-4af1-bcf4-7836d2c9f0be'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5008042
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '001cb648-be68-4dad-aa1e-2c857ba1c54a'
	and adoptionagreementrateid = 'c39427ef-e8f2-4e23-9177-46b5c4ba2dbf'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5008042,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-24686'
where adoptionagreementid = '001cb648-be68-4dad-aa1e-2c857ba1c54a'
	and adoptionagreementrateid = 'c39427ef-e8f2-4e23-9177-46b5c4ba2dbf'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '001cb648-be68-4dad-aa1e-2c857ba1c54a'
	and adoptionagreementrateid = 'c39427ef-e8f2-4e23-9177-46b5c4ba2dbf' ;

update adoptioncaserevision
set provider_id = 5008042,
	updatedon = now(), 
	updatedby = 'CDM-24686'
where adoptionagreementid = '001cb648-be68-4dad-aa1e-2c857ba1c54a'
	and adoptionagreementrateid = 'c39427ef-e8f2-4e23-9177-46b5c4ba2dbf' ;

update adoptioncaserevision
set provider_id = 5008042,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-24686'
where adoptionagreementid = '001cb648-be68-4dad-aa1e-2c857ba1c54a'
	and adoptionagreementrateid = 'c39427ef-e8f2-4e23-9177-46b5c4ba2dbf'
	and approvaldate is not null
	and activeflag = 1 ;
