/*
   Issue Description: CDM-31136
   Category/ Module  : Person  
   Root cause: Casehead/Person Card missing
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update
    intakeservicerequestactor
set
    updatedby = 'CDM-31136',
    updatedon = now(),
    isprimary = 'true'
where
    intakeservicerequestactorid = 'ccdf879b-c3db-49ba-a9b3-0b0678015026'
    and actorid = 'bf572d23-098b-4bb6-850d-2034385fbf0e';
