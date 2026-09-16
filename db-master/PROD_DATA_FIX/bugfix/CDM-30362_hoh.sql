
/*
   Issue Description: CDM-30362
   Category/ Module  : head of household
   Root cause: User wants to create head of household for the case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequestactor set isheadofhousehold = false , updatedby='CDM-30362', updatedon=now() 
where intakeservicerequestactorid = 'd36483ce-8536-415f-bdab-98dff3ca754b';