/*
   Issue Description: CJAMS-69786
   Category/ Module  : CJAMS - Intake - CPS  IR
   Root cause: Need data fix to screen out to intake I261014150907
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

update intakedastaging
set status = 'Closed',
updatedby = 'CJAMS-69786', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014150907' AND activeflag=1;

update intakesnapshot 
set updatedby = 'CJAMS-69786', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014150907' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', 
	activeflag =0, 
	routingstatustypeid = 8, 
	updatedby = 'CJAMS-69786', 
	updatedon = now()
where objectid = 'I261014150907' and activeflag =1;


update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-69786', updatedon = now() 
where intakenumber = 'I261014150907' and activeflag =1;


update intakeservicerequest
set activeflag=0, updatedby = 'CJAMS-69786', updatedon = now() 
where intakenumber = 'I261014150907' and activeflag =1;


update caseassignment
set activeflag=0, updatedby = 'CJAMS-69786', updatedon = now() 
where objectid ='9e8a8b45-9418-4f1f-bd53-5701cc1eeeb9' and enddate is null and activeflag = 1;


update intakeservicerequestsdm 
set activeflag =0, updatedby = 'CJAMS-69786', updatedon = now()
where intakeserviceid  ='9e8a8b45-9418-4f1f-bd53-5701cc1eeeb9' and activeflag = 1;


update intakeservicerequestdispositioncode 
set activeflag =0, updatedby = 'CJAMS-69786', updatedon = now()
where intakeserviceid  ='9e8a8b45-9418-4f1f-bd53-5701cc1eeeb9' and activeflag = 1;


update personprogramarea 
set activeflag =0, updatedby = 'CJAMS-69786', updatedon = now()
where objectid  ='9e8a8b45-9418-4f1f-bd53-5701cc1eeeb9' and enddate is null and activeflag = 1;

