/*
   Issue Description: CDM-32626
   Category/ Module  :SDM/Response timer
   Root cause: The Response time  shows the mandate is  showing overdue from the sameday  the case   screened 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update intakeservicerequestsdm set isnoimmed_neglectresponse =true,updatedby='CDM-32626',updatedon =now() where intakeserviceid ='e40a7a62-3a22-4f63-a5df-57f9da7eedd3';


update cjams.intakesnapshot
set jsondata = replace(jsondata ::text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json, 
updatedon = now(), 
updatedby = 'CDM-32626'
where intakenumber = 'I231010697539' and activeflag = 1;

update cjams.intakedastaging
set jsondata = replace(jsondata ::text , '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json, 
updatedon = now(), 
updatedby = 'CDM-32626'
where intakenumber = 'I231010697539' and activeflag = 1;
