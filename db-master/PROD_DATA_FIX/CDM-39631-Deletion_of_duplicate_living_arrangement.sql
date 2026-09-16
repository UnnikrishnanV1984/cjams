/*
   Issue Description: CDM-39631
   Category/ Module  : Living Arrangement(Case management)
   Root cause: User wants to remove
   Pull request# for code fix: 
  explanantion:  User asked to remove duplicate living arrangement.
*/

update placement 
set activeflag =0, updatedby ='CDM-39631', updatedon =now()
where placementid ='40189cd2-b158-44f2-a115-f62f83861bb6' and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-39631', updatedon =now()
where placementid ='40189cd2-b158-44f2-a115-f62f83861bb6' and activeflag =1;

update livingarrangement 
set activeflag =0,updatedby ='CDM-39631', updatedon =now()
where placementid ='40189cd2-b158-44f2-a115-f62f83861bb6' and activeflag =1;

update routing 
set activeflag =0,updatedby ='CDM-39631', updatedon =now()
where objectid ='40189cd2-b158-44f2-a115-f62f83861bb6' and activeflag =1;
