update servicecasedisposition set activeflag = 0, updatedby = 'CDM-14613',updatedon = now()  where servicecasedispositionid = 'd309e41c-3daa-4a9e-98dc-367a51930ee1';

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-14613',updatedon = now() WHERE servicecaseid = '5bbbd0bd-96fc-401d-811c-ed0708def309';