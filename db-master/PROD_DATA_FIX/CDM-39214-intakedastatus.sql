UPDATE cjams.intakeservicerequest
SET activeflag = 1, updatedby='CDM-39214', updatedon=now()
WHERE intakenumber='I231010595677';

UPDATE intakedastaging
SET
updatedby = 'CDM-39214', updatedon = now(), status = 'Closed', ispreintake= true, jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010595677' AND activeflag=1;

update routing 
set eventcode = 'INTR'
where objectid =  'I231010595677' and routingid = 'e6f74eba-2104-4c73-8a7a-f18ba7c2c6d8';