-- CJAMS-61826- Erase Note
/*
--	Issue Description: 
	User request to delete contact note Case ID - 231030220392
                                   Contact Note ID -  15252987

-- Category/ Module: Contact Notes 
-- Root cause: User error and request to delete the incorrect contact note.
-- Fix Provided: Datafix has been promoted to delete the contact note.
-- Is code fix needed : NO
-- Reason why no related code fix: It is a user error and data fix should resolve it.
*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-61826',
	updatedon = now()
where progressnoteid = '26e4c1bd-35e0-4931-a2b6-6e1ad59e9b21'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-61826',
	updatedon = now()
where progressnoteid = '26e4c1bd-35e0-4931-a2b6-6e1ad59e9b21'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-61826',
	updatedon = now()
where progressnoteid = '26e4c1bd-35e0-4931-a2b6-6e1ad59e9b21'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-61826',
	updatedon = now()
where progressnoteid = '26e4c1bd-35e0-4931-a2b6-6e1ad59e9b21'
	and activeflag = 1 ;
	