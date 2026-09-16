/*
   Issue Description: Please do a data fix to change the marital statuses from "single" and "medical records." to "Married Couple" for both parents (Jennifer and Brad Irvin) in the CPS intake report. 
   Category/ Module  : CPS report
   Root cause: System error, for report regarding the maritial status is coming from the table called intakesnapshot
   and everytime we update the person status we paralley update on the person table but intakesnapshot is not being updated as there is logic missing to do so.
   Pull request# for code fix: 
   Reason why no related code fix: System Error
   Codefix ticket: CDM-44487
*/
UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata,
    '{persondetails,Person}',
    (
        SELECT jsonb_agg(
            CASE
                WHEN person->>'cjamspid' IN ('204199247', '204199246') THEN
                    jsonb_set(person, '{maritalstatus}', '"Married couple"')
                ELSE
                    person
            END
        )
        FROM jsonb_array_elements(jsondata->'persondetails'->'Person') AS person
    )
),
updatedby = 'CIDM-10744',
updatedon = now()
WHERE intakenumber = 'I251013341125' and activeflag =1;
