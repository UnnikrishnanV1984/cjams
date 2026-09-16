/*
   Issue Description: CJAMS-68379
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake I261014099404 .After the data fix is done make sure Case Number : 261030705511 is also removed.
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

update intakedastaging
set status = 'Closed',
updatedby = 'CJAMS-68379', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014099404' AND activeflag=1;

update intakesnapshot 
set updatedby = 'CJAMS-68379', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014099404' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', 
	activeflag =0, 
	routingstatustypeid = 8, 
	updatedby = 'CJAMS-68379', 
	updatedon = now()
where objectid = 'I261014099404' and activeflag =1;

update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-68379', updatedon = now() 
where intakenumber = 'I261014099404' and activeflag =1;

update servicecase 
set activeflag = 0, updatedby = 'CJAMS-68379', updatedon = now() 
where servicecasenumber='261030705511' and activeflag =1;

update servicecasedisposition
set activeflag=0, updatedby = 'CJAMS-68379', updatedon = now() 
where servicecaseid = 'f35f71f7-13a0-4676-90e0-51606e4c8f0e' and activeflag = 1;

update caseassignment
set activeflag=0, updatedby = 'CJAMS-68379', updatedon = now() 
where objectid ='f35f71f7-13a0-4676-90e0-51606e4c8f0e' and activeflag = 1;

update servicecaserequest
set activeflag=0, updatedby = 'CJAMS-68379', updatedon = now() 
where servicecaseid = 'f35f71f7-13a0-4676-90e0-51606e4c8f0e' and activeflag=1;

update routing
set activeflag=0, updatedby = 'CJAMS-68379', updatedon = now() 
where objectid = 'f35f71f7-13a0-4676-90e0-51606e4c8f0e' and activeflag=1;
