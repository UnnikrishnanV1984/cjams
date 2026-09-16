update servicecasedisposition set activeflag = 0, updatedby = 'CDM-8884', updatedon = now() where servicecasedispositionid = 'c0ad95b4-b0f6-4e20-967f-440e5f36555b';
update servicecase set statustypekey = 'Closed', dispositioncode = 'Closed', enddate = '2002-02-20T00:00:00', updatedby = 'CDM-8884', updatedon = now() where servicecaseid = '4d15b1a6-2d09-4a1d-ba5e-b2aca90b501c';
