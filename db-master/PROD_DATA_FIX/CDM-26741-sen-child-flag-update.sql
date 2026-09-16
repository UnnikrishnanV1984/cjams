/*
    Issue Description:  CDM-26741
    Category/ Module:  Intake
    Root cause: SDM Sen flag not enabled even with the active sen child
*/

UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'true'))
    , updatedby = 'CDM-26741'
    , updatedon = now()
WHERE intakenumber = 'I221010338898' AND activeflag = 1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
    , updatedby = 'CDM-26741'
    , updatedon = now()
WHERE intakenumber = 'I221010338898' AND activeflag = 1;