/*
   Issue Description: CASEHEAD MISSING / Person card update
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update
    intakeservicerequestactor
set
    updatedby = 'CDM-30504',
    updatedon = now(),
    isprimary = 'true'
where
    intakeservicerequestactorid = 'e4aabc74-a3e2-4e0b-ba43-72b78f660bcc'
    and actorid = '41b3313a-64f2-4a36-8264-9380274454df';