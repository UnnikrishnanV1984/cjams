/*
   Issue Description: CDM-20176
   Category/ Module  : responsetimer date and time change
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4577
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix 
*/
   

update intakeservicerequest set responsetimer = '2021-12-21 23:30:00', updatedon = now(), updatedby = 'CDM-20176'
where intakeserviceid = '58bb63f7-3599-4cda-bbe2-101cac18f891';
