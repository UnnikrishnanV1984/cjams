/*
Issue: CJAMS-64465 wont allow me to assign case
Category/Module: Intake 
Root cause: User has created a different intake for the client and data fix is needed to screenout the intake # I261013693247
Fix provided:  Data fix has been done to screenout the intake # I261013693247
Data/Code fix ticket#: CJAMS-64465
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed.
*/


UPDATE 	intakesnapshot 
SET 	updatedby = 'CJAMS-64465 ', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261013693247' AND activeflag=1;

update 	intakedastaging 
set 	status = 'Closed', 
		updatedby = 'CJAMS-64465', 
		updatedon = now()
where 	intakenumber = 'I261013693247' and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag =0, 
		updatedby = 'CJAMS-64465', 
		updatedon = now() 
where 	intakenumber = 'I261013693247' and activeflag =1;

update 	personprogramarea 
set 	activeflag = 0, 
		updatedby = 'CJAMS-64465', 
		updatedon = now()
where 	objectid in (select intakeserviceid::character varying
    					from intakeservicerequest where intakenumber = 'I261013693247')
		and activeflag = 1;

--Not updating the audit columns as it will impact the submission History
update routing
set routingstatustypeid = 8,
	supervisordecision = 'ScreenOUT'
	--updatedon = now(),
	--updatedby = 'CJAMS-64465'
where objectid = 'I261013693247'
and activeflag =1;