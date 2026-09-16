/*
   Issue Description: CDM-42764
   Category/ Module  : Prod data fix to remove closure date and endreasonkey
   Root cause: User data entry error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE personprogramarea
SET 
    enddate = NULL,
    endreasonkey = NULL,
    updatedby = 'CDM-42764',
    updatedon = NOW()
WHERE 
    personid = '98b383bb-0b96-4b4f-8fb4-36d96d27bffb'
    AND activeflag = 1;