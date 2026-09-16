/*
   Issue Description: CDM-26466
   Category/ Module  : Program Assignment
   Root cause: user wants to change the updated by
   Pull request# for code fix: 6848
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE personprogramarea
SET updatedon = now(), updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67'
WHERE personprogramid = 'ec843725-21ec-49e9-a832-d35a1e4fd462';