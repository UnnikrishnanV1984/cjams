-- CDM-9815 - Screen out intake and remove the service case

UPDATE intakesnapshot
SET
updatedby = 'CDM-9815', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100222997' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-9815', updatedon = now() where servicecaseid = 'b1639b53-4c07-4328-bf78-5c5679ddab3a' and activeflag = 1;
