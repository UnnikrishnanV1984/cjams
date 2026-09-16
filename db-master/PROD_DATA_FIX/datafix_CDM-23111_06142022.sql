-- CDM-23111 - Adoption Subsidy Payment-Provider
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
   
-- Case ID: 3261944 
-- Adoption ID: 45066 - 2015-11-19 To 2025-04-20 - c073ba98-a053-4ec0-b100-91485e950790
-- Client ID: 3893585 (LILLY LASHAWN MONROE-PARKER) - 73037579-490d-4ccc-8395-854a368967e1
-- Provider ID: 5055808	(Christel Parker)- Local Department Home

-- Starting 04/21/2022 
-- Provider ID: 5007408	(Kelly White)- Local Department Home

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB (Need more analysis to find out who changed the provider on this case?) 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- update providerid in adoptioncaseagreement
-- Update -- Provider ID: 5055808 (Christel Parker)- Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'c073ba98-a053-4ec0-b100-91485e950790'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5055808, 
	parent1providerid = 5055808, 
	parent1providername = 'Christel Parker', 
	parent2providerid = 5055808,  
	parent2providername = 'Marlin Parker', 
	-- issingleparent = NULL,
	updatedby = 'CDM-23111',
	updatedon = now()
where adoptioncaseid = 'c073ba98-a053-4ec0-b100-91485e950790'
	and activeflag  = 1 ;
	

-- 5007408	2022-04-21 To 2023-04-20 - $850
-- Update Provider ID as 5055808
-- adoptionagreementid: 68b36f39-6cc1-49d0-b925-1d20b1634885
-- adoptionagreementrateid: 430fffd5-ac89-4592-8ad4-8def972a8a8e

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '68b36f39-6cc1-49d0-b925-1d20b1634885'
	and adoptionagreementrateid = '430fffd5-ac89-4592-8ad4-8def972a8a8e' ;

update adoptioncaseagreementrate
set provider_id = 5055808,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23111'
where adoptionagreementid = '68b36f39-6cc1-49d0-b925-1d20b1634885'
	and adoptionagreementrateid = '430fffd5-ac89-4592-8ad4-8def972a8a8e' ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '68b36f39-6cc1-49d0-b925-1d20b1634885'
	and adoptionagreementrateid = '430fffd5-ac89-4592-8ad4-8def972a8a8e' ;

update adoptioncaserevision
set provider_id = 5055808,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23111'
where adoptionagreementid = '68b36f39-6cc1-49d0-b925-1d20b1634885'
	and adoptionagreementrateid = '430fffd5-ac89-4592-8ad4-8def972a8a8e'
	and adoptionrevisionid = '316cd0bb-beb4-4bde-b3cd-1d94820b33b6' ;
	
update adoptioncaserevision
set provider_id = 5055808,
	updatedon = now(), 
	updatedby = 'CDM-23111'
where adoptionagreementid = '68b36f39-6cc1-49d0-b925-1d20b1634885'
	and adoptionagreementrateid = '430fffd5-ac89-4592-8ad4-8def972a8a8e'
	and adoptionrevisionid = 'deb331e9-205b-4279-b3c0-05399302a33f' ;	
