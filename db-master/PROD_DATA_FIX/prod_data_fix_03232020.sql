-- D-26836, CDM-102

delete from servicecasedisposition where servicecasedispositionid = '657f1631-c738-4324-91f7-77fe2824ef4e';

update servicecase set statustypekey = 'Closed', dispositioncode = 'Closed', enddate = '2007-07-24 08:47:12' where 
servicecasenumber = 3076825 
