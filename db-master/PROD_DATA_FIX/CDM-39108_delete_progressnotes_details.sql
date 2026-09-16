/*
-- CDM-39108 - Incorrect Data entry 
-- Issue Description: 
	231030164305:I accidentally entered an addendum in this case that was not for this family. Is there anyway this can be deleted from this record?
-- Category/ Module: Contact Notes.
-- Root cause: User Error
-- Fix Provided: soft deleted the requested progressnotesdetails.
*/

update progressnotedetail
set activeflag = 0, updatedby = 'CDM-39018', updatedon = now()
where progressnotedetailid in ('24465447-72f3-4644-8844-29c77d9d75df','68f073cd-881e-47d2-887b-08e25c423edd') and activeflag = 1;