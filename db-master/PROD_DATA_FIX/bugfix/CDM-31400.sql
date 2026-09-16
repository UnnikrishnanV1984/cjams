/*
   Issue Description: CDM-31400
   Category/ Module  : added servicecaseid 
   Root cause:missing servicecase in actor table 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update actor set servicecaseid='4fd76b42-4e38-4ae5-b167-d1508f99b654', updatedby='CDM-31400',updatedon=now() where actorid ='ca3a2eaa-68de-48d5-840c-e898c339a287' and activeflag=1;
update intakeservicerequestactor set servicecaseid='4fd76b42-4e38-4ae5-b167-d1508f99b654', updatedby='CDM-31400',updatedon=now() where intakeservicerequestactorid in ('5c82b838-9467-412e-b5bb-16937ece1d52','c70a2c76-8176-4dea-bf3a-59053c7e5c4f') and activeflag=1;
