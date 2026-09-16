/*
  Issue Description:  CDM-42704
   Category/ Module  :  Intake SDM
   Root cause: SEN check mark won't disappear after deleting person.
   Fix Provided: Datafix has been promoted to update the SEN flag.
    Pull request# N/A 
    Is Code fix Required?: No
    Code fix ticket#: CIDM-9800
    Reason why no related code fix: N/A
    Regression Impacts: N/A
*/


UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'false'))
    , updatedby = 'CDM-42704'
    , updatedon = now()
WHERE intakenumber = 'I241013173442' 
      AND activeflag=1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
    , updatedby = 'CDM-42704'
    , updatedon = now()
WHERE intakenumber = 'I241013173442' 
      AND activeflag = 1;
