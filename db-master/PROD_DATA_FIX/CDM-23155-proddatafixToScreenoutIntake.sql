/*
   Issue Description: CDM-23155
   Category/ Module  : Prod data fix to screenout Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakesnapshot SET 
updatedby = 'CDM-23155 ', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000077037' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-23155', updatedon = now()
where intakenumber = 'I202000077037' and activeflag = 1;

update intakeservicerequest set activeflag =0, updatedby = 'CDM-23155', updatedon = now() 
where servicerequestnumber = '20200246032661' and activeflag =1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-23155', updatedon = now()
where objectid in (select intakeserviceid::character varying
    from intakeservicerequest where servicerequestnumber = '20200246032661')
and activeflag = 1;
