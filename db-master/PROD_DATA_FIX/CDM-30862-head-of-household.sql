/*
   Issue Description: CASEHEAD MISSING / Person card update
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update
    intakeservicerequestactor
set
    updatedby = 'CDM-30862',
    updatedon = now(),
    isprimary = 'true'
where
    intakeservicerequestactorid = 'bfd93898-4c2f-4734-85e3-805edbb4738a'
    and actorid = 'cb1eef9a-a30f-414c-8652-4d1c9bb89669';