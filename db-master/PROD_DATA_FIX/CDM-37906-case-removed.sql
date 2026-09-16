/*
   Issue Description: CDM-37906
   Category/ Module  : Dashboard
   Root cause: user wants to remove the case from dashboard
*/

select * from routing where objectid='I221010320287';

update routing 
set activeflag=0, updatedby='CDM-37906', updatedon=now()
where objectid='I221010320287' and activeflag=1;