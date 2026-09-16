/*
   Issue Description: CJAMS-69249
   Category/ Module  : Case status changed 
   Root cause: user requeseted to update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest 
set activeflag = 0, actiontype = NULL, updatedon= NOW(), updatedby='CJAMS-69249'
where intakeserviceid = 'bcc2deb5-5d35-4b02-867f-cf828f62765e' AND activeflag = 1;


update intakesnapshot 
set jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isir}', 'false')), updatedby = 'CJAMS-69249',updatedon = now()
where intakenumber = 'I261014104597' and activeflag = 1;

update intakesnapshot 
set jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isroh}', 'true')), updatedby = 'CJAMS-69249',updatedon = now()
where intakenumber = 'I261014104597' and activeflag = 1;

update intakedastaging 
set jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isir}', 'false')), updatedby = 'CJAMS-69249',updatedon = now()
where intakenumber = 'I261014104597' and activeflag = 1;

update intakedastaging 
set jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isroh}', 'true')), updatedby = 'CJAMS-69249',updatedon = now()
where intakenumber = 'I261014104597' and activeflag = 1;

update intakeservicerequestsdm 
set activeflag = 0, updatedby = 'CJAMS-69249',updatedon = now()
where intakeserviceid='bcc2deb5-5d35-4b02-867f-cf828f62765e' and activeflag = 1;
