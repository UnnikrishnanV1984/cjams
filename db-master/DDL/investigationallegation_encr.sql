-- encr.investigationallegation_encr definition

-- Drop table

-- DROP TABLE encr.investigationallegation_encr;

CREATE TABLE encr.investigationallegation_encr (
    investigationallegationencrid uuid DEFAULT cjams.gen_random_uuid() NOT NULL,
	investigationallegationid uuid NOT NULL,
	investigationid uuid NOT NULL,
	allegationid uuid NOT NULL,
	"name" bytea NULL,
	reported bool NULL,
	indicators text NULL,
	activeflag int4 DEFAULT 1 NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp DEFAULT now() NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp DEFAULT now() NULL,
	effectivedate timestamp DEFAULT now() NOT NULL,
	expirationdate timestamp NULL,
	financial bool NULL,
	addedindicators text NULL,
	"comments" bytea NULL,
	incidentdate timestamp NULL,
	maltreatmentid uuid NULL,
	injurycomments bytea NULL,
	old_id varchar(50) NULL,
	sextrafficking int4 NULL,
	investigationmaltreatmentactorid uuid NULL,
	isapproximatedate int4 NULL,
	timeofincidence timestamp NULL,
	incidentlocationtypekey bytea NULL,
	enddate timestamp NULL,
	isproviderinvolved int4 NULL,
	investigationallegationstatus varchar(50) NULL,
	outcome varchar(250) NULL,
	relationshiptypekey varchar(50) NULL,
	ischildfatality int4 NULL,
	clientroleid uuid NULL,
	maltreatmenttypekey varchar(5) NULL,
	maltreatmentdate timestamp(6) NULL,
	accidentalinjuryflag int4 NULL,
	maltreatmentkeyid int4 NULL,
	expungementflag int4 NULL,
	sextraffickingflag int4 NULL,
	fk_crid varchar(10) NULL,
	fk_cid varchar(50) NULL,
	fk_rid varchar(50) NULL,
	victim_explanation bytea NULL,
	sibling_explanation bytea NULL,
	guardian_explanation bytea NULL,
	maltreator_explanation bytea NULL,
	med_assessmnts bytea NULL,
	expert_assessmnts bytea NULL,
	collateral_interviews bytea NULL,
	criminal_history_inv bytea NULL,
	home_conditions bytea NULL,
	law_enforcement_inv bytea NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	aps_reason text NULL,
	investigation_action text NULL,
	indicatorcomments text NULL,
	fatalitycomments varchar NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_investigationallegation_encr PRIMARY KEY (investigationallegationencrid),
	CONSTRAINT fk_investigationallegation_encr_investigation FOREIGN KEY (investigationid) REFERENCES cjams.investigation(investigationid)
);
CREATE INDEX indx_investigationallegation_encr_actorid ON encr.investigationallegation_encr USING btree (investigationmaltreatmentactorid);
CREATE INDEX investigationallegation_encr_investigationid_idx ON encr.investigationallegation_encr USING btree (investigationid);
CREATE INDEX investigationallegation_encr_isproviderinvolved_idx ON encr.investigationallegation_encr USING btree (isproviderinvolved, activeflag);
CREATE INDEX investigationallegation_encr_maltreatmentid_idx ON encr.investigationallegation_encr USING btree (maltreatmentid);


-- Column comments
COMMENT ON COLUMN encr.investigationallegation_encr.investigationallegationencrid IS 'Investigation Allegation Details Stored In this encrypted table (Primary Key)';
COMMENT ON COLUMN encr.investigationallegation_encr.investigationallegationid IS 'Investigation Allegation Details Stored In this table (Primary Key)';
COMMENT ON COLUMN encr.investigationallegation_encr.investigationid IS 'Investigation id (Foreign Key)';
COMMENT ON COLUMN encr.investigationallegation_encr.allegationid IS 'Allegation id ( Foreign Key)';
COMMENT ON COLUMN encr.investigationallegation_encr."name" IS 'Allegation Name';
COMMENT ON COLUMN encr.investigationallegation_encr.reported IS 'Reported flag';
COMMENT ON COLUMN encr.investigationallegation_encr.indicators IS 'Indicators for allegation';
COMMENT ON COLUMN encr.investigationallegation_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.investigationallegation_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.investigationallegation_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.investigationallegation_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.investigationallegation_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.investigationallegation_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.investigationallegation_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.investigationallegation_encr.financial IS 'Financial Flag';
COMMENT ON COLUMN encr.investigationallegation_encr.addedindicators IS 'Added Indicators';
COMMENT ON COLUMN encr.investigationallegation_encr."comments" IS 'Investigation allegation Comments';
COMMENT ON COLUMN encr.investigationallegation_encr.incidentdate IS 'Incidentdate';
COMMENT ON COLUMN encr.investigationallegation_encr.maltreatmentid IS 'Maltreatmentid';
COMMENT ON COLUMN encr.investigationallegation_encr.injurycomments IS 'injurycomments';
COMMENT ON COLUMN encr.investigationallegation_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.investigationallegation_encr.sextrafficking IS 'Sextrafficking';
COMMENT ON COLUMN encr.investigationallegation_encr.investigationmaltreatmentactorid IS 'investigationmaltreatmentactor id (Foreign Key)';
COMMENT ON COLUMN encr.investigationallegation_encr.isapproximatedate IS 'Isapproximatedate';
COMMENT ON COLUMN encr.investigationallegation_encr.timeofincidence IS 'Timeofincidence';
COMMENT ON COLUMN encr.investigationallegation_encr.incidentlocationtypekey IS 'Incidentlocationtypekey';
COMMENT ON COLUMN encr.investigationallegation_encr.enddate IS 'Enddate';
COMMENT ON COLUMN encr.investigationallegation_encr.isproviderinvolved IS 'Provider involved flag';
COMMENT ON COLUMN encr.investigationallegation_encr.fatalitycomments IS 'Updtaed comments by appeal worker if any changes were made in the dropdown values';

