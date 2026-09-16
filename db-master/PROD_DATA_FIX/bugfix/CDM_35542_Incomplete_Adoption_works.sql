/*
 -- Issue Description: 
 CDM-35542: Incomplete adoption works
 Category/ Module: Ive Adoption case
 -- Root cause: Removal id is not getting populated
 -- Pull request# N/A
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: TBD 
 */
update
    adoptionplanning
set
    intakeservicerequestactorid = 'f8f1eeaf-019d-48ec-9824-394c16bcd4ca',
    updatedby = 'CDM-35542',
    updatedon = now()
where
    adoptionplanningid = '55bccda7-c853-4929-a613-089b4c7b4503';