/*
Issue Description: CJAMS-69386 - face to face contact note
Category/Module: Child Welfare - Case Profile, Notes
Root cause: Worker selected the wrong 'Type of Contact' when entering the note.
Fix provided: Data fix has been done to update the 'Type of Contact' from 'Video' to
   'Face to Face' for the 06/30/2026 monthly visit contact note with Tyler Rodgers
   (Contact ID: 16384433) under Case# 3273677.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error, not an application defect.
*/

update progressnote
set
    progressnotetypeid = '786495b2-c779-4cc4-b812-6a8439bfa96e', -- Face to Face
    updatedby = 'CJAMS-69386',
    updatedon = now ()
where
    progressnoteid = '591979bc-893a-447a-9a73-97c791f0f714'
    and witsid = 16384433
    and activeflag = 1;