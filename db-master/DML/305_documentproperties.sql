UPDATE cjams.documentproperties
SET  updatedby='0d9d487e-b9c8-4383-a1f5-211435636f94', updatedon=now(), insertedby='0d9d487e-b9c8-4383-a1f5-211435636f94'
WHERE servicecaseid='19d54784-a702-4764-89af-92a3ab2c2f1d' :: uuid and (objecttypekey = 'Servicecase' or objecttypekey in('CasePerson'));
