-- CDM-10232 - Screen out the referral

update intakedastaging set activeflag =1, updatedby = 'CDM-10232', updatedon =now() where intakenumber in ('I202000464110') and id=158608;
update intakedastatus set activeflag =1, updatedby = 'CDM-10232', updatedon =now() where intakenumber in ('I202000464110');
update intakesnapshot set activeflag =1, updatedby = 'CDM-10232', updatedon =now() where intakenumber in ('I202000464110');
UPDATE intakesnapshot
SET
updatedby = 'CDM-10232', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000464110' AND activeflag=1;
