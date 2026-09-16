/*
Issue:MFIRA checkbox not auto-selecting even though all children and alleged victim assessments are marked as “Satisfied.”
Root Cause:The system is not automatically checking the MFIRA box even though all children and the alleged victim are marked as “Satisfied.” This happens because the client’s Date of Death (August 6, 2025) is after the date when the MFIRA assessment was started (July 31, 2025 at 3:00 PM). The current logic only auto-checks the MFIRA box when the assessment is started after the date of death. When the death date is later than the assessment date, the checkbox does not populate automatically. Due to this date order, the MFIRA checkbox remains unchecked even though all required assessments have been completed.
Fix Provided (Data Fix Only):One-time data correction done in tb_payment_header and tb_payment_detail to adjust Payment ID 4732287 from 3 days ($82.35) ? 2 days ($54.90).April total now equals 30 days ($823.50).
Data/Code fix ticket#: CIDM-10859
Regression Impacts:None 
Is Code fix Required?:yes
Code fix ticket#: CDM-44547
Reason why no related code fix:CDM-44547
Backup before update/delete:
*/


UPDATE cjams.assessment
SET submissiondata = jsonb_set(
    			submissiondata::jsonb,
    			'{familyHOUSEHOLD,assessmentInitDate}',
    					'"2025-07-31T18:45:00.000Z"',
    											false
),updatedby  = 'CIDM-10859', updatedon = now()
WHERE assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'  -- MFIRA template
  AND assessmentid IN (
      '2ab13747-c4c9-4ef2-89d5-7c22cc882f37',
      '930779be-82d1-4a87-be60-092fb834a9e4',
      'e11df715-5009-4745-a36d-e979779d183f',
      '76d45387-50c1-43bc-ba75-899678cf6a35',
      'e8513e2e-0048-4d9a-97c6-56d5d9c3f131'
  )
  AND activeflag = 1;
 
 
 UPDATE cjams.assessment_history 
SET submissiondata = jsonb_set(
    			submissiondata::jsonb,
    			'{familyHOUSEHOLD,assessmentInitDate}',
    					'"2025-07-31T18:45:00.000Z"',
    											false
),updatedby  = 'CIDM-10859', updatedon = now()
where assessmenthistoryid  in ('dfd87e7b-afe6-4f10-b0a7-3c94d8b187d2',
'4b8b66ed-0922-4246-a324-956e95490c6f',
'6c330e2d-1c07-44ef-b90c-f30cf9f7243f',
'bdc6366f-6767-4e8c-8b34-9778205584ce',
'a71d9796-aaeb-4df2-8fae-4a6eefae7bee') and activeflag  =1;


UPDATE cjams.assessment
SET submissiondata = jsonb_set(
    			submissiondata::jsonb,
    			'{familyHOUSEHOLD,assessmentInitDate}',
    					'"2025-10-02T19:08:00.000Z"',
    											false
),updatedby  = 'CIDM-10859', updatedon = now()
WHERE assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'  -- MFIRA template
  AND assessmentid IN (
      'c65ab412-8463-444f-8584-316a069438c0'
  )
  AND activeflag = 1;