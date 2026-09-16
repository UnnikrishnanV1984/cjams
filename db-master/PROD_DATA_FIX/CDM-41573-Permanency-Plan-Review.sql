/*
 Issue Description:  CDM-41573
    Category/ Module  :  placement
    Root cause: Approved record is showing up under pending dashboard
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
 Backup before update/ delete: 
 */
UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-41573',
    updatedon = now()
WHERE
    routingid = 'e07d9a57-cafd-41d8-8442-ef1074b72cf3';