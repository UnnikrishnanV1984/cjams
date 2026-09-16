UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-9465',updatedon = now() WHERE servicecaseid = 'f2ce8bae-4990-42bb-bc54-7839dada5c1a';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-9465',updatedon = now() where servicecasedispositionid = '71938568-6988-4401-bdc3-b886a7a64c3a';

update personprogramarea set enddate = null, endreasonkey = null, updatedby = 'CDM-9465',updatedon = now() where personprogramid in ('2ab89dcc-8c2c-4fa4-bd0a-6b8da62f6cc2', 'db80fff5-cfd3-4ef9-aa76-ff0a6881cd5f');

update caseassignment set enddate = null, updatedby = 'CDM-9465',updatedon = now() where caseassignmentid = '23fec50a-410a-49af-9ec6-cb712cb7f719';
