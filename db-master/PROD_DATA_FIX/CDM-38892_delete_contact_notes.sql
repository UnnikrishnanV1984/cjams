/*
-- Issue Description: 241022040839:Please delect the two contact notes dated 5/6/24. 
                      I errornously entered a note under the wrong casehead.   
-- Root cause: Change requested by user.
-- Fix Provided: Updated the progressnote, progressnotedetials, contactparticipant table.
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-38892' , updatedon = now()
WHERE witsid in ('12945855','12946770') and activeflag = 1;

update progressnotedetail set activeflag = 0, updatedby = 'CDM-38892' , updatedon = now()
WHERE progressnoteid in (select progressnoteid from progressnote where witsid in ('12945855','12946770')) and activeflag = 1;

update contactparticipant
SET activeflag = 0, updatedby = 'CDM-38892' , updatedon = now()
WHERE progressnoteid in (select progressnoteid from progressnote where witsid in ('12945855','12946770')) and activeflag = 1;