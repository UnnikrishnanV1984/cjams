/*
   Issue Description: CASEHEAD MISSING / Person card update
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/

update
    intakeservicerequestactor
set
    updatedby = 'CDM-30545',
    updatedon = now(),
    isprimary = 'true'
where
    intakeservicerequestactorid = '85534ca9-1b1a-41a3-8b6f-06a11b73f88e'
    and actorid = 'bd3a1676-e836-4323-b7cb-9cf6bff578a5';