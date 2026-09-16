-- CDM-10006 - Screen out the intake and remove the newly created case out of it

UPDATE intakesnapshot
SET
updatedby = 'CDM-10006', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100125142' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-10006', updatedon = now() where servicecaseid = '64d3b893-7e7d-4c70-ad3d-7ba27e22351b' and activeflag = 1;
