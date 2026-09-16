/*
   Issue Description: CDM-31558
   Category/ Module  : 
   Root cause:case is not listed on the assign case, completed tab.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update intakeservicerequest set isrouted=true,updatedby='CDM-31558',updatedon=now() where servicerequestnumber = '231020500229';