/* 
   Issue Description: CDM-25659
   Category/ Module  : approval 
   Root cause: user wants is unable tp approve record  
   Pull request# for code fix: 6518
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-25659', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010322705' AND activeflag=1;

--routingstatustypeid = 2
update routing set routingstatustypeid = 1,updatedby = 'CDM-25659', updatedon = now() where objectid = 'I221010322705' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-25659' , updatedon = now() where intakenumber = 'I221010322705' and activeflag = 1;