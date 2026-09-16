DROP TABLE if exists cjams.investigationallegation_history;

CREATE TABLE if not exists cjams.investigationallegation_history (
	investigationallegationhistoryid uuid NOT NULL DEFAULT gen_random_uuid(), 
	investigationallegationid uuid,
	allegationid uuid,
	allegationid_old uuid,
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	CONSTRAINT pk_investigationallegationhistory PRIMARY KEY (investigationallegationhistoryid)
);