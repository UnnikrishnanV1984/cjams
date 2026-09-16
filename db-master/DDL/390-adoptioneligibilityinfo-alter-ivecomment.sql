ALTER TABLE adoptioneligibilityinfo 

DROP COLUMN updatedon;


ALTER TABLE adoptioneligibilityinfo 

DROP COLUMN activeflag;


ALTER TABLE adoptioneligibilityinfo

ADD COLUMN ivecomment text;


ALTER TABLE adoptioneligibilityinfo

ADD COLUMN updatedon timestamp without time zone;


ALTER TABLE adoptioneligibilityinfo

ADD COLUMN activeflag integer;