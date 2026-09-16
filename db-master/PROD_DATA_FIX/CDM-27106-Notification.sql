
/*
   Issue Description: CDM-27106
   Category/ Module  : User Notification  
   Root cause: this records updated by cwadmin  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 


update cjams.usernotification set activeflag =0, updatedby ='CDM-27106', updatedon = now()

where usernotificationid in ('60e762dc-c552-4952-9955-864f4edaa30e','671d9935-81e2-44aa-b54d-9cd529239489','58a97944-a69a-4249-8c7c-714dab9cacb1', '0661d65e-a53d-4190-8561-ad217be122f1');