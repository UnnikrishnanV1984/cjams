-- CDM-9651 - Screen out the intake and remove the newly created case out of it

UPDATE intakesnapshot
SET
updatedby = 'CDM-9651', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100522240' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-9651', updatedon = now() where servicecaseid = '8e6793f0-ce5c-4924-bd4e-0cff001cd149' and activeflag = 1;
