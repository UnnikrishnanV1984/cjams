/*
-- Issue Description: 241021925083:While entering contact notes, a duplicate note was created by CJAMS. 
                      Seems to be a bug in the system. I only entered one contact note for this contact and it created 2. The timestamps are the exact same for each of the contacts. 
                      For reference, this occurred for the following contact ID's: Contact ID: 12995180; Contact ID: 12995181   
-- Root cause: Change requested by user.
-- Fix Provided: Updated the progressnote, progressnotedetials, contactparticipant table.
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-38951' , updatedon = now()
WHERE progressnoteid in (select progressnoteid from progressnote where witsid = '12995181') and activeflag = 1;


update progressnotedetail set activeflag = 0, updatedby = 'CDM-38951' , updatedon = now()
WHERE progressnoteid in (select progressnoteid from progressnote where witsid = '12995181') and activeflag = 1;

update contactparticipant
SET activeflag = 0, updatedby = 'CDM-38951' , updatedon = now()
WHERE progressnoteid in (select progressnoteid from progressnote where witsid = '12995181') and activeflag = 1;