-- Case ID: I202000404417

-- Root cause: Data fix updated the intake number to screenout
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-21541', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000404417' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-21541', updatedon = now() where intakenumber = 'I202000404417';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-21541', updatedon = now()
	
	where intakenumber = 'I202000404417'
	and activeflag = 1;
	
update intakedastatus 
	set status = 8, updatedby = 'CDM-21541', updatedon = now()
	where intakenumber = 'I202000404417'
	and activeflag = 1;


update investigation set activeflag = 0,  updatedby = 'CDM-21541', updatedon = now()
where intakeserviceid = '2121e5a8-f075-4b0f-b70b-981cd8964eb0';
