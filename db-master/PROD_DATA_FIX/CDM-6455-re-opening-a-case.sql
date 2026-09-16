--- servicecasedisposition table already changed by tanmay ------

update servicecase 
set enddate = null, statustypekey = 'pending', dispositioncode = 'open', updatedon = now(), updatedby = 'CDM-6455'
where servicecaseid = '8b8d1242-8965-4a63-9607-31dee57fbf1e';