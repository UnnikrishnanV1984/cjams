/*
   Issue Description: CDM-16564
   Category/ Module  :  
   Root cause: Removing incorrect living arrangement 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update placement
set updatedby = 'CDM-16564', updatedon = now(), activeflag = 0
where placementid = '97af6732-a049-496e-9be8-67a71469b420';

update routing 
set updatedby = 'CDM-16564', updatedon = now(), activeflag = 0
where objectid = '97af6732-a049-496e-9be8-67a71469b420';

update livingarrangement 
set updatedby = 'CDM-16564', updatedon = now(), activeflag = 0
where placementid = '97af6732-a049-496e-9be8-67a71469b420';