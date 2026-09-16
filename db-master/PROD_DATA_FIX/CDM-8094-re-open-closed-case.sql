update servicecase set dispositioncode = 'Open', enddate = null, updatedby = 'CDM-8094',updatedon = now() where servicecaseid = 'fd9c8fa8-fe42-4d29-9959-3367576d1819';
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-8094',updatedon = now() where servicecasedispositionid = '13e36884-7385-433d-9223-62cfd1726b50';
