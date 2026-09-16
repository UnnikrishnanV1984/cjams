-- CDM-12327 - Maltreator was identified in error
/*
-- Issue Description: 
   User request to update the Maltreator as Unnamed 
   Investigation 2021077092543 - intakeserviceid: c844a501-e755-49ad-bd21-afcfa82e411e
	   
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
(	gen_random_uuid(), 'b67c8767-19e7-46a6-b4b8-cb3594b6fb90', false, true, NULL, 'ID', 
	'ID', now(), 'CDM-12327', now(), 'CDM-12327', 
	1, '7684f2b9-a084-47bc-955a-376e30b9007e', false, false 
) RETURNING expungementid ; 


-- Step II
-- Please take the expungementid from the above replace'???' in the SP call.
-- select cjams.expungementsave('???'::uuid, 'CDM-12327'::character varying) ;

