UPDATE servicecase 
SET statustypekey = 'Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-14415',
    updatedon = now() 
WHERE servicecaseid = '3903027f-fcb6-4bde-a786-412f57f5f5be';

UPDATE servicecasedisposition 
SET activeflag = 0, 
    updatedby = 'CDM-14415',
    updatedon = now() 
WHERE servicecasedispositionid = 'e6cb3925-b8a1-4bcf-8e61-44960810d645';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-14415', 
    updatedon = now() 
WHERE personprogramid in ('239dea64-9b6a-43f9-99d8-872b09cd7c31', '0695fe47-effb-4d38-80e6-b9161c0bb337', '697a4e68-46e1-434f-b4d9-7019a601c359', 'a3e10517-ff34-42f6-9e78-167bc2eba53d', 'bc5d9215-2de9-45ae-a18d-2025b99643ce');
