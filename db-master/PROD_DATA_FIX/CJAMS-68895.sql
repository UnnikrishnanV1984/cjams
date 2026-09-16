/*
Root cause: In the MFIRA and CANS F  assessment, Charlotte shows as "Biological Child" instead of "Adoptive Child" because she has two active relationship records to the head of household at the same time — an old ADPCHLD (Adoptive Child) and a newer BGCHLD (Biological Child).Her relationship was edited to Biological and back, but the save logic never deactivated the old record, so both stayed active. The MFIRA and CANS F screen picks the newer one (Biological Child), while the Relationship tab happens to show the Adoptive one — which is why the two screens disagree.
Calvin has only one active record, so he displays correctly. 
Fix provided: Data fix has been done to deactive the duplicate records
Regression impacts: N
Is code fix required: N
*/

UPDATE cjams.actorrelationship
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68895'
WHERE actorrelationshipid IN (
  '79a87aa6-988e-48a8-a93d-b5d0c64a1ed7',
  'd2f1c155-34da-4a05-ae0a-ada586dcd62c',
  '80a4a06a-7a0e-4f45-bee8-a6671d0a423f',
  '64a9e4bb-045f-40a5-a3a3-79390ef5a1fd'
) and activeflag=1;

UPDATE cjams.assessment
SET    submissiondata = replace(
                          replace(submissiondata::text, 'Biological Child',  'Adoptive Child'),
                          'Biological Mother', 'Adoptive Mother'
                        )::jsonb,
       actualdata     = replace(
                          replace(actualdata::text, 'Biological Child',  'Adoptive Child'),
                          'Biological Mother', 'Adoptive Mother'
                        )::json,
       updatedby      = 'c6bae00e-e715-4b79-9b70-cc185874738f',
       updatedon      = now()
WHERE  assessmentid = '6ce527d4-8a2e-4d23-a5a8-830bb6d42646'
  AND  activeflag = 1;