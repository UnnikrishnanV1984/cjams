/*
   Issue Description: CDM-27227
   Category/ Module  : Cases on tree
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

UPDATE
    IntakeDAStaging
SET
    activeflag = 0,
    updatedby = 'CDM-27227',
    updatedon = now()
WHERE
    intakenumber in ('I221010257477', 'I221010229964')
    and activeflag = 1;