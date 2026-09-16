/*
   Issue Description: CJAMS-68446
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake I261014103918 .After the data fix is done make sure Case Number : 3297084 is also removed.
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

update intakedastaging
set status = 'Closed',
updatedby = 'CJAMS-68446', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014103918' AND activeflag=1;

update intakesnapshot 
set updatedby = 'CJAMS-68446', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014103918' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', 
	activeflag =0, 
	routingstatustypeid = 8, 
	updatedby = 'CJAMS-68446', 
	updatedon = now()
where objectid = 'I261014103918' and activeflag =1;

update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-68446', updatedon = now() 
where intakenumber = 'I261014103918' and activeflag =1;

update intakeservicerequest 
set servicecaseid =null, updatedby = 'CJAMS-68446', updatedon = now() 
where intakenumber ='I261014103918';
