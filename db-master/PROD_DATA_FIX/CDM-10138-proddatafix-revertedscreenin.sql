-- CDM-10138 - reverting supervisor decision --
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10138', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I202100426307' AND activeflag=1;