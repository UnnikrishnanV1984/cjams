DROP TABLE if exists cjams.personrole_history;

CREATE TABLE if not exists cjams.personrole_history (
	personrolehistoryid uuid NOT NULL DEFAULT gen_random_uuid(), 
	personid uuid,
	intakeservicerequestpersontypekey character varying(15),
    comments character varying(255),
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	CONSTRAINT pk_personrolehistory PRIMARY KEY (personrolehistoryid)
);