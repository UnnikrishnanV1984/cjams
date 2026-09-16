-- CDM-10587 - Remove AR case and screen out intake

UPDATE intakesnapshot
SET
updatedby = 'CDM-10587', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000657208' AND activeflag=1;

update intakeservicerequest set activeflag=0,updatedby = 'CDM-10587',updatedon = now() where servicerequestnumber=2020034015178;