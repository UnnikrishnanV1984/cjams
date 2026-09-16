/*
  Issue Description:  CDM-31388
   Category/ Module  : Intake 
   Root cause:Case disappeared
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

select * from createservicecase('2ddafbda-467c-473a-9fa5-22b61b615904', null,1,'f1cf9288-a9b3-4965-8058-dd15906883e9','intake');



update 
intakeservicerequest 
set 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-31388'
where 
intakeserviceid = '2ddafbda-467c-473a-9fa5-22b61b615904';