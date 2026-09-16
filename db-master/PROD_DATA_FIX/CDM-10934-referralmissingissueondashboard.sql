-- CDM-10934
update IntakeDAStaging set status = 'pending',ispreintake = false where intakenumber = 'I202100533647' and activeflag = 1;
