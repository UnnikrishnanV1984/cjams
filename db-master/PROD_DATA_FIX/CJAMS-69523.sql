/*
Issue Description: CJAMS-69523
Category/Module: Response Timer / Overdue Reason (Legislative Required Reporting)
Root cause: A duplicate Plan of Safe Care was created for the assessment, which prevented the case from being closed out due to the duplicate active record..
Fix provided: The duplicate Plan of Safe Care and associated routing record were updated to ensure the correct active record is maintained.
              The duplicate assessment-related records were addressed, allowing the case to proceed with closure.
Is code fix required : N
Reason why no related code fix: User error
Regression impacts: NA
*/

UPDATE safecareplan
SET activeflag = 0,
    updatedby = 'CJAMS-69523',
    updatedon = now()
WHERE safecareplanid = 'ac517eb5-24f6-44ac-9e2b-61e8b7badb94'
  AND activeflag = 1;


UPDATE routing
SET activeflag = 0,
    updatedby = 'CJAMS-69523',
    updatedon = now()
WHERE objectid = '2f2af1d0-7f93-49c5-8803-fa9f37b38110'
  AND activeflag = 1;