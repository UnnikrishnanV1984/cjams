/*
   Issue Description: CDM-32756
   Category/ Module  :SDM/Response timer
   Root cause: The Response time  shows the mandate is  showing overdue from the sameday  the case   screened 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update intakeservicerequestsdm set isnoimmed_neglectresponse =true,updatedby='CDM-32756',updatedon =now() where intakeserviceid ='364ca4a7-4588-45c1-9ea5-c1e4cda2f8b2';


update cjams.intakesnapshot
set jsondata = replace(jsondata ::text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json, 
updatedon = now(), 
updatedby = 'CDM-32756'
where intakenumber = 'I231010732573' and activeflag = 1;

update cjams.intakedastaging
set jsondata = replace(jsondata ::text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json, 
updatedon = now(), 
updatedby = 'CDM-32756'
where intakenumber = 'I231010732573' and activeflag = 1;

