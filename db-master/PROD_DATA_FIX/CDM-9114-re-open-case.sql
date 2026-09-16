UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-9114',updatedon = now() WHERE servicecaseid = '758e4245-6562-4f17-8e9f-dd8d2e67e86a';

UPDATE servicecasedisposition set activeflag = 0,updatedby = 'CDM-9114',updatedon = now() where servicecasedispositionid = '2e3f3fab-bf2c-4570-b455-905e66efbe91';

update personprogramarea set enddate = null,updatedby = 'CDM-9114',updatedon = now() where personprogramid = '7cfad839-9f93-471b-abf1-b5440f30ae0b';