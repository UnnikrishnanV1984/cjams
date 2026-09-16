/*
   Issue Description: CDM-40536
   Category/ Module  :  SDM
   Root cause: user requested to update the Provider Involved Maltreatment from YES to "NO" in the SDM & Maltreatment Allegation screen.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update Intakeservicerequestsdm set updatedby='CDM-40536', updatedon=now(), ismaltreatment= false 
where  intakeserviceid = '74203ae2-92cc-40d3-aeb3-aa94bc060ddf' and activeflag=1;

UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CDM-40536',
    updatedon = now()            
WHERE intakenumber = 'I241012113048' 
  AND activeflag = 1;
 
 
UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CDM-40536',
    updatedon = now()            
WHERE intakenumber = 'I241012113048' 
  AND activeflag = 1;



