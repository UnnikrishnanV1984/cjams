/*
   Issue Description: CDM-28455
   Category/ Module  : Stuck approval
   Root cause: This case plan 2 has been approved but is still showing in the supervisor's approval box. Could this please be removed?
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update routing set activeflag = 0, updatedby = 'CDM-28455', updatedon = now() where routingid = '27e0786f-2e09-4f9b-8326-365a99e1169b';