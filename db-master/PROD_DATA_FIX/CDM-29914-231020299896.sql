/*
   Issue Description: CDM-29914
   Root cause: user wants to change the investigation finding type from ruledout to Indicated
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update investigationfinding 
set investigationfindingtypekey = 'ID', updatedon = now(), updatedby = 'CDM-29914'
where investigationfindingid = 'a3215d24-1fdc-4b9d-9d4e-6dbf12b2f7c3';