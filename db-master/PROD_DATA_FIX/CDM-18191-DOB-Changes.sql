/*
   Issue Description: CDM-18191
   Category/ Module  : Persons Tab
   Root cause: user wants to change the DOB which was incorrect 
   Pull request# for code fix: 7503
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
--DOB = 2021-05-25 00:00:00.000
update person set dob = '06/04/1989', updatedby = 'CDM-18191' , updatedon = now() where personid = 'c442ecb8-aa8d-4555-a855-57de19e020ce';
--DOB = 2021-05-26 00:00:00.000
update person set dob = '08/09/1990',  updatedby = 'CDM-18191' , updatedon = now()  where personid = 'b4a4a93e-bf90-43ce-b86d-3526c0cf04c5';