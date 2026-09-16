--Application change already done and tested to be compatible 
-- with this fix to match migrated objecttypekey
UPDATE personprogramarea
SET objecttypekey = 'servicerequest'
WHERE objecttypekey = 'ServiceRequest';