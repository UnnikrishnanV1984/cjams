
/*
   Issue Description: CDM-35592
   Category/ Module  : User requested to delete the text in the comment box as it was mistakenly put in for the wrong child
   Root cause: As comment field cannot be blank and is mandatory, after getting confirmation, suggested to delete the contact note.
   Fix Provided: 
*/

select activeflag,* from progressnote where 
progressnoteid ='912dfad2-4f75-4ea5-baa8-bf3660c57833' and activeflag =1;

update cjams.progressnote 
set activeflag =0, updatedby ='CDM-35592', updatedon = now()
where progressnoteid ='912dfad2-4f75-4ea5-baa8-bf3660c57833' and activeflag =1;

select progressnoteid,progressnotedetailid, insertedon, insertedby, activeflag, updatedby, updatedon
	from progressnotedetail
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-35592',
	updatedon = now()
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;

select contactparticipantid, participanttypekey, activeflag, updatedby, updatedon
	from contactparticipant
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-35592',
	updatedon = now()
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;

select auditdetailid, casetype, casenumber, activeflag, updatedby, updatedon
	from progressnote_audit_detail
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-35592',
	updatedon = now()
where progressnoteid = '912dfad2-4f75-4ea5-baa8-bf3660c57833'
	and activeflag = 1;