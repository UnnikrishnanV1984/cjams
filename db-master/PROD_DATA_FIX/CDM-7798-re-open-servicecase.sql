update servicecase 
set enddate = null, statustypekey = 'pending', dispositioncode = 'open', updatedon = now(), updatedby = 'CDM-7798'
where servicecaseid = 'd7bc1021-3e7f-41bf-aa1e-1a080b344b7e';

update servicecasedisposition
set activeflag = 0, updatedon = now(), updatedby = 'CDM-7798'
where servicecasedispositionid = '25ddf298-99a0-48c4-933a-6c459a42be9b';