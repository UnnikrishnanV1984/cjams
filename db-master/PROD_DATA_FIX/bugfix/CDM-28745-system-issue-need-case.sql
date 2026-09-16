/*
   Issue Description: CDM-28745
   Category/ Module  : revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new case number : 231030066769
*/


UPDATE intakesnapshot 
 set updatedby = 'CDM-28745', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231010424471' AND activeflag=1;