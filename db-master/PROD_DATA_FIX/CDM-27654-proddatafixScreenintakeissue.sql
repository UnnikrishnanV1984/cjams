/*
   Issue Description: CDM-22188
   Category/ Module  : Prod data fix to the removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update servicerequesttypeconfigdispositioncode
set description = 'Screen Out', dispositioncode = 'ScreenOUT',
updatedon = now(), updatedby = 'CDM-27654-R'
where ServiceRequestTypeConfigIdDispostionId = '94377120-38d7-461a-932f-457c3ef723ca';