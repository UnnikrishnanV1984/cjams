/*
   Issue Description: CDM-35114
   Category/ Module  : Prod data fix to remove intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-35114',
    updatedon = now()
WHERE intakenumber in ('I221010328126');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-35114',
    updatedon = now()
WHERE intakenumber in ('I221010328126');
