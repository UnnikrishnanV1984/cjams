
/*
   Issue Description: CDM-30842
   Root cause: user wants to Close the case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update
    IntakeServiceRequest
set
    intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
    updatedon = now(),
    updatedby = 'CDM-30842'
where
    ServiceRequestNumber = '221020195737'
    and intakeserviceid = '10e228e1-1af7-488c-96c0-ce6333187875';