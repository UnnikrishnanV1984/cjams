-- Drop table

-- DROP TABLE encr.progressnotedetail_encr;

CREATE TABLE encr.progressnotedetail_encr (
	progressnotedetailenrcid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	progressnotedetailid uuid NOT NULL,
	progressnoteid uuid NOT NULL,
	description bytea NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	"timestamp" bytea NULL,
	old_id varchar(50) NULL,
	isaddendum int4 NULL DEFAULT 0,
	fk_user_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_progressnotedetail_encr PRIMARY KEY (progressnotedetailenrcid)
);
CREATE INDEX indx_progressnotedetail_encr ON encr.progressnotedetail_encr USING btree (insertedby);
CREATE INDEX ix1001_progressnotedetail_encr ON encr.progressnotedetail_encr USING btree (insertedon);
CREATE INDEX progressnotedetail_encr_progressnoteid_idx ON encr.progressnotedetail_encr USING btree (progressnoteid, activeflag);
-- Column comments
COMMENT ON COLUMN encr.progressnotedetail_encr.progressnotedetailenrcid IS 'Progress note detail (Primary key)';
COMMENT ON COLUMN encr.progressnotedetail_encr.progressnotedetailid IS 'progressnotedetail Table Primary Key';
COMMENT ON COLUMN encr.progressnotedetail_encr.progressnoteid IS 'Progress note id (foreign key)';
COMMENT ON COLUMN encr.progressnotedetail_encr.description IS 'Description of the notes';
COMMENT ON COLUMN encr.progressnotedetail_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.progressnotedetail_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.progressnotedetail_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.progressnotedetail_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.progressnotedetail_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.progressnotedetail_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.progressnotedetail_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.progressnotedetail_encr.old_id IS 'Used for migration purpose';