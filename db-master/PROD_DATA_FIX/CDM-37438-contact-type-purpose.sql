-- CDM-37438 - Contact Note Issue
/*
--	Issue Description: 
	User request to update contact from Initial face to face to be changed as Face to Face.
	
-- Case ID: 241030256398
-- Contact ID: 12705303 - Monthly Visit - Date: 2/15/2024

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the contact type and purpose.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Type Of Contact (CDM-37438)

-- Case ID: 241030256398
-- Contact ID: 12705303 - Monthly Visit - Date: 2/15/2024

-- b83d8c25-f7db-4816-87f4-35a657790ad4	Initialfacetoface
-- 786495b2-c779-4cc4-b812-6a8439bfa96e	Face To Face



select 	progressnotereasontypekey from 	ProgressNote where 	progressnoteid = '82422fde-c415-40fc-9a08-9fab03d6ec48';

update progressnote set progressnotereasontypekey = 'MV', updatedby = 'CDM-37438', updatedon = now()
where 	progressnoteid = '82422fde-c415-40fc-9a08-9fab03d6ec48';

select progressnotetypeid, progressnotereasontypekey, contactdate, activeflag, updatedby, updatedon
	from progressnote
where witsid = 12705303
	and activeflag = 1 ; -- b83d8c25-f7db-4816-87f4-35a657790ad4 -- initial face to face

update progressnote
set progressnotetypeid = '786495b2-c779-4cc4-b812-6a8439bfa96e', -- Face To Face
	updatedby = 'CDM-37438',
	updatedon = now()
where witsid = 12705303
	and activeflag = 1 ;