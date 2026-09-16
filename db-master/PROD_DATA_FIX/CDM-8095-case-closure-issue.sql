UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-12-15 11:32:13.363037', updatedby = 'CDM-8095',updatedon = now() WHERE servicecaseid = 'b297ccb3-2229-4f41-ae5d-70f3cf9880dd';

update servicecasedisposition set effectivedate = '2020-12-15 11:32:13.363037', statusdate = '2020-12-15 11:32:13.363037', insertedby = '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', updatedby = 'CDM-8095',updatedon = now() where servicecasedispositionid = '11100296-5376-4ea8-a735-0f1eeecec3a2'; 
