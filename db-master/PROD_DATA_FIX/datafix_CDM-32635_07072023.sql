-- CDM-32635 - Provider issue
/*
--	Issue Description: 
	User Error, The provider indentity was changed in CJAMS (on Provider module side) 
    
-- Case ID: 3201142
-- Client ID: 3244591 (JEREMIAH	FARRAR	MALONE) - 43245b37-6fc6-4aaf-af85-bacc498c62e7
-- Adoption ID: 30826 - 2011-06-15 To 2025-02-14 - c65f65dd-1207-48d9-ac40-61297cfc4ea0
-- New Rate slab 2020-06-01	 To 2021-05-31 was created in CJAMS on 2023-06-28 13:29:51
-- New Provider ID: 6055015	(Eugene Malone) 
-- Old Provider ID: 5008131	(Cynthia Malone) 

-- Suspension ID: f4d41131-6cff-4eb1-a992-f55db4933b3d	2020-06-01 To Open

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Fix Provided: Datafix has been promoted to update the Provider on the most recent rate slab.
--			     Also, to end date the suspension and triggre under over batch.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Provider info and End date 
-- update provider id as 6055015 and end date as '2021-05-31 04:00:00'
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid  = '6e5361f7-857c-45d4-8aed-3a7a1aa4eb60' ;

update adoptioncaseagreementrate
set provider_id = 6055015,
	enddate = '2021-05-31 04:00:00',
	updatedby = 'CDM-32635',
	updatedon = now()
where adoptionagreementrateid  = '6e5361f7-857c-45d4-8aed-3a7a1aa4eb60' ;

-- update provider id as 6055015 and end date as '2021-05-31 04:00:00'
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaserevision
where adoptionagreementrateid  = '6e5361f7-857c-45d4-8aed-3a7a1aa4eb60' ;

update adoptioncaserevision
set provider_id = 6055015,
	-- enddate = '2021-05-31 04:00:00',
	updatedby = 'CDM-32635',
	updatedon = now()
where adoptionagreementrateid  = '6e5361f7-857c-45d4-8aed-3a7a1aa4eb60' ;

-- To end date the suspension & trigger under/over batch
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = 'f4d41131-6cff-4eb1-a992-f55db4933b3d'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionenddate = suspensionbegindate,
	approvaldate = now(),
	updatedby = 'CDM-32635',
	updatedon = now()
where adoptionsuspensionid = 'f4d41131-6cff-4eb1-a992-f55db4933b3d'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = 'f4d41131-6cff-4eb1-a992-f55db4933b3d'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionenddate = suspensionbegindate,
	approvaldate = now(),
	updatedby = 'CDM-32635',
	updatedon = now()
where adoptionsuspensionid = 'f4d41131-6cff-4eb1-a992-f55db4933b3d' 
	and activeflag = 1 ;	

