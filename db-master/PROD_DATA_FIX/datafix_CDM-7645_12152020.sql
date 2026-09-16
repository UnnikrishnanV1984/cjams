-- CDM-7645 - Removal of end date
/*
-- Issue Description: 
   Datafix request to open Placement & Removal. Worker end dated the placement too early; 
   2 Clients are being adopted and should have been placed in a pre-finalized adoptive placement.

   Case ID:3121898 - d8af2d8c-8cd2-4aa6-b2fb-00b602ad884b
   1) Client ID: 4028568 - 662e50a8-7c71-4a50-8641-f0842c29b8c4
	  Placement ID: 327485 (2018-06-05  to 2020-07-15) - d7a9b773-5273-46a8-a277-5cb0da07e351
	  Provider ID: 5001438 (Martin Pollak Treatment Foster Care)
   	  Datafix to remove Exit date (Old value was 07/15/2020)
	  Update Placement, Removal, OOH & IV-E
	  
   2) Client ID: 4028570 - efcecad0-2f9a-4226-a93b-55d4168ddcdd
	  Placement ID: 327484 (2018-06-05 to 2020-07-15) - 1c017139-bf7c-4328-8e54-f7434d82ff90
      Provider ID: 5001438 (Martin Pollak Treatment Foster Care)
	  Datafix to remove Exit date (Old value was 07/15/2020)
	  Update Placement, Removal, OOH & IV-E
	  
-- Category/ Module: Removal/Placement (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) Client ID: 4028568 - 662e50a8-7c71-4a50-8641-f0842c29b8c4
-- Update Placement 
update placement
set enddatetime = NULL,
	exitreasontypekey = NULL, 
	exittypekey = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where placementid = 'd7a9b773-5273-46a8-a277-5cb0da07e351' 
	and activeflag = 1 ;
	
update placementrevision
set exitdate = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where placementid = 'd7a9b773-5273-46a8-a277-5cb0da07e351' 
	and placementrevisionid = '0960d55a-b5b5-44ed-9649-67a5ee818e83'
	and activeflag = 1 ;
	
-- Removal was updated with 1st datafix script '64e73ba0-8c02-41ee-aa8c-6791e2156a83'
update intakeservreqchildremoval
set exitdate = NULL,
	removalexitreason = NULL,
	returndate = NULL,
	returntime = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where intakeservreqchildremovalid = '64e73ba0-8c02-41ee-aa8c-6791e2156a83'
	and activeflag = 1
	and exitdate is not null ;
	
-- Update OOH
update personprogramarea 
	set enddate = NULL,
		updatedby = 'CDM-7645',
		updatedon = now()
where personprogramid = '6039d27c-4e83-48fd-b5c5-5807038b685d'
	and activeflag = 1 ;
	
-- Update Eligibility
update tb_client_eligibility
	set end_dt = NULL,
		update_user_id = 'CDM-7645',
		update_ts = now()
where eligibility_id = 163325
	and delete_sw = 'N' ;


update tb_eligibility_period
	set end_dt = NULL,
		update_user_id = 'CDM-7645',
		update_ts = now()
where eligibility_id = 163325
	and delete_sw = 'N'
	and end_dt is not null;	
	
-- 2) Client ID: 4028570 (JAY'DEN BROWN) - efcecad0-2f9a-4226-a93b-55d4168ddcdd
-- Update Placement 
update placement
set enddatetime = NULL,
	exitreasontypekey = NULL, 
	exittypekey = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where placementid = '1c017139-bf7c-4328-8e54-f7434d82ff90'
	and activeflag = 1 ;
	
update placementrevision
set exitdate = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where placementid = '1c017139-bf7c-4328-8e54-f7434d82ff90'
	and placementrevisionid = '52f95d06-2fdf-44df-b67c-877a820df288'
	and activeflag = 1 ;

-- Removal was updated with 1st datafix script 'c40356c9-08cb-42eb-87e4-cfba088d3a4a'
update intakeservreqchildremoval
set exitdate = NULL,
	removalexitreason = NULL,
	returndate = NULL,
	returntime = NULL,
	updatedby = 'CDM-7645',
	updatedon = now()
where intakeservreqchildremovalid = 'c40356c9-08cb-42eb-87e4-cfba088d3a4a'
	and activeflag = 1
	and exitdate is not null ;

-- Update OOH
update personprogramarea 
	set enddate = NULL,
		updatedby = 'CDM-7645',
		updatedon = now()
where personprogramid = 'd324b46f-454e-4efd-b994-1dd28197c850'
	and activeflag = 1 ;	
	
-- Update Eligibility
update tb_client_eligibility
	set end_dt = NULL,
		update_user_id = 'CDM-7645',
		update_ts = now()
where eligibility_id = 163324
	and delete_sw = 'N' ;


update tb_eligibility_period
	set end_dt = NULL,
		update_user_id = 'CDM-7645',
		update_ts = now()
where eligibility_id = 163324
	and delete_sw = 'N'
	and end_dt is not null;		
	