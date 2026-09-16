UPDATE servicecase SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10547',updatedon = now() WHERE servicecaseid = '8b974404-bc0f-4390-aba3-a7600ef64f3b';

UPDATE servicecasedisposition SET intakeserreqstatustypekey = 'Open', dispositioncode = 'Closed', updatedby = 'CDM-10547',updatedon = now() WHERE servicecasedispositionid = '6a712ed1-b88e-49e3-a6b1-4d8a9c8f5b86';
