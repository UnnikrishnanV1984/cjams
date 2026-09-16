
/*
Issue: FY J. Cruz Monthly Visit Note Missing
Category/Module: Progress Note
Root cause: The progress note for FY J. Cruz is missing in the system. The note was created on 01/16/2026 but is not visible in the system.Therefore the note was re-entered again. But we need to enter the'Date of Entry' column to show 01/16/2026 reflecting that the note was entered within 5 business days instead of the 1/29/2026 date as the contact was missing and user re-entered the note.
Fix provided: Data fix has been provided to update the 'Date of Entry' column to reflect the correct date of 01/16/2026.
Data/Code fix ticket#: CJAMS-64883
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Update to the existing record to reflect the correct date of entry in the database.
*/
update progressnote
set insertedon='2026-01-16 00:00:00',
updatedby='CJAMS-64883',
updatedon=now()
where progressnoteid = 'ce88f16e-96a1-4e8e-91d4-3ab999b9210a' and  witsid = '15861582';