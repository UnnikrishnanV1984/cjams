	
-- Need them in order so dropping and adding them again

ALTER TABLE  cjams.adoptioneligibilityinfo 
DROP COLUMN updatedon;
	
ALTER TABLE  cjams.adoptioneligibilityinfo 
DROP COLUMN activeflag;
	
ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN caseworkername text;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN submissiondate timestamp without time zone;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN caseworkersignature text;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN resubmissioncaseworkername text;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN resubmissiondate timestamp without time zone;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN resubmissioncaseworkersignature text;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN resubmissioncount integer;		
	 
ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN updatedon timestamp without time zone;

ALTER TABLE cjams.adoptioneligibilityinfo
ADD COLUMN activeflag integer;		


update cjams.adoptioneligibilityinfo
set activeflag = 1;
