
-- CDM-10138          
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10138', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '"Review"'))))
WHERE intakenumber = 'I202100426307' AND activeflag=1;
          
update routing set routingstatustypeid = 1 where objectid = 'I202100426307' and activeflag = 1;