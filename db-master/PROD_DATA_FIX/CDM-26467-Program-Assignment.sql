/*
   Issue Description: CDM-26467
   Category/ Module  : Program Assignment
   Root cause: user wants to change the program assign updated by
   Pull request# for code fix: 6855
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE personprogramarea
SET updatedon = now(), updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67'
WHERE personprogramid = '6fac703b-2643-41dd-8be1-46b1c323068f';