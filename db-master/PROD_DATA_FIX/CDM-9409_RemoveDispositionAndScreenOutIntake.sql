-- CDM-9409 - Screen out intake and remove the latest in progress disposition record to close the case

update servicecasedisposition set activeflag=0, updatedby = 'CDM-9409', updatedon = now() where servicecasedispositionid='8f6e9751-5354-4b7e-bc14-3e9be0372091';

UPDATE intakesnapshot
SET
updatedby = 'CDM-9409', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100220532' AND activeflag=1;
