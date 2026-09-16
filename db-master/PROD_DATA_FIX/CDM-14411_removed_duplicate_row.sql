-- CDM-14411
-- Removed duplicate record from service disposition
UPDATE servicecasedisposition 
SET activeflag = 0, 
    updatedby = 'CDM-14411',
    updatedon = now() 
WHERE servicecasedispositionid = 'c7c718ef-33e5-48d6-96dc-ce441051a913';