/*
    CDM-15944
    Reopening the service case
*/
UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15944',updatedon = now() 
WHERE servicecaseid = '11623a9f-336b-4150-bcf8-007e32f975ca';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-15944',updatedon = now() 
where servicecasedispositionid = 'ab00c6a5-3c25-40bb-956a-995f19a56386';
