UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-13605',updatedon = now() 
WHERE servicecaseid = '61a73d65-efc9-4a8e-9e3f-774eec1858fe';

update servicecasedisposition 
SET activeflag = 0, updatedby = 'CDM-13605',updatedon = now() 
WHERE servicecasedispositionid = 'e5638841-ad73-4f19-ae4b-2f224294c1eb';

update personprogramarea 
SET enddate = null, updatedby = 'CDM-13605', updatedon = now() 
WHERE personprogramid in ('d765ef70-672d-4471-8a77-0664fa889290', '845d3ced-0c8e-40fc-b7ec-a89ebd69fecb');