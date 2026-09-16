 /*
  Issue Description: CDM-20301 - aged out but removal was started again
   Category/ Module  :  child welfare
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, removed case from application
   Backup before update/ delete:
*/

update intakesnapshot 
set  updatedby = 'CDM-20301', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010237843' AND activeflag=1;

update servicecase set activeflag =0, updatedby = 'CDM-20301', updatedon = now() where servicecasenumber = '221030014001' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-20301', updatedon = now()
where intakenumber = 'I221010237843'
and activeflag = 1;


update intakedastatus set status = 8, updatedby = 'CDM-20301', updatedon = now()
where intakenumber = 'I221010237843' and activeflag = 1;


update routing set activeflag  = 0,
updatedon  = now() ,
updatedby  = 'CDM-20301'
where routingid in ('a233fb3c-fd6f-4d43-b7a8-a9a6c9cf34e2', 'cd2b7970-aa94-45dd-9da4-325344131d18')
and activeflag  = 1;
