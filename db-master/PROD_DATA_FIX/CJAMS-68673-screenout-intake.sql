/*
   Issue Description: CJAMS-68673
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake I261014087810 .After the data fix is done make sure Case Number : 261023814865 is also removed.
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

update intakedastaging
set status = 'Closed',
updatedby = 'CJAMS-68673', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014087810' AND activeflag=1;

update intakesnapshot 
set updatedby = 'CJAMS-68673', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014087810' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', 
	activeflag =0, 
	routingstatustypeid = 8, 
	updatedby = 'CJAMS-68673', 
	updatedon = now()
where objectid = 'I261014087810' and activeflag =1;

update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-68673', updatedon = now() 
where intakenumber = 'I261014087810' and activeflag =1;

update intakeservicerequest
set activeflag=0, updatedby = 'CJAMS-68673', updatedon = now() 
where servicerequestnumber='261023814865' and activeflag =1;

update caseassignment
set activeflag=0, updatedby = 'CJAMS-68673', updatedon = now() 
where objectid ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update routing
set activeflag=0, updatedby = 'CJAMS-68673', updatedon = now() 
where objectid = 'db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag=1;

update intakeservicerequestsdm 
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update intakeservicerequestdispositioncode 
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update personprogramarea 
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where objectid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update actor  
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update intakeservicerequestactor  
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update personrole  
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update actorrelationship  
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where intakeserviceid  ='db62a4c7-5088-4062-922d-387533e2ca1b' and activeflag = 1;

update personroletype  
set activeflag =0, updatedby = 'CJAMS-68673', updatedon = now()
where personroleid in ('31335a72-7726-4a2e-bba2-81a595ca991b', '5de2ab30-c455-48b7-9cf7-70291bcdc5e8') and activeflag = 1;
