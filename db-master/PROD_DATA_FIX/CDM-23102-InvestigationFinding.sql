/*
   Issue Description: CDM-
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5733
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update investigationfinding 
set investigationfindingtypekey = 'ID', updatedon = now(), updatedby = 'CDM-23102'
where investigationfindingid = '3335ebf4-292d-4e91-9a78-bc993a8c4f5a';