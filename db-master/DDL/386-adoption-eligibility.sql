ALTER TABLE adoptioneligibilityinfo 
DROP COLUMN updatedon;

ALTER TABLE adoptioneligibilityinfo 
DROP COLUMN activeflag;

ALTER TABLE adoptioneligibilityinfo
ADD COLUMN ivestatus character varying (50);

ALTER TABLE adoptioneligibilityinfo
ADD COLUMN updatedon timestamp without time zone;

ALTER TABLE adoptioneligibilityinfo
ADD COLUMN activeflag integer;




