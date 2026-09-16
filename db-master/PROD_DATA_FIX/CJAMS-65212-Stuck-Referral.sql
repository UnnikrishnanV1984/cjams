/*
   Issue Description: CJAMS-65212
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-65212', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013885032' AND activeflag=1;


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-65212', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013885032' AND activeflag=1;



update intakeDAStatus set status = 8, updatedby = 'CJAMS-65212', updatedon = now() 
where intakenumber = 'I261013885032' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-65212', updatedon = now()
where intakenumber = 'I261013885032' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-65212', updatedon = now() 
where intakenumber = 'I261013885032' and activeflag =1;




update routing 
set updatedby = 'CJAMS-65212',updatedon = '2026-02-06 12:00:00'
WHERE objectid = 'I261013885032' and activeflag =0;


