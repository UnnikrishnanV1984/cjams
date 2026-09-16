/*
 Issue Description: CDM-43952
    Category/ Module: Unable to click proceed
    Root cause: User entered parent2 as signed by mistake. Needs to be deleted by a datafix
    Fix: Changed the parentsigned and parent comments status
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
 */


update
    intakeservreqchildremoval
set
    isbothparentssigned = 2,
    parent2comments = 'The child was adopted by one parent.',
    updatedby = 'CDM-43952',
    updatedon = now()
where
    intakeservreqchildremovalid = '349b8fdd-c3ba-4e6c-976b-3d70d1cb8771';
