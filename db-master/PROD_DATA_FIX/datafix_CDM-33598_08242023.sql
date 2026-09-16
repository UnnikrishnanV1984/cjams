-- CDM-33598 - Monthly contact note error
/*
--	Issue Description: 
	User request to update contact from Initial face to face to be changed as Face to Face.
	
-- Case ID: 3089972
-- Contact ID: 11076643 - Monthly Visit - Date: 08/02/2023

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the duplicate contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Type Of Contact (CDM-33598)

-- Case ID: 3089972
-- Contact ID: 11076643 - Monthly Visit - Date: 08/02/2023

-- b83d8c25-f7db-4816-87f4-35a657790ad4	Initialfacetoface
-- 786495b2-c779-4cc4-b812-6a8439bfa96e	Face To Face
select progressnotetypeid, progressnotereasontypekey, contactdate, activeflag, updatedby, updatedon
	from progressnote
where witsid = 11076643
	and activeflag = 1 ;

update progressnote
set progressnotetypeid = '786495b2-c779-4cc4-b812-6a8439bfa96e', -- Face To Face
	updatedby = 'CDM-33598',
	updatedon = now()
where witsid = 11076643
	and activeflag = 1 ;
