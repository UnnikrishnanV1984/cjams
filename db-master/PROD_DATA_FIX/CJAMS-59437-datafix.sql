-- CJAMS-59437- Delete Contact Note
/*
--	Issue Description: 
	User request to delete contact note Case ID - 221030017023
                                   Contact Note ID -  14997731

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-59437',
	updatedon = now()
where progressnoteid = '3e112fcf-97ab-4387-97b7-6c68c9073004'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-59437',
	updatedon = now()
where progressnoteid = '3e112fcf-97ab-4387-97b7-6c68c9073004'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-59437',
	updatedon = now()
where progressnoteid = '3e112fcf-97ab-4387-97b7-6c68c9073004'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-59437',
	updatedon = now()
where progressnoteid = '3e112fcf-97ab-4387-97b7-6c68c9073004'
	and activeflag = 1 ;
	