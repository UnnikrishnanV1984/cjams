/*
Issue Description: CJAMS-61796 PADS Assessment
Category/Module: Assessment
Root cause: PADS assessment was completed and approved. User wanted to update the person name in question number 5.
Fix provided: Data fix has been done to correct the client name in PADS assessment.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should correct it.
*/

UPDATE assessment
SET submissiondata = jsonb_set(
                      jsonb_set(
                        submissiondata,
                        '{preliminaryForm,0,ispositivedrugscreenchildnames,0}',
                        to_jsonb('Aisheem Hawkins'::text),
                        false
                      ),
                      '{preliminaryForm,0,ispositivedrugscreenchild,0}',
                      to_jsonb('b1426c8b-62e6-407b-9ede-37447cb94b9c'::text),
                      false
                    )
WHERE submissiondata #>> '{preliminaryForm,0,ispositivedrugscreenchildnames,0}' = 'AISHEEM RASHAD YARBEROUGH'
   and submissiondata #>> '{preliminaryForm,0,ispositivedrugscreenchild,0}' = 'ca026e0b-4573-4b23-b6e2-99a33fa34f0c'
   and assessmentid = 'cb7403b2-20ee-4836-9fe0-76de06d07c77';