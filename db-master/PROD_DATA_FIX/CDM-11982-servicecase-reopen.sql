update servicecase 
set enddate = null, statustypekey = 'pending', dispositioncode = 'open', updatedon = now(), updatedby = 'CDM-11982'
where servicecaseid = 'd14ea674-cc8b-4e35-ad2f-a7bb666bd80f';

update servicecasedisposition
set activeflag = 0, updatedon = now(), updatedby = 'CDM-11982'
where servicecasedispositionid = '19974ab2-1f70-41fc-b51c-dfa18ea4271d';


update caseassignment set enddate = null, updatedby = 'CDM-11982',updatedon = now() where caseassignmentid = 'c7fd84ae-6e63-4076-b0f0-0867375783f6';
