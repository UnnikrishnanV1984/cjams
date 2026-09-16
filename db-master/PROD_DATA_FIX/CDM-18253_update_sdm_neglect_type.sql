
/*
   Issue Description: CDM-18253
   Category/ Module  : SDM Maltreatment type
   Root cause: user requeseted to update the maltreament type
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update Intakeservicerequestsdm 
set isneggn_inadequatesupervision = true, isnegrh_basicneedsunmet = false, updatedby = 'CDM-18253', updatedon = now() 
where intakeservicerequestsdmid = 'ccf3cb79-3637-43a1-937c-91b089f3275f'; 