ALTER TABLE  cjams.adoptioneligibilityinfo DROP COLUMN updatedon;	
ALTER TABLE  cjams.adoptioneligibilityinfo DROP COLUMN activeflag;
ALTER TABLE cjams.adoptioneligibilityinfo ADD COLUMN IF NOT EXISTS raceorethnicitywithoneofthesabove varchar NULL;
ALTER TABLE cjams.adoptioneligibilityinfo ADD COLUMN IF NOT EXISTS updatedon timestamp without time zone;
ALTER TABLE cjams.adoptioneligibilityinfo ADD COLUMN IF NOT EXISTS activeflag integer;	
