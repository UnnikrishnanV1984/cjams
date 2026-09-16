/*
--	Issue Description: 
	User provided the case number and contact ID that needs to be deleted
                    Case #251030525149
                    Contact ID: 16052318

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-66947',
	updatedon = now()
where progressnoteid = '3f89aa72-b90c-41cc-8c28-a38f07c695e5'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-66947',
	updatedon = now()
where progressnoteid = '3f89aa72-b90c-41cc-8c28-a38f07c695e5'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-66947',
	updatedon = now()
where progressnoteid = '3f89aa72-b90c-41cc-8c28-a38f07c695e5'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-66947',
	updatedon = now()
where progressnoteid = '3f89aa72-b90c-41cc-8c28-a38f07c695e5'
	and activeflag = 1 ;

	