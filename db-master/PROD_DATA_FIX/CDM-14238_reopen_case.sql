UPDATE servicecase 
SET statustypekey = 'Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-14238',
    updatedon = now() 
WHERE servicecaseid = '75632216-08f1-4088-899f-f4b5b572635d';

UPDATE servicecasedisposition 
SET activeflag = 0, 
    updatedby = 'CDM-14238',
    updatedon = now() 
WHERE servicecasedispositionid = '523407fd-260a-42ba-945b-90b5020e1f4c';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-14238', 
    updatedon = now() 
WHERE personprogramid in ('2b40c2c0-5de0-499c-8237-0c923a7c27f2', 'c6070042-d5a8-4a89-b815-0f16d8b66eda', '6d48ef08-fa06-4991-9470-a209b4944f45');

UPDATE caseassignment 
SET enddate = null, 
    updatedby = 'CDM-14238', 
    updatedon = now() 
WHERE caseassignmentid = 'd4bed221-561d-4eb3-987a-4df868ac31d6';
