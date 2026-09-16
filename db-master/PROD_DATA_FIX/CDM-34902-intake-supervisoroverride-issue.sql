/*
   Issue Description: CDM-34902
   Category/ Module  : Prod data fix to make intake close
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-34902', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011378741' AND activeflag=1;


UPDATE intakesnapshot
SET
updatedby = 'CDM-34902', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011378741' ;

update intakedastatus 
	set status = 8, updatedby = 'CDM-34902', updatedon = now()
	where intakenumber = 'I231011378741'
	and activeflag = 1;



update routing set routingstatustypeid =8 ,updatedby = 'CDM-34902', updatedon = now() where objectid='I231011378741';