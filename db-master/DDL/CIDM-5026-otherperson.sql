/*
    Description: CIDM-5026 (B-130715) TPR User Story
    Category/ Module  : adding otherperson to store unknown parent details
*/

drop TABLE cjams.otherperson ;
create TABLE cjams.otherperson (
	personid uuid NOT NULL DEFAULT gen_random_uuid(),
	activeflag int4 NOT NULL DEFAULT 1,
	objectid uuid NULL,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	middlename varchar(32) null,
	objecttype varchar(50) null,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now()
	);

COMMENT ON COLUMN cjams.otherperson.objecttype IS 'object type linked with person. Ex: for Permanency plan TPR type is PERMANENCYTPR, object id is tprdetailsid';
COMMENT ON COLUMN cjams.otherperson.objectid IS 'object id of object type table';
COMMENT ON COLUMN cjams.otherperson.personid IS 'unique person identifier';
COMMENT ON COLUMN cjams.otherperson.activeflag IS 'to decide whether active record or not';
COMMENT ON COLUMN cjams.otherperson.firstname IS 'first name of person';
COMMENT ON COLUMN cjams.otherperson.lastname IS 'last name of person';
COMMENT ON COLUMN cjams.otherperson.middletype IS 'middle name of person';