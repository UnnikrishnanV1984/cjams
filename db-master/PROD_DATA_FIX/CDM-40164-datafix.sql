/*
  Issue Description:  CDM-40164
   Category/ Module  :  placement
   Root cause: user requested to Remove the Living arrangement.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40164' 
where placementid ='790a7ed2-61bd-41f4-86ff-4fb659be3012' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40164'
where placementid ='790a7ed2-61bd-41f4-86ff-4fb659be3012' and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40164' 
where placementid ='790a7ed2-61bd-41f4-86ff-4fb659be3012' and activeflag = 1;

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40164'
where objectid  ='790a7ed2-61bd-41f4-86ff-4fb659be3012' and activeflag = 1;