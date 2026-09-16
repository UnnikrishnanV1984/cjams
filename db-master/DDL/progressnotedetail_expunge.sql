-- expunge.progressnotedetail_expunge definition

-- Drop table

-- DROP TABLE expunge.progressnotedetail_expunge;

CREATE TABLE expunge.progressnotedetail_expunge (
    progressnotedetailexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Progress note detail (Primary key)
	progressnotedetailid uuid NOT NULL, -- Progress note detail (Primary key)
	progressnoteid uuid NOT NULL, -- Progress note id (foreign key)
	description text NOT NULL, -- Description of the notes
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	"timestamp" bytea NULL,
	old_id varchar(50) NULL, -- Used for migration purpose
	isaddendum int4 DEFAULT 0 NULL,
	fk_user_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_progressnotedetailexpunge PRIMARY KEY (progressnotedetailexpungeid)
);
CREATE INDEX indx_progressnotedetail_expunge ON expunge.progressnotedetail_expunge USING btree (insertedby);
CREATE INDEX ix1001_progressnotedetail_expunge ON expunge.progressnotedetail_expunge USING btree (insertedon);
CREATE INDEX progressnotedetailexpunge_progressnoteid_idx ON expunge.progressnotedetail_expunge USING btree (progressnoteid, activeflag);

-- Column comments

COMMENT ON COLUMN expunge.progressnotedetail_expunge.progressnotedetailexpungeid IS 'Progress note detail (Primary key)';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.progressnotedetailid IS 'Progress note detail (Primary key) for progressnotedetail table';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.progressnoteid IS 'Progress note id (foreign key)';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.description IS 'Description of the notes';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.progressnotedetail_expunge.isexpunged IS 'Flag to indicate the expunged record';