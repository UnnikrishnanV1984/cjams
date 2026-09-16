/*
  Issue Description:  CJAMS-68616
   Category/ Module  :  Application
   Root cause:case is reopened but the status of the case is still showing as closed, hence data fix is done to modify the status correctly 
   Fix provided: Data fix is done to modify the status to Open 
   Is code fox required: N 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/



update servicecase
set statustypekey = 'Open', dispositioncode = 'Open',updatedby='CJAMS-68616',updatedon=now()
where servicecasenumber='202105506194' and activeflag=1;

update servicecasedisposition set activeflag=0,
updatedby='CJAMS-68616',updatedon=now()
where servicecasedispositionid='f7598b0c-2086-4a5d-a8cf-e16e6adb3d88' and activeflag=1;

update servicecase
set statustypekey='Open',dispositioncode = 'Open',enddate=null,updatedby='CJAMS-68616',updatedon=now()
where servicecasenumber='3291294' and activeflag=1 ;
