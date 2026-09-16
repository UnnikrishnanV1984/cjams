/*
Issue Description: CJAMS-61468 Removal of a name from an intake report
Category/Module: Intake
Root cause: User error and they want to delete o delete the person name as "Donna Jasper" and the respective phone number "(P)410.971.1923" on the intake narrative text box and in the CPS intake report for the intake I251013288326 since the intake was screened out on 05/16/2025 -11:00 AM.
Fix provided: Data fix has been done to update intake narrative information.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should fix it.
*/

UPDATE intakesnapshot
SET jsondata = jsonb_set(
        jsondata,
        '{General,Narrative}',
        to_jsonb(
            regexp_replace(
                (jsondata->'General'->>'Narrative'),
                '<p class="ql-align-justify">Donna Jasper.*?</p>',
                '',
                'g'
            )
        )
    ),
    updatedby = 'CJAMS-61468',
    updatedon = now()
WHERE jsondata->'General'->>'Narrative' LIKE '%Donna Jasper%'
  AND intakenumber = 'I251013288326'
  AND activeflag = 1;