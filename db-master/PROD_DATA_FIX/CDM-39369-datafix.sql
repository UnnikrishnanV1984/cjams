/*
   Issue Description: CDM-39369
   Category/ Module  : Application 
   Root cause: Cally Carr case has been assigned on my caseload 6 times. Can 5 of the cases please be removed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update caseassignment 
set activeflag =0, updatedby = 'CDM-39369', updatedon = now()
where caseassignmentid in ('0835be81-f719-4ce0-9b8b-3d62c0151ffd','3fd65a2c-576d-45a8-966f-f10d7c4267e5','54eb3854-99fd-4b86-9c38-257ca20dc906','4c4bb570-7484-42a7-9a35-e441334ea8f6','4620a43b-00d5-4e2f-a700-c1070fdcbef4')  and activeflag = 1;