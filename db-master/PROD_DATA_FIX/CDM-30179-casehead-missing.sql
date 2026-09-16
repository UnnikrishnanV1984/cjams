/*
   Issue Description: CASEHEAD MISSING / Person card update
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update
    intakeservicerequestactor
set
    updatedby = 'CDM-30179',
    updatedon = now(),
    isprimary = 'true'
where
    intakeservicerequestactorid = '35e8caaf-7c36-4f7b-b848-9ed6abe278ee'
    and actorid = '699170ab-c734-43e8-9e09-dcfc0b0e1915';