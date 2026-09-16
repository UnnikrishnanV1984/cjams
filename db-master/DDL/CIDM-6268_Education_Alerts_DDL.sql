-- B-129401 - PI33 - Sprint 05-Enhancement to Education Alert (CIDM-6268)

-- cjams.personeducationalertactions definition

-- Drop table

-- DROP TABLE cjams.personeducationalertactions;

CREATE TABLE cjams.personeducationalertactions (
	personeducationalertactionid uuid NOT NULL DEFAULT gen_random_uuid(),
	personeducationid uuid NULL,
	personid uuid NULL,
	actiontype varchar NULL, -- 'H' for Hold education alerts & 'S' for Stop All Education Alerts
	reasoncode varchar NULL, -- 2 Reference Types Hold/Stop and Values (Save as an array if multiselect is required)
	startdate timestamp NULL,
	enddate timestamp NULL,
	endreason character varying NULL, 
	notes character varying NULL, 
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	CONSTRAINT pk_personeducationalertactions PRIMARY KEY (personeducationalertactionid)
);
CREATE INDEX predualerts_personeducationid_idx ON cjams.personeducationalertactions USING btree (personeducationid);
CREATE INDEX predualerts_personid_idx ON cjams.personeducationalertactions USING btree (personid);


COMMENT ON COLUMN cjams.personeducationalertactions.personeducationalertactionid IS 'Primary Key';
COMMENT ON COLUMN cjams.personeducationalertactions.personeducationid IS 'Foreign key - PK of personeducation table';
COMMENT ON COLUMN cjams.personeducationalertactions.personid IS 'Foreign key - PK of person table';
COMMENT ON COLUMN cjams.personeducationalertactions.actiontype IS 'Education Alerts Hold or Stop';
COMMENT ON COLUMN cjams.personeducationalertactions.reasoncode IS 'Reason(s) for Education Alerts Hold or Stop';
COMMENT ON COLUMN cjams.personeducationalertactions.startdate IS 'Education Alerts Hold or Stop Start Date';
COMMENT ON COLUMN cjams.personeducationalertactions.enddate IS 'Education Alerts Hold or Stop End Date';
COMMENT ON COLUMN cjams.personeducationalertactions.endreason IS 'Education Alerts Hold or Stop End Reason';
COMMENT ON COLUMN cjams.personeducationalertactions.notes IS 'Additional comments on Education Alerts Hold or Stop';
COMMENT ON COLUMN cjams.personeducationalertactions.activeflag IS 'Flag to indicate the record is active or deleted';
COMMENT ON COLUMN cjams.personeducationalertactions.insertedby IS 'User id who created this record';
COMMENT ON COLUMN cjams.personeducationalertactions.insertedon IS 'Timestamp of record creation';
COMMENT ON COLUMN cjams.personeducationalertactions.updatedby IS 'User id who last-updated this record';
COMMENT ON COLUMN cjams.personeducationalertactions.updatedon IS 'Timestamp of record last update';