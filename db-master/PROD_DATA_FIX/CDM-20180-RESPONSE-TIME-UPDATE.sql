/*
   Issue Description: CDM-20180
   Category/ Module  : responsetimer date and time change
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4577
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix 
*/
   

update intakeservicerequest set responsetimer = '2021-12-21 12:06:00', updatedon = now(), updatedby = 'CDM-20180' where intakeserviceid = 'a4323d63-44fc-4e66-b7ba-ac377fb80373';

