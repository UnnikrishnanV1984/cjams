/*
   Issue Description: CDM-28345
   Category/ Module  : Removal
   Root cause::Please remove this from my dashboard.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing 
set activeflag = 0, updatedby = 'CDM-28345', updatedon = now()
where routingid = '1818cb78-f3b4-4dfa-925d-573b61e47d7a'

