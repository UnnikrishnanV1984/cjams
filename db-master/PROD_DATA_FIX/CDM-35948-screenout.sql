/*
   Issue Description: CDM-35948
   Category/ Module  :Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is now ready for user to make changes in decision field.
*/

select * from intakesnapshot where intakenumber ='I231011688481';

select status,activeflag,updatedby,* from intakedastaging where intakenumber ='I231011688481' and activeflag =1;

UPDATE intakedastaging
SET updatedby = 'CDM-35948', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231011688481' AND activeflag=1;