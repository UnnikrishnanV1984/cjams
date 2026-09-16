-- CDM-34765 - Provider payment number change needed
/*
--	Issue Description: 
	User request to change the Provider ID as Provider ID # 6067957 on the latest subsidy rate slab 
	and end the suspension with 05/12/2023. 
    
-- Adoption Case ID: 3205634
-- Client ID: 3291841 (KYLE	ALEXANDER YOUNGALSTON) - b778648b-3d05-4f1f-a404-3d233740e169
-- Adoption ID: 32324 - 2011-10-11 To 2026-08-31 - c0c0b3a1-e712-4681-93f3-a53a791889d0
-- New Provider ID: 6067957 (KATRINA YOUNG)
-- Old Provider ID: 5013081 (SHARON ALSTON)

-- Rate ID: 7e5010c7-0b9b-4aad-b244-1c0fb4ef9268 - 2023-05-11 To 2024-04-30	- $835.00
-- update New Provider ID: 6067957 (KATRINA YOUNG)

-- Suspension ID: 30919a41-b2bb-455d-9cf6-b7366004b9d5 - 2022-12-29 To Open

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Fix Provided: Datafix has been promoted to update the Provider on the most recent rate slab.
--			     Also, to end date the suspension and trigger under over batch.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Provider ID and End suspension (CDM-34765)

-- Update New Provider ID: 6067957 (KATRINA YOUNG) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'c0c0b3a1-e712-4681-93f3-a53a791889d0'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 6067957, 
	parent1providerid = 6067957, 
	-- parent1providername = 'KATRINA YOUNG', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptioncaseid = 'c0c0b3a1-e712-4681-93f3-a53a791889d0'
	and activeflag  = 1 ;
	
-- Rate ID: 7e5010c7-0b9b-4aad-b244-1c0fb4ef9268 - 2023-05-11 To 2024-04-30	- $835.00
-- update New Provider ID: 6067957 (KATRINA YOUNG)
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid = '7e5010c7-0b9b-4aad-b244-1c0fb4ef9268' ;

update adoptioncaseagreementrate
set provider_id = 6067957,
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionagreementrateid = '7e5010c7-0b9b-4aad-b244-1c0fb4ef9268' ;

-- update New Provider ID: 6067957 (KATRINA YOUNG)
select adoptionrevisionid, provider_id, startdate, enddate, updatedby, updatedon, activeflag, approvaldate, approvalstatustypekey
	from adoptioncaserevision
where adoptionagreementrateid  = '7e5010c7-0b9b-4aad-b244-1c0fb4ef9268' ;

update adoptioncaserevision
set provider_id = 6067957,
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionagreementrateid  = '7e5010c7-0b9b-4aad-b244-1c0fb4ef9268' 
	and adoptionrevisionid = '16de14bf-8561-48ec-a61a-563dede023e1' ;

update adoptioncaserevision
set provider_id = 6067957,
	updatedby = 'CDM-34765',
	approvaldate = now(),
	updatedon = now()
where adoptionagreementrateid  = '7e5010c7-0b9b-4aad-b244-1c0fb4ef9268' 
	and adoptionrevisionid = '9b6a6984-3c10-4fb5-ae10-1e6d074247fc' ;
	
-- To end date the suspension & trigger under/over batch
-- Suspension ID: 30919a41-b2bb-455d-9cf6-b7366004b9d5 - 2022-12-29 To Open
-- Update end date as 2023-05-11 05:00:00
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionenddate = '2023-05-11 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and activeflag = 1 ;	

-- Update end date as 2023-05-11 05:00:00 and activeflag = 1
select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and adoptionsuspensionrevisionid = 'f029c8f2-8540-4134-af39-dde1d7f7a9b2'	
	-- and activeflag = 1 
	;	
	
update adoptioncasesuspensionrevision
set suspensionenddate = '2023-05-11 05:00:00',
	activeflag = 1,
	approvaldate = now(),
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionsuspensionid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and adoptionsuspensionrevisionid = 'f029c8f2-8540-4134-af39-dde1d7f7a9b2'	
	-- and activeflag = 1 
	;	

-- Update activeflag = 0 of Rejected record
select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing
where objectid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and routingid = '65a07048-8f23-4d2d-8885-4bb3e7091885' ;

update routing
set activeflag = 0,
	updatedby = 'CDM-34765',
	updatedon = now()
where objectid = '30919a41-b2bb-455d-9cf6-b7366004b9d5'
	and routingid = '65a07048-8f23-4d2d-8885-4bb3e7091885' ;

-- 2nd approved suspension
-- 1afd9eb6-f2b6-411c-97ab-0c4d71e526c6 - 2022-12-29 05:00:00	2023-05-12 04:00:00	
-- Update end date as 2023-05-11 05:00:00
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '1afd9eb6-f2b6-411c-97ab-0c4d71e526c6'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionenddate = '2023-05-11 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionsuspensionid = '1afd9eb6-f2b6-411c-97ab-0c4d71e526c6'
	and activeflag = 1 ;	

-- Update end date as 2023-05-11 05:00:00 and activeflag = 1
select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '1afd9eb6-f2b6-411c-97ab-0c4d71e526c6'
	and adoptionsuspensionrevisionid = 'd66ea03e-9b42-42bd-81b2-1e59bf493348'	
	and activeflag = 1 	;	
	
update adoptioncasesuspensionrevision
set suspensionenddate = '2023-05-11 05:00:00',
--	approvaldate = now(),
	updatedby = 'CDM-34765',
	updatedon = now()
where adoptionsuspensionid = '1afd9eb6-f2b6-411c-97ab-0c4d71e526c6'
	and adoptionsuspensionrevisionid = 'd66ea03e-9b42-42bd-81b2-1e59bf493348'	
	and activeflag = 1 	;	
