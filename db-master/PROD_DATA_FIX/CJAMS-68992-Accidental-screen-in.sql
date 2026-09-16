/*
   Issue Description: CJAMS-68992
   Category/ Module  : CJAMS - Intake
   Root cause: Need the data fix to reject the intake I261014126890

            Please investigate is there any case is created or not
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-68992', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014126890' AND activeflag=1;


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-68992', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014126890' AND activeflag=1;



update intakeDAStatus set status = 8, updatedby = 'CJAMS-68992', updatedon = now() 
where intakenumber = 'I261014126890' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-68992', updatedon = now()
where intakenumber = 'I261014126890' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-68992', updatedon = now() 
where intakenumber = 'I261014126890' and activeflag =1;


Update routing 
set updatedby = 'CJAMS-68992', updatedon = now(),activeflag =0,supervisordecision='screenout' ,routingstatustypeid = 8
WHERE objectid = 'I261014126890' and activeflag =1;



