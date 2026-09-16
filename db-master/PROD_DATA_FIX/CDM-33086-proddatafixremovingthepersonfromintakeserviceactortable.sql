
/*
   Issue Description: CDM-33086
   Category/ Module  :  Person
   Root cause: user asked to delete the pending intake and remove the case connect
    Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




 update intakeservicerequestactor set isprimary = true, updatedby = 'CDM-33086', updatedon = now()
 where intakeservicerequestactor in ('e0365dab-fb45-402c-84f1-954a06b76ac8') and activeflag =1;
