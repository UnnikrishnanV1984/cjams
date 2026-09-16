/*
  Issue Description: CDM-22778
   Category/ Module  : Referral change and delete case
   Root cause: user wants to change referral
   Pull request# for code fix: 5556, 5565
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-22778', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000567698' AND activeflag=1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-22778', updatedon = now() 
where servicerequestnumber = '20200192024002' and activeflag =1;

update intakedastatus set status = '8', updatedby = 'CDM-22778' , 
updatedon = now() where intakenumber = 'I202000567698' and activeflag = 1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-22778', updatedon = now()
where intakenumber = 'I202000567698' and activeflag = 1;