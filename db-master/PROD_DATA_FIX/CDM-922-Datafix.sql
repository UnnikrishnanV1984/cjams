-- CDM-922

UPDATE IntakeDAStaging
SET status = 'pending',
updatedon = now(),
updatedby = 'CDM-922'
WHERE id in (SELECT id FROM IntakeDAStaging WHERE intakenumber ILIKE 'I202000161313' AND activeflag = 1);