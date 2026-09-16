/*
   Issue Description: CDM-27524
   Category/ Module  : SDM tab
   Root cause: user wants to check the SEN flag for child
   Pull request# for code fix: 7336
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'true'))
    , updatedby = 'CDM-27524'
    , updatedon = now()
WHERE intakenumber = 'I221010351410' AND activeflag = 1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
    , updatedby = 'CDM-27524'
    , updatedon = now()
WHERE intakenumber = 'I221010351410' AND activeflag = 1;
