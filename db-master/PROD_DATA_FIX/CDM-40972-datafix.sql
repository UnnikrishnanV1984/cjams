/*
  Issue Description:  CDM-40972
   Category/ Module  :  Application
   Root cause: As intake is not submitted for supervisor approval removing the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update intakedastaging 
set activeflag =0,
updatedby ='CDM-40972',
updatedon =now()
where intakenumber ='I202100034239' and activeflag =1;


update intakedastatus 
set activeflag =0,
updatedby ='CDM-40972',
updatedon =now()
where intakenumber ='I202100034239' and activeflag =1;