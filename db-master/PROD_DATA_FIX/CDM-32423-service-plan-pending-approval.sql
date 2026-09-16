/*
   Issue Description: CDM-32423
   Category/ Module  :Service Plan
   Root cause: pending service plan approval in approval inbox , but no service plan corresponding to it to approve/reject
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update routing set activeflag = 0, updatedby = 'CDM-32423' ,updatedon =now() where routingid ='8470b6e4-6f69-4d0e-af65-6183023c8922';