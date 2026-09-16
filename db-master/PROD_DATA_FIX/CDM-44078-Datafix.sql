/*
   Issue Description: CDM-44078
   Category/ Module  : Application
   Root Cause: The popup was being shown and hidden so making the screen blank,
    It is case specific as there are multiple sennotifications for same person, with multiple  worker details, and one of the worker is inactive.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update senhistorynotifications set nevershowagain=false, updatedby='CDM-44078',updatedon=now() 
where personid = 'a36cedf4-f027-4cec-a96a-81654cecce27'
and senhistoryid='43440977-422f-4afa-95c6-694e427e5b05' and activeflag = 1;
