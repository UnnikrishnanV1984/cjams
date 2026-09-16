/*
   Issue Description: CDM-36447 Intake Screenout/Supervisor Decison Override
   Category/ Module  :Intake Decision
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed and changed status to screenout
*/

-- intakedastaging
select status,activeflag,updatedby,* from intakedastaging where intakenumber ='I241011935246' and activeflag =1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36447', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I241011935246' AND activeflag =1;


