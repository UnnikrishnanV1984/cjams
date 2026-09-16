/*
  Issue Description:  CDM-39803
   Category/ Module  :  placement
   Root cause: user requested to update living arrangement from Foster care home to Respite Care
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update
    livingarrangement 
set
    livingarrangementtypekey = 'REC',
    updatedby = 'CDM-39803',
    updatedon = now()
where
    placementid ='eacb4b77-2aeb-4b6a-b88f-6ab24d237e38' and livingid ='de860d55-5160-4ae4-a863-b7f0ce831df9'
    and activeflag = 1;