/*
 Issue Description: CDM-35984
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
    parent2comments = 'father is deceased',
    updatedby = 'CDM-35984',
    updatedon = now()
where
    intakeservreqchildremovalid = '94f2bc99-e095-4eff-b5dd-30acfe95db22';