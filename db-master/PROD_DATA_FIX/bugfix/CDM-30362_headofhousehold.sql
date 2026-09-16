
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
where personid = 'bb0e69df-7d9e-4c6d-8442-aa1ac4b2838c'
and intakeservicerequestactorid in ('d36483ce-8536-415f-bdab-98dff3ca754b','2c4ce911-9119-4855-8a54-92e0408c91ca');