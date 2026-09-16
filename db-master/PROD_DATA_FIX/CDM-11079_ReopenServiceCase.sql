-- CDM-11079 - Reopen service case

update servicecase set statustypekey = 'ASSGN', dispositioncode = 'Open', updatedby = 'CDM-11079', updatedon = now() where servicecasenumber =3151652;
update servicecasedisposition set activeflag =0, updatedby = 'CDM-11079', updatedon = now() where servicecasedispositionid ='85eb450a-25f9-4ff3-ade7-38fb03e71147';
