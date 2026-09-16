/*
   Issue Description: CDM-39322
   Category/ Module  : Application 
   Root cause: I tried to complete a service plan under Ms. Marshall and her son Kevin Lindsey who is not in care appears to be the only name and need help removing thi
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update personprogramarea 
set   enddate = '2022-01-24 00:00:00',
      updatedby ='CDM-39322',
      updatedon = now() 
where personprogramid in ('65f18d72-9caa-4710-a1bd-3a5265351873','741c0c4e-956d-4010-bf65-b5b9180e65d7','9e005d9d-97fb-4fe9-af1d-12274841200a','49f8b72f-f3dc-4f7d-b9aa-9b931d1727f3','fa16964e-b12d-456c-85a9-b4ec05e5114c','74dcd151-63ab-4a61-815d-727fb5672aa5');

