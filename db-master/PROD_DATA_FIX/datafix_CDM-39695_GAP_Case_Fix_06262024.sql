-- CDM-39695 - Payment issue GAP
/*
-- Issue Description: 
   To fix the GAP case payments (Provider switch) - User error 

-- Case ID: 3255682 - rhonda.gardner@maryland.gov
-- Client ID: 3817097 (DONNELL JARQUEZ CARTER) - a8245e92-ba65-4749-a202-03bd1b88bcf4
-- GAP ID: 4298 - 2016-10-19 To 2033-06-16 - 45f74519-3ba5-48b6-8f2e-58574c816ba6
-- New Provider ID: 6129380	(Sabrina Richards)
-- Old Provider ID: 5082888	(Estella Mcnair)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to fix the GAP Case Data for fiscal adjustments. 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- To update GAP Case Data for fiscal adjustments (CDM-39695) 

-- Revert the provider back to old
update guardianship 
set guardianonename = 'Estella Mcnair', -- 'Sabrina Richards'
	guardianoneid = 250732, -- 646251 (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5082888, -- 6129380
	-- primaryrelationshipkey = 'DACRCHLD',
	guardiantwoname = NULL, -- 'Danny Richards'
	guardiantwoid = NULL, -- 646252 (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL, -- NULL
	secondaryrelationshipkey = NULL, -- DACRCHLD
	updatedby = 'CDM-39695', -- ee86845e-ead2-420b-898f-66b4dd207f4e
	updatedon = now() -- 2024-05-24 10:46:20.000
where gapid = '45f74519-3ba5-48b6-8f2e-58574c816ba6'
	and activeflag = 1 ;
	
-- To fix GAP Rate slab
-- Delete the most recent rate slab and rejected slab
-- 94a82f84-7697-44e3-92cd-555f8b638f38 -- 6129380
update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where gapagreementrateid = '94a82f84-7697-44e3-92cd-555f8b638f38'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where gaprateid = '94a82f84-7697-44e3-92cd-555f8b638f38'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where objectid = '94a82f84-7697-44e3-92cd-555f8b638f38'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- 658f46d1-742b-4705-94ca-fb36607b0a9e -- 5082888 Rejected
update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where gapagreementrateid = '658f46d1-742b-4705-94ca-fb36607b0a9e'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where gaprateid = '658f46d1-742b-4705-94ca-fb36607b0a9e'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-39695', 
	updatedon = now() 
where objectid = '658f46d1-742b-4705-94ca-fb36607b0a9e'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- Re-open Suspension and Trigger under over batch
update gapsuspension
set enddate = NULL,  -- '2023-10-26 04:00:00.000'
	updatedby = 'CDM-37360', -- ee86845e-ead2-420b-898f-66b4dd207f4e
	updatedon = now() -- 2024-05-24 12:08:10.602	 
where gapsuspensionid  = '0a0af076-8aa9-4eca-aae5-7e1a641cf9fc' 
	and activeflag = 1 ;

update gapsuspensionrevision
set enddate = NULL, -- 2024-03-26 04:00:00.000
	approvaldate = now(),	
	updatedby = 'CDM-37360', -- NULL
	updatedon = now() -- 2024-05-24 12:08:10.602
where suspensionid  = '0a0af076-8aa9-4eca-aae5-7e1a641cf9fc'
	and gapsuspensionrevisionid = 'f42ed8c9-7c9e-4111-8601-3083efd1dcc2' 
	and activeflag = 1;
	
-- Delete the new Suspension created by the user 05/01/2024	
update gapsuspensionrevision
set enddate = startdate, 
	activeflag = 0, 
	updatedby = 'CDM-37360',
	updatedon = now() 
where suspensionid = 'a0864ca4-0c7c-47c5-8e0d-ca695cfb54dc' 
	and activeflag = 1 ;

update gapsuspension
set enddate = startdate, 	
	activeflag = 0, 
	updatedby = 'CDM-37360',
	updatedon = now() 
where gapsuspensionid = 'a0864ca4-0c7c-47c5-8e0d-ca695cfb54dc' 
	and activeflag = 1 ;

update routing
set activeflag = 0, 
	updatedby = 'CDM-37360',
	updatedon = now() 
where objectid = 'a0864ca4-0c7c-47c5-8e0d-ca695cfb54dc' 
	and eventcode = 'GASR'
	and activeflag = 1 ;
