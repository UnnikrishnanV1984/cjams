/*
  Issue Description:  CDM-40163
   Category/ Module  :  placement
   Root cause: user requested to Remove the Living arrangement.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40163' 
where placementid ='64d6f7c2-4aa1-44d0-aa8b-56d2dc76680b' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40163'
where placementid ='64d6f7c2-4aa1-44d0-aa8b-56d2dc76680b' and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40163' 
where placementid ='64d6f7c2-4aa1-44d0-aa8b-56d2dc76680b' and activeflag = 1;

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40163'
where objectid  ='64d6f7c2-4aa1-44d0-aa8b-56d2dc76680b' and activeflag = 1;