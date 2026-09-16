UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-13448',updatedon = now() WHERE servicecaseid = '0a815eeb-65c5-4836-94ae-afa914ee55e1';
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-13448',updatedon = now() where servicecasedispositionid = 'a77ff1e3-2c81-4f4a-a410-dcaeb0b7a45d';
