/*
   Issue Description: CDM-29766
   Category/ Module  : 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-29766', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010549026' AND activeflag=1;

UPDATE intakedastaging SET
updatedby = 'CDM-29766', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010549026' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-29766', updatedon = now()  
where intakeserviceid = '7d39f17c-de26-4333-86d2-3dddb88a07fa' and activeflag = 1;


update routing set routingstatustypeid=8, updatedby = 'CDM-29766', updatedon = now() 
where routingstatustypeid=21 and objectid='I231010549026';

