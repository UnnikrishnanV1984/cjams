
/*
Issue: CJAMS-68168 Intake Screenout
Category/Module: screen out referral
Root cause: Please carry out data fix to Screen Out the Intake # I261014091842
Fix provided:  Data fix is done screenout the intake  I261014091842
Data/Code fix ticket#: CJAMS-68168
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/
UPDATE 	intakesnapshot 
SET 	updatedby = 'CJAMS-68168', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261014091842' AND activeflag=1;


update 	intakedastaging 
set 	status = 'Closed', 
		updatedby = 'CJAMS-68168', 
		updatedon = now()
where 	intakenumber = 'I261014091842' and activeflag = 1;

update routing
set routingstatustypeid = 8,activeflag=0,
	supervisordecision = 'ScreenOUT', updatedon= now()
where objectid = 'I261014091842'
and activeflag =1;


update intakeDAStatus set status = 8, updatedby = 'CJAMS-68168', updatedon = now() 
where intakenumber = 'I261014091842' and activeflag =1;