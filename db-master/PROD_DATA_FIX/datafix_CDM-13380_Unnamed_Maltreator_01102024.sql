-- CDM-13380 - Individual Incorrectly Identified as maltreator
/*
-- Issue Description: 
   User request to update the Maltreator as Unnamed 
   CPS IR ID: CW2728060 - 512557e5-0f74-4e91-86ea-2f9885ec46a6
	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: CJAMS is not allowing Manual Expungement for Migrated CPS Investigations.
-- Fix Provided: DataFix has been promoted to update the Maltreator as Unnamed Unnamed
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to the Maltreator as Unnamed (CDM-13380)
-- Step I
INSERT INTO cjams.expungement
(	expungementid, investigationfindingid, 
	isunsubstansiated, isindicated, manualexpunge, 
	investigationfinding, finalfinding, insertedon, insertedby, updatedon, updatedby, 
	activeflag, maltreatmentid, isremovemaltreator, isremoverofindings
)
VALUES
(	gen_random_uuid(), '7f168459-863c-4a7c-be48-d1b156cbf175', 
	false, -- isunsubstansiated
	 true, -- isindicated
	 NULL,-- manualexpunge
	'ID', 'ID', now(), 'CDM-13380', now(), 'CDM-13380', 
	1, 'cfb192b7-5791-43ae-9761-c7d0c5730a78', false, false 
) RETURNING expungementid ; 

-- Step II
select cjams.expungementsave(
 (select expungementid from cjams.expungement where insertedby = 'CDM-13380')::uuid
 , 'CDM-13380'::character varying
) ;

-- if above did not work then .....
-- Step II
-- Please select the expungementid using 
-- select expungementid from cjams.expungement where insertedby = 'CDM-13380' 
-- and replace that with '???' in the SP call.
-- select cjams.expungementsave('???'::uuid, 'CDM-13380'::character varying) ;