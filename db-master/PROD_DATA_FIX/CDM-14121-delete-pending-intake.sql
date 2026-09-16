UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-14121',
    updatedon = now()
WHERE intakenumber in ('I211010164921', 'I202100232350');