UPDATE intakesnapshot
SET
updatedby = 'CDM-11822', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100343394' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-11822', updatedon = now() where servicecasenumber = '2021090097396' and activeflag = 1;
