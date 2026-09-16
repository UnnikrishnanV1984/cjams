/*
Issue:251030570093:Incorrect date entered for date assessment initiated. The date entered is for 9 months prior to the case opening. It should be the same date as the assessment was completed.
Root Cause:The user wanted to change the assessmentInitDate in MFIRA, but they did not have permission to edit that field in the system. Since the system blocks them from making that update.
Fix Provided (Data Fix Only):updated on assessment table.
Data/Code fix ticket#: CJAMS-63607
Regression Impacts:None 
Is Code fix Required?:No
Code fix ticket#:N/A
Reason why no related code fix:User Error
Backup before update/delete:
*/


 UPDATE cjams.assessment
SET submissiondata = jsonb_set(
    			submissiondata::jsonb,
    			'{familyHOUSEHOLD,assessmentInitDate}',
    					'"2025-10-03T18:24:00.000Z"',
    											false
),updatedby  = 'CJAMS-63607', updatedon = now()
WHERE
assessmentid IN (
      '72cfbeda-f515-4978-92b1-dfd9b7c5f720'
  )
  AND activeflag = 1;
 
 
  UPDATE cjams.assessment_history 
SET submissiondata = jsonb_set(
    			submissiondata::jsonb,
    			'{familyHOUSEHOLD,assessmentInitDate}',
    					'"2025-10-03T18:24:00.000Z"',
    											false
),updatedby  = 'CJAMS-63607', updatedon = now()
WHERE
assessmenthistoryid  IN (
      'bc4bf1b7-9a22-41c7-9bf0-73ce0ae58342'
  )
  AND activeflag = 1;


