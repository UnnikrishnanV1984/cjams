-- CDM-31194 - Overpayment error
/*
-- Issue Description: 
	User Request to update Adoption Agreement Start date as 07/22/2009
   
-- Adoption Case ID: 3176140
-- Client ID: 2699274 (EMILY R BARIA) - a6ad08c5-61a5-4388-846e-14cdc9bdee28
-- Adoption ID: 21521 - 2009-08-01 To 2023-03-08 - fbcb64c5-2170-4042-a47b-c297fde954be
-- Provider ID: 5029435	(Theresa Baria) 
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to update Adoption Agreement Start date as 07/22/2009
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Adoption Case Start Date as 2009-07-22 (old Value was 2009-08-01)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = 'fbcb64c5-2170-4042-a47b-c297fde954be'
	and activeflag = 1;

update adoptioncase
set startdate = '2009-07-22 00:00:00.000', 
	updatedon = now(), 
	updatedby = 'CDM-31194'
where adoptioncaseid = 'fbcb64c5-2170-4042-a47b-c297fde954be'
	and activeflag = 1;

select startdate, enddate, updatedby, updatedon
	from adoptioncaseagreement 
where adoptioncaseid = 'fbcb64c5-2170-4042-a47b-c297fde954be' ;

update adoptioncaseagreement
set startdate = '2009-07-22 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-31194'
where adoptioncaseid = 'fbcb64c5-2170-4042-a47b-c297fde954be' ;

select startdate, enddate, approvaldate, updatedon, updatedby
	from adoptioncaseagreementrevision   
where adoptioncaseagreementid  = '396180ef-5c89-4d94-a065-a7485527f47e' ;

update adoptioncaseagreementrevision 
set startdate = '2009-07-22 00:00:00.000',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-31194'
where adoptioncaseagreementid  = '396180ef-5c89-4d94-a065-a7485527f47e' ;

-- To Trigger Under Over batch -- Update all rate slabs
select startdate, enddate, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '396180ef-5c89-4d94-a065-a7485527f47e'
  and activeflag = 1 ;

update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-31194'
where adoptionagreementid = '396180ef-5c89-4d94-a065-a7485527f47e'
  and activeflag = 1 ;
