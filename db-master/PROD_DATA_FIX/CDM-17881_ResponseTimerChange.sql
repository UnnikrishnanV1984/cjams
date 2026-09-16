/*
   Issue Description: CDM-17881
   Category/ Module  : responsetimer date and time change
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4577
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix 
*/
   

update intakeservicerequest set responsetimer = '2021-10-18 02:55:00', updatedon = now(), updatedby = 'CDM-17881' where intakeserviceid = '9c239e08-6880-414a-a2e5-636cb88f42f3';

