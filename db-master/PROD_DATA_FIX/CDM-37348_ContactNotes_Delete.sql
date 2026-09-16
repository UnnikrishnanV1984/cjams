-- CDM-37348 - Delete Contact Note
/*
--	Issue Description: 
	User request to delete contact note which entered on 02/01/2024 at 11:36:43 AM
    
-- Case ID: 3260380
-- witsid: 11921158 Contact Date: 11/22/2023 - Date of Entry: Nov 30, 2023, 09:13:38 AM - 88d0ee76-8904-4ab2-ab0b-4d02f275b817

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select contactdate, insertedon, insertedby, activeflag, updatedby, updatedon, witsid
	from progressnote
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

update progressnote
set activeflag = 0,
	updatedby = 'CDM-37348',
	updatedon = now()
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

select progressnotedetailid, insertedon, insertedby, activeflag, updatedby, updatedon
	from progressnotedetail
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-37348',
	updatedon = now()
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

select contactparticipantid, participanttypekey, activeflag, updatedby, updatedon
	from contactparticipant
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-37348',
	updatedon = now()
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

select auditdetailid, casetype, casenumber, activeflag, updatedby, updatedon
	from progressnote_audit_detail
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-37348',
	updatedon = now()
where progressnoteid = '88d0ee76-8904-4ab2-ab0b-4d02f275b817'
	and activeflag = 1 ;