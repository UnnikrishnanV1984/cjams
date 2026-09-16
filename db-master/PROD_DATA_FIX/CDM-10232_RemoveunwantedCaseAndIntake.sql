-- CDM-10232 - Remove the case and intake number that got created unnecessarily

update intakeservicerequest set activeflag =0 where intakeserviceid = '78184c9c-04bc-4eaf-94de-54a6fffab633' and activeflag =1;

UPDATE intakesnapshot
SET
updatedby = 'CDM-10232', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000464110' AND activeflag=1;