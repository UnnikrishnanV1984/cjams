/*
   Issue Description: CDM-39797
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A          

*/

update placement 
set activeflag =0, updatedby ='CDM-39797', updatedon =now()
where placementid ='72b45f8c-7d46-4ae9-9b6e-9084689a084c' and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-39797', updatedon =now()
where placementid ='72b45f8c-7d46-4ae9-9b6e-9084689a084c' and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-39797', updatedon =now()
where placementid ='72b45f8c-7d46-4ae9-9b6e-9084689a084c' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where objectid ='72b45f8c-7d46-4ae9-9b6e-9084689a084c' and activeflag =1;


