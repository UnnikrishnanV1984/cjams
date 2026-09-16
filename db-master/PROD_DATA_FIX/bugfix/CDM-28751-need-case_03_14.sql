/*
   Issue Description: CDM-28751
   Category/ Module  :revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  
*/

update routing set updatedby = 'CDM-28751', updatedon = now(),routingstatustypeid = 2 
where routingid = '545b7d02-0e0f-4d28-855b-72462f30cb27';

UPDATE intakesnapshot 
 set updatedby = 'CDM-28751', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I231010447451' AND activeflag=1;