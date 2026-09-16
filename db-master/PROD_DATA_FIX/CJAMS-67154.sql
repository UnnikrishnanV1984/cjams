
/*
Issue: Screen Out Case
Category/Module: Intake Details
Root cause: Referal needs to be screened out through data fix as it is past the scheduled date to be screened out and and remove the CPS IR .
Fix provided: Data fix has been done to update the Supervisor Disposition to ScreenOUT and also remove the CPS IR .
Data/Code fix ticket#: CJAMS-67154
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix done in the database to update the Supervisor Disposition to ScreenOUT.
*/
update intakesnapshot 
set
updatedby='CJAMS-67154',updatedon=now(),
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261013997798' and activeflag=1;

update intakedastaging
set
updatedby='CJAMS-67154',updatedon=now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261013997798' and activeflag=1;
			
update routing
set supervisordecision='screenout',
activeflag = 0, routingstatustypeid=8,
updatedby='99a068e8-c725-4835-9aee-0712f9d4021c', updatedon='2026-04-07 10:27:07'
where routingid='fec05a27-cd75-48e6-aa3b-db3155c3e1ec' and objectid='I261013997798';

update intakeservicerequest 
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where servicerequestnumber = '261023727194'
and activeflag = 1;

update intakeservicerequestsdm 
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;


update intakeservicerequestdispositioncode 
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;

update caseassignment 
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where objectid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;

update  personprogramarea
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where objectid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;

update actor
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;


update intakeservicerequestactor
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;


update personrole
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;

update actorrelationship
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where intakeserviceid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;

update  personroletype
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where personroleid in ('f3335ddf-e664-4b67-9024-e4f8c1b5a48d','761c9242-2964-4ece-8b30-6dee098fc3e8','e9d0a121-e2e8-4dcc-93fd-09d0a0e565c1')
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CJAMS-67154',
updatedon = now()
where objectid = '0907d2f6-7011-4980-8e9e-6bca8b3e2758'
and activeflag = 1;