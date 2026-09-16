-- CDM-10042 - CPS Case removal
/*
-- Issue Description: 
   User request to expunge the CPS- IR - CW2150315
   (Received the SSA approval to expunge)
	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: Currently CJAMS is not allowing Manual Expungement of Finalized investigation.
-- Pull request# TBD - waiting on SSA's confirmation on this enhancement
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- servicerequestnumber	investigationfindingid					maltreatmentid							investigationfindingtypekey
-- CW2150315			b2325209-8fec-4ba3-94ee-54ef362da296	c4e914b0-0350-435b-99dc-adc48ffbe6bd	ID
Insert into cjams.expungement
	(	expungementid, investigationfindingid, isunsubstansiated, manualexpunge, investigationfinding, 
		finalfinding, insertedon, insertedby, updatedon, updatedby, 
		activeflag, maltreatmentid, isremovemaltreator
	)
values
	(	gen_random_uuid(), 'b2325209-8fec-4ba3-94ee-54ef362da296', true, NULL, 'ID', 
		'ID', now(), 'CDM-10042', now(), 'CDM-10042', 
		1, 'c4e914b0-0350-435b-99dc-adc48ffbe6bd', true
	);
	