UPDATE intakesnapshot
set updatedby = 'CDM-11493',
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{General}',
jsonb_set(jsondata->'General', '{RecivedDate}', '"3/20/2021, 11:30:00 AM"'))
WHERE intakenumber = 'I202100139582' AND activeflag=1;