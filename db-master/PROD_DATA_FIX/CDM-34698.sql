/* 
    Issue Description: CDM-34698
   Category/ Module  : Workload screen
   Root cause:  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update IntakeDAStaging set CRUWorkerName='8d192f5a-28fa-4a57-8c27-345e61ceb8f7',updatedon =now(),updatedby='CDM-34698' 
where intakenumber='I202000569736' and activeflag =1;