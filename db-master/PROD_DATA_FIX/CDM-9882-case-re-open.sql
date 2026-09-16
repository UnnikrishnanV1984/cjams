update servicecasedisposition set activeflag = 0, updatedby = 'CDM-9882', updatedon = now() where servicecasedispositionid = '51ae117a-64fb-46dd-85c3-050effcd46c4';

UPDATE servicecase SET statustypekey =null, dispositioncode = 'Open', enddate = now(), updatedby = 'CDM-9882',updatedon = now() WHERE servicecaseid = '66a78146-be9f-4c71-8ff0-4e05e578f688';