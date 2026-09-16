/*
-- CDM-28824 - Provider ID missng
-- Issue Description: 
   To update Provider Info on the Adoption Case

   3138297:Provider information is missing from the Adoption Subsidy Agreement screen in the child's case, 
   Bryleigh Addison #3138297. The provider's name is Margurite Addison #5013805. 
   The provider information does not appear in the Search Provider. 
   This issue has caused a delay in payment.

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info on Adoption Agreement & Rate screen 
-- 				 and to trigger the under/over batch for generating the missing Oct & Nov 2022 payments.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Provider ID: 5013805 (Margurite Addison) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '676a0676-4192-49bd-b0ac-4fc13d7bc2a4'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5013805, 
	parent1providerid = 5013805, 
	parent1providername = 'Margurite Addison', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-28824',
	updatedon = now()
where adoptioncaseid = '676a0676-4192-49bd-b0ac-4fc13d7bc2a4'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5013805
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5013805,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28824'
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0';

update adoptioncaserevision
set provider_id = 5013805,
	updatedon = now(), 
	updatedby = 'CDM-28824'
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0';

update adoptioncaserevision
set provider_id = 5013805,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28824'
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0'
	and approvaldate is not null
	and activeflag = 1 ;