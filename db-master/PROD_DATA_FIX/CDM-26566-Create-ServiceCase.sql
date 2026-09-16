/*
   Issue Description: CDM-26566
   Category/ Module  : Create service case
   Root cause: user wants to create new service case 
   Pull request# for code fix: 6981
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
select * from createservicecase('d4dc7981-bd64-4f28-aa1a-5eaca2c2a036', null, 1, '6e0584d0-90b0-4d46-87ce-004e6b740419', 'intake');