ALTER TABLE cjams.investigationfindingtype ADD teamtypekey varchar(50) NULL;
UPDATE cjams.investigationfindingtype
SET teamtypekey = 'CW', updatedon = now(), updatedby = ''
WHERE investigationfindingtypekey in ('ID', 'UD', 'RO') ;

