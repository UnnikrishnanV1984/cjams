/*
   Issue Description: CJAMS-69284
   Category/ Module  : CJAMS - Intake - CPS  IR
   Root cause: user wants to screen out intake I261014129846 .After the data fix is done make sure Case Number : 261023849739 is also removed.
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

update intakedastaging
set status = 'Closed',
updatedby = 'CJAMS-69284', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014129846' AND activeflag=1;

update intakesnapshot 
set updatedby = 'CJAMS-69284', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261014129846' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', 
	activeflag =0, 
	routingstatustypeid = 8, 
	updatedby = 'CJAMS-69284', 
	updatedon = now()
where objectid = 'I261014129846' and activeflag =1;

-- select * from intakedastatus where intakenumber ='I261014129846';

update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-69284', updatedon = now() 
where intakenumber = 'I261014129846' and activeflag =1;

-- select * from intakeservicerequest where servicerequestnumber='261023849739';

update intakeservicerequest
set activeflag=0, updatedby = 'CJAMS-69284', updatedon = now() 
where servicerequestnumber='261023849739' and activeflag =1;

-- select * from caseassignment where objectid='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag=1;

update caseassignment
set activeflag=0, updatedby = 'CJAMS-69284', updatedon = now() 
where objectid ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select activeflag,* from intakeservicerequestsdm where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea';

update intakeservicerequestsdm 
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select activeflag,* from intakeservicerequestdispositioncode where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea';

update intakeservicerequestdispositioncode 
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from personprogramarea where objectid='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag=1;

update personprogramarea 
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where objectid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from actor where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea';

update actor  
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from intakeservicerequestactor where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag=1;

update intakeservicerequestactor  
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from personrole where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea';

update personrole  
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from actorrelationship where intakeserviceid='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag=1;

update actorrelationship  
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where intakeserviceid  ='4dd3a686-f897-4b7f-a67f-771013807cea' and activeflag = 1;

-- select * from personroletype where personroleid in ('9282b61a-c357-4814-b1b1-300cff71c3e4', 'ae3ac265-ca49-4913-818a-96c3c5ba9d5f', 
-- '9d904170-29b7-4ff7-8054-c6ca32320ae7', '8751faeb-8943-4b35-a1ac-49ab3d2860c0', 'fbfe902e-4b91-4dce-8ab9-74d818933d79') and activeflag = 1; 

update personroletype  
set activeflag =0, updatedby = 'CJAMS-69284', updatedon = now()
where personroleid in ('9282b61a-c357-4814-b1b1-300cff71c3e4', 'ae3ac265-ca49-4913-818a-96c3c5ba9d5f', 
'9d904170-29b7-4ff7-8054-c6ca32320ae7', '8751faeb-8943-4b35-a1ac-49ab3d2860c0', 'fbfe902e-4b91-4dce-8ab9-74d818933d79') and activeflag = 1;
