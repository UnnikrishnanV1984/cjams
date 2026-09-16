
/*
   Issue Description: CDM-20512
   Category/ Module  : Removing Living Arranagement
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update placement  set activeflag = 0, updatedon = now(), updatedby = 'CDM-20512' where placementid = 'fe6f3cd5-8846-46ec-8393-ec9ec539778e';
update livingarrangement  set activeflag = 0, updatedon = now(), updatedby = 'CDM-20512' where placementid = 'fe6f3cd5-8846-46ec-8393-ec9ec539778e';
update placementrevision  set activeflag = 0, updatedon = now(), updatedby = 'CDM-20512' where placementid = 'fe6f3cd5-8846-46ec-8393-ec9ec539778e';

