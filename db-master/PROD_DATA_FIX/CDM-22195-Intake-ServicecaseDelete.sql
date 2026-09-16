/*
   Issue Description: CDM-22195
   Category/ Module  : inatke screenout 
   Root cause: user wants to delete service case type
   Pull request# for code fix: 5473
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-22195', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000110236' AND activeflag=1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-22195', updatedon = now() 
where servicerequestnumber = '20200356065135' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-22195', updatedon = now()
where intakenumber = 'I202000110236' and activeflag = 1;