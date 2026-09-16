

/*
Issue Description: this needs to be screened out
Category/Module: case management 
Root cause: User requested to Screen Out Intake# I261013942256 and remove the CPS AR# 261023673333.
Fix provided: Data fix done to Screen Out Intake# I261013942256 and remove the CPS AR# 261023673333.
Data/Code fix ticket#: CJAMS-67635
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User request
*/
UPDATE intakesnapshot 
SET updatedby = 'CJAMS-67635', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013942256' AND activeflag=1;

UPDATE 	intakedastaging 
SET 	updatedby = 'CJAMS-67635', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261013942256' AND activeflag=1;

update cjams.routing
	set eventcode = 'INTR', 
		routingstatustypeid = 8,
        activeflag=0, 
		supervisordecision = 'screenout',
		updatedon = now(), 
		updatedby = 'CJAMS-67635'
	where routingid = '4a62d24b-4494-47d5-b8b4-735f750a5188'
    and objectid = 'I261013942256';
   
 
	
update cjams.intakedastatus
	set status = 8,  
		updatedon = now(), 
		updatedby = 'CJAMS-67635'
	where intakenumber = 'I261013942256'
		and activeflag = 1;	
		
update cjams.intakedastaging
	set status = 'Closed',  
		updatedon = now(), 
		updatedby = 'CJAMS-67635'
	where intakenumber = 'I261013942256'
		and activeflag = 1;

-- To show the status as Closed in Screen Out Dashboard	and remove the case
update cjams.intakeservicerequest 
	set activeflag = 0,
        actiontype = null,
		updatedon = now(),
		updatedby = 'CJAMS-67635'
	where intakeserviceid  = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a';

update intakeservicerequestsdm 
	set activeflag = 0,
	updatedby = 'CJAMS-67635',
	updatedon = now()
	where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
	and activeflag = 1;

update intakeservicerequestdispositioncode 
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update caseassignment 
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where objectid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update  personprogramarea
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where objectid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update actor
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update personrole
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update actorrelationship
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where intakeserviceid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;

update  personroletype
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where personroleid in ('12e31877-a5c9-4fa0-acdb-178fe343e240','5702ea93-37fd-4a31-b8a9-c5e2c4dc6b4b')
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CJAMS-67635',
updatedon = now()
where objectid = 'b2dadd36-1c0a-4180-a280-a0a41b55dd1a'
and activeflag = 1;