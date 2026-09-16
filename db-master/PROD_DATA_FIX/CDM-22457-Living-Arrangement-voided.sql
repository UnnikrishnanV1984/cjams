/*
   Issue Description: CDM-22457
   Category/ Module  : Living arrangement voided
   Root cause: Two living arrangement
   Pull request# for code fix: 
   Explanantion: Living arrangement voided
*/

update livingarrangement
set activeflag = 0, updatedby = 'CDM-22457', updatedon = now()
where placementid = '9a771094-228d-41dd-9e38-fb35464b8eb0';

update placement
set activeflag = 0, updatedby = 'CDM-22457', updatedon = now()
where placementid = '9a771094-228d-41dd-9e38-fb35464b8eb0';
 
update placementrevision
set activeflag = 0, updatedby = 'CDM-22457', updatedon = now()
where placementid = '9a771094-228d-41dd-9e38-fb35464b8eb0';
 
update routing
set activeflag = 0, updatedby = 'CDM-22457', updatedon = now()
where objectid = '9a771094-228d-41dd-9e38-fb35464b8eb0';
