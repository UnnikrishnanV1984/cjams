/*
   Issue Description: CDM-29934
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing
 set activeflag = 0 ,
updatedby ='CDM-29934',
updatedon = now()
where routingid = '81695b8f-0f98-41a8-9cfc-181c71089d2c';
