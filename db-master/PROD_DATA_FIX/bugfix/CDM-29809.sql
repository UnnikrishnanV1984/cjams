/*
   Issue Description: CDM-29809
   Category/ Module  : D.O.B update (person)
   Root cause: D.O.B update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 



update  cjams.person set dob='1975-01-20 00:00:00',updatedby='CDM-29809',updatedon=now() where 
upper(firstname)='RODNEY' and upper(lastname)='JONES'
and personid ='e0616a87-bc4c-4a4b-9eea-bfaa3f6faff2';