-- CDM-33723 - Adoptive parents not associated
/*
-- Issue Description: 
   Adoptive Parent Person cards are missing in Adoption Case # 2020021802181
	
-- Adoption Case ID: 2020021802181
-- Client ID: 200139744	(Lucas Nasser) - 8d9d0e59-9743-4628-8c31-8609b2149852
-- Provider ID: 5082661	(Lisa Nasser)
-- Adoption ID: 1050949 - 08/03/2020 To 04/18/2036 - 581a45cf-e0ad-4d28-9a6f-cd7e3318c77a

-- Applicant
-- Client ID: 200113327	(Lisa Nasser) - fafe47c8-4269-4a28-9d7e-4a0c09d6930e

-- Co-Applicant
-- Client ID: 200117875	(Michael Nasser) - ecfe20e4-99c2-4c3f-b776-d37d5dd3a8d5

-- Category/ Module: Adoption Case (Case Management) 
-- Root cause: This Adoption case was created in 2020 (just after the CJAM go-live) and Adoptive Parent Person cards were not generated at that time (Reason is unknown).
-- Fix Provided: Datafix has been promoted to add Adoptive Parent Person cards in this Adoption Cases. (CJAMS PIDs from Provider Module)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

Delete from adoptioncaseactor where insertedby = 'CDM-33723' ;

-- APLCNT 200113327 (Lisa Nasser) - fafe47c8-4269-4a28-9d7e-4a0c09d6930e
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey, -- old_id, 
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '581a45cf-e0ad-4d28-9a6f-cd7e3318c77a', 
		'fafe47c8-4269-4a28-9d7e-4a0c09d6930e', 'ADOPTIVEPARENT', --'2020021802181', 
		1, now(), 'CDM-33723', now(), 'CDM-33723', NULL, NULL
	);
	
-- COAPLCNT	200117875 (Michael Nasser) - ecfe20e4-99c2-4c3f-b776-d37d5dd3a8d5
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey, -- old_id, 
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '581a45cf-e0ad-4d28-9a6f-cd7e3318c77a', 
		'ecfe20e4-99c2-4c3f-b776-d37d5dd3a8d5', 'ADOPTIVEPARENT', -- '2020021802181', 
		1, now(), 'CDM-33723', now(), 'CDM-33723', NULL, NULL
	);

