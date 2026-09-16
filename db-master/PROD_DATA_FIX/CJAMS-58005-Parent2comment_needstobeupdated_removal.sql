/*
 Issue Description: CJAMS-58005
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
    parent2comments = 'Single parent adoption',
    updatedby = 'CJAMS-58005',
    updatedon = now()
where intakeservreqchildremovalid = '0c137854-6ae1-434e-a3af-7b20c0086c19';