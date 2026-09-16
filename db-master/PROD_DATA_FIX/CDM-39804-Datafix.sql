/*
  Issue Description:  CDM-39804
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
    updatedby = 'CDM-39804',
    updatedon = now()
where
    placementid ='fa1cdab1-b49c-45da-acd1-39c3371f61a0' and livingid ='e138bd9f-6f59-47f2-aaa6-efa6db54326f'
    and activeflag = 1;