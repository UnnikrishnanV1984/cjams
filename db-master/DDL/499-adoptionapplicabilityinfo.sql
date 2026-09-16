ALTER TABLE cjams.adoptionapplicabilityinfo ADD COLUMN IF NOT EXISTS insertedby varchar(50) NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD COLUMN IF NOT EXISTS insertedon timestamp NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD COLUMN IF NOT EXISTS updatedby varchar(50) NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD COLUMN IF NOT EXISTS updatedon timestamp NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD COLUMN IF NOT EXISTS activeflag int NULL;
