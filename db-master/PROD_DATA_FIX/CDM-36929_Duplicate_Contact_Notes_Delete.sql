-- CDM-36929 - Duplicate Contact Note
/*
--	Issue Description: 
	User request to delete duplicate contact note which entered on 02/01/2024 at 11:36:43 AM
    
-- Case ID: 241021887450 - 34042e63-28f6-4307-aaeb-66a8b662a505
-- witsid: 12668588 Contact Date: 01/31/2024 - Date of Entry: Feb 1, 2024, 11:36:43 AM - 23ddd56d-85b3-4fc6-a324-b2fbf7d52853

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the duplicate contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the duplicate contact note (CDM-36929)
-- witsid: 12668588 Contact Date: 01/31/2024 - Date of Entry: Feb 1, 2024, 11:36:43 AM - 23ddd56d-85b3-4fc6-a324-b2fbf7d52853

select contactdate, insertedon, insertedby, activeflag, updatedby, updatedon, witsid
	from progressnote
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

update progressnote
set activeflag = 0,
	updatedby = 'CDM-36929',
	updatedon = now()
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

select progressnotedetailid, insertedon, insertedby, activeflag, updatedby, updatedon
	from progressnotedetail
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-36929',
	updatedon = now()
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

select contactparticipantid, participanttypekey, activeflag, updatedby, updatedon
	from contactparticipant
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-36929',
	updatedon = now()
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

select auditdetailid, casetype, casenumber, activeflag, updatedby, updatedon
	from progressnote_audit_detail
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-36929',
	updatedon = now()
where progressnoteid = '23ddd56d-85b3-4fc6-a324-b2fbf7d52853'
	and activeflag = 1 ;