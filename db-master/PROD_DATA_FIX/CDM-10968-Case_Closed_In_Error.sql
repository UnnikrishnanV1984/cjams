
--CDM-10968-Case closed in error
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-10968', updatedon = now()  where servicecasedispositionid= '0c5fd0bf-8c27-4f5e-9590-f9db3ed408eb';

update servicecase set statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10968',updatedon = now() where servicecaseid = 'fca84e04-2c9b-4c9c-a5a9-96a238258ba0';