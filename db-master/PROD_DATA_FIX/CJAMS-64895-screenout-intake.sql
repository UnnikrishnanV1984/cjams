/*
Issue: CJAMS-64895 Case turned around and assigned clock started with original entry
Category/Module: Intake
Root cause: This is not a defect. The CPS AR#: 261023553439 is connected with intake I261013795665, intake was initially screened out on 01/23/2026 then supervisor override and screened in the intake on 01/27/2026.
The 2nd supervisor override can be conducted to screen out and remove the CPS AR case as the override timeframe has been due.
Data fix needed to screened out the intake and delete the connected CPS case.
    Intake: I261013795665
    Case: 261023553439
Fix provided:  Data fix has been done Data to screen out the intake and delete the connected CPS case.
    Intake: I261013795665
    Case: 261023553439
Data/Code fix ticket#: CJAMS-64895
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Override timeframe elapsed and data fix needed for this issue.
*/


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-64895', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013795665' AND activeflag=1;

UPDATE 	intakedastaging 
SET 	updatedby = 'CJAMS-64465 ', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261013795665' AND activeflag=1;

update cjams.routing
	set eventcode = 'INTR', 
		routingstatustypeid = 8,
        activeflag=0, 
		supervisordecision = 'screenout',
		updatedon = now(), 
		updatedby = 'CJAMS-64895'
	where routingid = '9c8cc026-aefe-4d3d-b7dc-da836892b5bc'
    and objectid = 'I261013795665';
	
update cjams.intakedastatus
	set status = 8,  
		updatedon = now(), 
		updatedby = 'CJAMS-64895'
	where intakenumber = 'I261013795665'
		and activeflag = 1;	
		
update cjams.intakedastaging
	set status = 'Closed',  
		updatedon = now(), 
		updatedby = 'CJAMS-64895'
	where intakenumber = 'I261013795665'
		and activeflag = 1;

-- To show the status as Closed in Screen Out Dashboard	and remove the case
update cjams.intakeservicerequest 
	set activeflag = 0,
        actiontype = null,
		intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 
		updatedon = now(),
		updatedby = 'CJAMS-64895'
	where intakeserviceid  = 'd3bea62a-a297-4ea2-8e68-97bc9d1380aa';


