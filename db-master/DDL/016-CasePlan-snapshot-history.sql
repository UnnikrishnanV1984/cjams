CREATE TABLE cjams.snapshothist (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NOT NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NOT NULL DEFAULT now(), -- Record updated date and time
	activeflag int4 NOT NULL DEFAULT 1,
	snapshotdata jsonb NULL,
	CONSTRAINT pk_snapshothist PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE cjams.snapshothist OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.snapshothist TO welfareadmin;