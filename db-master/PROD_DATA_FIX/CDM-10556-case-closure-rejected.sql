UPDATE servicecase SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10556',updatedon = now() WHERE servicecaseid = '579dd88e-e9a4-4959-bdf3-264d6894fc99';

UPDATE servicecasedisposition SET intakeserreqstatustypekey = 'Open', dispositioncode = 'Closed', updatedby = 'CDM-10556',updatedon = now() WHERE servicecasedispositionid = '8f1f8dd1-4dc0-43f8-9e0a-45a34ece2c83';
