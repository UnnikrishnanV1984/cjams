-- CDM-12335 - Maltreator was identified in error
/*
-- Issue Description: 
   User request to update the Maltreator as Unnamed 
   Investigation 2021077092565 - intakeserviceid: 78f3d94c-5f99-4627-b68f-0cf867fbf147
	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: Currently CJAMS is not allowing Manual Expungement for this Investigation.
-- Pull request# TBD - waiting on SSA's confirmation on this enhancement
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to the Maltreator as Indicated
-- Step I
INSERT INTO cjams.expungement
(	expungementid, investigationfindingid, isunsubstansiated, isindicated, manualexpunge, investigationfinding, 
	finalfinding, insertedon, insertedby, updatedon, updatedby, 
	activeflag, maltreatmentid, isremovemaltreator, isremoverofindings
)
VALUES
(	gen_random_uuid(), '4db31e69-a1d1-4e46-a2a1-d7171a8ac62a', false, true, NULL, 'ID', 
	'ID', now(), 'CDM-12335', now(), 'CDM-12335', 
	1, '7cf45198-a911-4f7b-b0c3-afd374b9054b', false, false 
) RETURNING expungementid ; 


-- Step II
-- Please take the expungementid from the above replace'???' in the SP call.
-- select cjams.expungementsave('???'::uuid, 'CDM-12335'::character varying) ;
