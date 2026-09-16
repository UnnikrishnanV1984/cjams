-- CDM-37290 - Delete Contact Note
/*
--	Issue Description: 
	User request to delete contact note which entered on 02/01/2024 at 11:36:43 AM
    
-- Case ID: 241030264362 - 3ed19bd8-6ad4-4539-a5f1-da831e977ef4
-- witsid: 12693875 Contact Date: 01/26/2024 - Date of Entry: Feb 1, 2024, 11:36:43 AM - 990e9ab7-73dc-4f83-b0e7-01efeba00599

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select contactdate, insertedon, insertedby, activeflag, updatedby, updatedon, witsid
	from progressnote
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

update progressnote
set activeflag = 0,
	updatedby = 'CDM-37290',
	updatedon = now()
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

select progressnotedetailid, insertedon, insertedby, activeflag, updatedby, updatedon
	from progressnotedetail
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-37290',
	updatedon = now()
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

select contactparticipantid, participanttypekey, activeflag, updatedby, updatedon
	from contactparticipant
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-37290',
	updatedon = now()
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

select auditdetailid, casetype, casenumber, activeflag, updatedby, updatedon
	from progressnote_audit_detail
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-37290',
	updatedon = now()
where progressnoteid = '990e9ab7-73dc-4f83-b0e7-01efeba00599'
	and activeflag = 1 ;