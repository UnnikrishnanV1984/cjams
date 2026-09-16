/* 
   Issue Description: CJAMS-67069
   Category/ Module  : No Services Case Created
   Root cause: Issue is not replicable in stage3 ,we are able to create a case on screen in of an intake it might have caused due to system slowness
               We are keeping the intake back for supervisor approval , so they can screen in and create a case
   Fix provided: Data fix has been done modify the routing record and also supervisor status so that supervisor can screenin the intake 
   Is cose fix required : N , Since we are able to create cases on screen in of an intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing
set routingstatustypeid =1,
supervisordecision =null,
updatedby ='CJAMS-67069',
updatedon =now()
where routingid='f341c0de-9413-46f0-8a82-0142ea5b45be';

UPDATE intakesnapshot
set
updatedby = 'CJAMS-67069', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I261014004902' AND activeflag=1;

UPDATE intakedastaging
set
ispreintake = FALSE,
updatedby = 'CJAMS-67069', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I261014004902' AND activeflag=1;