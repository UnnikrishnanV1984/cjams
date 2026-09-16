--
-- DDL ALTER SCRIPT TO SET DEFAULT VALUE FOR AUDIT COLUMNS FOR INTERFACE TABLE FOR DEFECT D-20956
-- 11/13/2019 - Ramakrishna Veerabagu
--
ALTER TABLE cjams.interfaceserrorlog ALTER COLUMN insertedby SET DEFAULT 'Batch';
ALTER TABLE cjams.interfaceserrorlog ALTER COLUMN updatedby SET DEFAULT 'Batch';
ALTER TABLE cjams.interfaceserrorlog ALTER COLUMN insertedon SET DEFAULT current_timestamp;
ALTER TABLE cjams.interfaceserrorlog ALTER COLUMN updatedon SET DEFAULT current_timestamp;
