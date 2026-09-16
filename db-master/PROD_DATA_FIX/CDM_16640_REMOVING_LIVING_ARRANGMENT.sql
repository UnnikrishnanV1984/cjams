/*
   Issue Description: CDM-16640
   Category/ Module  :  Removing living arrangment. 
   Root cause: user wants to remove 
   Pull request# for code fix: 
   
*/

update placement
set updatedby = 'CDM-16640', updatedon = now(), activeflag = 0
where placementid = 'ef4071b6-afb2-4d75-b0df-afcb4e565ccb';

update routing 
set updatedby = 'CDM-16640', updatedon = now(), activeflag = 0
where objectid = 'ef4071b6-afb2-4d75-b0df-afcb4e565ccb';

update livingarrangement 
set updatedby = 'CDM-16640', updatedon = now(), activeflag = 0
where placementid = 'ef4071b6-afb2-4d75-b0df-afcb4e565ccb';