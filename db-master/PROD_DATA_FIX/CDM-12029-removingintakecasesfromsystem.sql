update IntakeDAStaging IDAS set activeflag = 0, updatedby = 'CDM-12029',updatedon = now() where intakenumber in ('I202100245090','I202100245064','I202100244995') and activeflag  = 1;
update intakeDAStatus ITDS set activeflag = 0, updatedby = 'CDM-12029',updatedon = now() where intakenumber in ('I202100245090','I202100245064','I202100244995') and activeflag  = 1;
