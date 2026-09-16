/*
   Issue Description: CDM-29786
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 8464
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
set activeflag =0,
 updatedby = 'CDM-29786', 
 updatedon = now() 
 where routingid = 'bc5160ae-3604-4798-8108-987314ec053c';
