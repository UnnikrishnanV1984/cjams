-- CDM-12336 - Maltreator identified in error
/*
-- Issue Description: 
   User request to update the Maltreator as Unnamed 
   Investigation 20200148019475 - intakeserviceid: 0dc4443e-945a-4d2c-b1d9-dcdb76975374
	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: Currently CJAMS is not allowing Manual Expungement for this Investigation.
-- Pull request# TBD - waiting on SSA's confirmation on this enhancement
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to the Maltreator as Unnamed
-- Step I
INSERT INTO cjams.expungement
(	expungementid, investigationfindingid, isunsubstansiated, isindicated, manualexpunge, investigationfinding, 
	finalfinding, insertedon, insertedby, updatedon, updatedby, 
	activeflag, maltreatmentid, isremovemaltreator, isremoverofindings
)
VALUES
(	gen_random_uuid(), '40b5ded1-4d6a-4d79-810a-600f8e7f12f7', true, false, NULL, 'UD', 
	'UD', now(), 'CDM-12336', now(), 'CDM-12336', 
	1, '4bda9a27-0c4f-4784-a1b7-2a2acedb0bb1', false, false 
) RETURNING expungementid ; 


-- Step II
-- Please take the expungementid from the above replace'???' in the SP call.
-- select cjams.expungementsave('???'::uuid, 'CDM-12336'::character varying) ;
