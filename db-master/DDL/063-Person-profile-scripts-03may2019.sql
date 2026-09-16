ALTER TABLE clientunder5yearsinfo ADD COLUMN IF NOT EXISTS prenatalproblemspecify varchar(250) NULL;
ALTER TABLE clientunder5yearsinfo ADD COLUMN IF NOT EXISTS parentcare varchar(20) NULL;
ALTER TABLE clientunder5yearsinfo ADD COLUMN IF NOT EXISTS parity varchar(100) NULL;
ALTER TABLE clientunder5yearsinfo ADD COLUMN IF NOT EXISTS speciality varchar(50) null;
ALTER TABLE clientunder5yearsinfo ADD COLUMN IF NOT EXISTS hospitalcomments varchar(1000) null; 
 
ALTER TABLE personbehavioralhealth ADD COLUMN IF NOT EXISTS typeofservice  json NULL;
ALTER TABLE personbehavioralhealth ADD COLUMN IF NOT EXISTS phobiakey json NULL;
ALTER TABLE personbehavioralhealth ADD COLUMN IF NOT EXISTS phobiacomments varchar(1000) NULL;

ALTER TABLE personhospitalization ADD COLUMN IF NOT EXISTS hasdischargeplan boolean null;
ALTER TABLE personhospitalization ADD COLUMN IF NOT EXISTS dischargeplan varchar(50) null;
ALTER TABLE personhospitalization ADD COLUMN IF NOT EXISTS county varchar(50) null;
ALTER TABLE personhospitalization ALTER COLUMN hasdischargeplan TYPE int USING hasdischargeplan::int;
ALTER TABLE personimmunizationconfig ADD COLUMN IF NOT EXISTS displayorder int null;

ALTER TABLE personsexualinfo ALTER COLUMN personsexualinfoid SET DEFAULT gen_random_uuid();

 