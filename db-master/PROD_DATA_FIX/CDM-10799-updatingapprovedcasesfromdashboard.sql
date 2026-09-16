-- CDM-10799

update IntakeDAStaging set status = 'Complete', updatedby = 'CDM-10799', updatedon = now() where intakenumber in  ('I202100132030' , 'I202000557143') and activeflag = 1;
