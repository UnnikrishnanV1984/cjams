/*
   Issue Description: CDM-19998
   Category/ Module  : Case assignment Removal 
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4718
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update routing set activeflag = 0, updatedby = 'CDM-19998', 
updatedon = now() where objectid = '1e7af2fd-a5c3-457d-829a-77f26a80aeca';

