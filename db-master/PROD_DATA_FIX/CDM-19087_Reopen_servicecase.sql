
/*
   Issue Description: CDM-19087
   Category/ Module  : User asked to reopen the service case
   Root cause: user wants to remove
   Pull request# for code fix: 
*/

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-19087', updatedon = now()
where servicecasedispositionid = '8e970a2a-728e-4365-853d-908e8468626b';

update servicecase
set statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-19087', updatedon = now()
where servicecaseid = '997a0010-a1a0-407b-b698-c1798030cd88';

update personprogramarea 
set enddate = null, updatedby = 'CDM-19087', updatedon = now()
where personprogramid = '84778231-eeab-4a5e-a904-0836b20987d9';