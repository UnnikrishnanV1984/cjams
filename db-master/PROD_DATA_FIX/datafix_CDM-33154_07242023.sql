-- CDM-33154 - Duplicate Contact Note
/*
--	Issue Description: 
	User request to delete duplicate contact note which entered on 07/20/2023 at 3:18:27 PM
    
-- Case ID: 221030016069 - f09b0a82-e4da-4c78-9f47-e429fda64e74
-- witsid: 11009871 Contact Date: 07/13/2023 - Date of Entry: Jul 20, 2023, 3:18:27 PM - 9dc30ca1-df28-493d-99c6-4eed23c1bceb

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the duplicate contact note.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the duplicate contact note (CDM-33154)
-- witsid: 11009871 Contact Date: 07/13/2023 - Date of Entry: Jul 20, 2023, 3:18:27 PM - 9dc30ca1-df28-493d-99c6-4eed23c1bceb

select contactdate, insertedon, insertedby, activeflag, updatedby, updatedon, witsid
	from progressnote
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

update progressnote
set activeflag = 0,
	updatedby = 'CDM-33154',
	updatedon = now()
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

select progressnotedetailid, insertedon, insertedby, activeflag, updatedby, updatedon
	from progressnotedetail
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-33154',
	updatedon = now()
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

select contactparticipantid, participanttypekey, activeflag, updatedby, updatedon
	from contactparticipant
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-33154',
	updatedon = now()
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

select auditdetailid, casetype, casenumber, activeflag, updatedby, updatedon
	from progressnote_audit_detail
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-33154',
	updatedon = now()
where progressnoteid = '9dc30ca1-df28-493d-99c6-4eed23c1bceb'
	and activeflag = 1 ;
	