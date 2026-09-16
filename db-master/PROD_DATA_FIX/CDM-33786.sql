/*
   Issue Description:CDM-33786
   Category/ Module  : Case 
   Root cause: it's a migration case .
  Fix Provided: Did data fix to remove from the record from the assigned tab
*/ 
 
  update cjams.servicecase set statustypekey  ='Closed',
 updatedby  ='CDM-33786', updatedon  = now()
 where servicecaseid  ='9c3627aa-49b7-4a9a-9863-8574c15fa32f';
 