-- CIDM-8809 - update the reference value key for CJAMS vaccines.
-- personimmunizationconfig add immunizationkey
ALTER TABLE cjams.personimmunizationconfig ADD immunizationkey varchar(15) NULL;