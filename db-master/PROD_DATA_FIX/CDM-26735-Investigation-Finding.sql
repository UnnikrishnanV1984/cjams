/*
   Issue Description: CDM-26735
   Category/ Module  : investigation findings
   Root cause: user wants to change finding to Unsubstantiated
   Pull request# for code fix: 7001
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update investigationfinding 
set investigationfindingtypekey = 'UD',
    updatedby = 'CDM-26735',
    updatedon = now()
where investigationfindingid = '39be8f7d-8bc7-418d-b175-1eb0881ad348';