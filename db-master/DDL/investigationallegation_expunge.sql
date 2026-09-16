-- expunge.investigationallegation_expunge definition

-- Drop table

-- DROP TABLE expunge.investigationallegation_expunge;

CREATE TABLE expunge.investigationallegation_expunge (
    investigationallegationexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Investigation Allegation Details Stored In this table (Primary Key)
	investigationallegationid uuid NOT NULL, -- Investigation Allegation Details Stored In this table (Primary Key)
	investigationid uuid NOT NULL, -- Investigation id (Foreign Key)
	allegationid uuid NOT NULL, -- Allegation id ( Foreign Key)
	"name" varchar(256) NULL, -- Allegation Name
	reported bool NULL, -- Reported flag
	indicators text NULL, -- Indicators for allegation
	activeflag int4 DEFAULT 1 NULL, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	financial bool NULL, -- Financial Flag
	addedindicators text NULL, -- Added Indicators
	"comments" text NULL, -- Investigation allegation Comments
	incidentdate timestamp NULL, -- Incidentdate
	maltreatmentid uuid NULL, -- Maltreatmentid
	injurycomments text NULL, -- injurycomments
	old_id varchar(50) NULL, -- Used for migration purpose
	sextrafficking int4 NULL, -- Sextrafficking
	investigationmaltreatmentactorid uuid NULL, -- investigationmaltreatmentactor id (Foreign Key)
	isapproximatedate int4 NULL, -- Isapproximatedate
	timeofincidence timestamp NULL, -- Timeofincidence
	incidentlocationtypekey text NULL, -- Incidentlocationtypekey
	enddate timestamp NULL, -- Enddate
	isproviderinvolved int4 NULL, -- Provider involved flag
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
	victim_explanation text NULL,
	sibling_explanation text NULL,
	guardian_explanation text NULL,
	maltreator_explanation text NULL,
	med_assessmnts text NULL,
	expert_assessmnts text NULL,
	collateral_interviews text NULL,
	criminal_history_inv text NULL,
	home_conditions text NULL,
	law_enforcement_inv text NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	aps_reason text NULL,
	investigation_action text NULL,
	indicatorcomments text NULL,
	fatalitycomments varchar NULL, -- Updtaed comments by appeal worker if any changes were made in the dropdown values
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_investigationallegation_expunge PRIMARY KEY (investigationallegationexpungeid),
	CONSTRAINT fk_investigationallegation_investigation_expunge FOREIGN KEY (investigationid) REFERENCES cjams.investigation(investigationid)
);
CREATE INDEX indx_nvestigationallegation_expunge_actorid ON expunge.investigationallegation_expunge USING btree (investigationmaltreatmentactorid);
CREATE INDEX investigationallegation_expunge_investigationid_idx ON expunge.investigationallegation_expunge USING btree (investigationid);
CREATE INDEX investigationallegation_expunge_isproviderinvolved_idx ON expunge.investigationallegation_expunge USING btree (isproviderinvolved, activeflag);
CREATE INDEX investigationallegation_expunge_maltreatmentid_idx ON expunge.investigationallegation_expunge USING btree (maltreatmentid);
CREATE INDEX investigationallegation_expunge_test_idx ON expunge.investigationallegation_expunge USING btree (allegationid);

-- Column comments
COMMENT ON COLUMN expunge.investigationallegation_expunge.investigationallegationexpungeid IS 'Investigation Allegation Details Stored In this table (Primary Key)';
COMMENT ON COLUMN expunge.investigationallegation_expunge.investigationallegationid IS 'Investigation Allegation Details Stored In this table (Primary Key) for investigationallegation table';
COMMENT ON COLUMN expunge.investigationallegation_expunge.investigationid IS 'Investigation id (Foreign Key)';
COMMENT ON COLUMN expunge.investigationallegation_expunge.allegationid IS 'Allegation id ( Foreign Key)';
COMMENT ON COLUMN expunge.investigationallegation_expunge."name" IS 'Allegation Name';
COMMENT ON COLUMN expunge.investigationallegation_expunge.reported IS 'Reported flag';
COMMENT ON COLUMN expunge.investigationallegation_expunge.indicators IS 'Indicators for allegation';
COMMENT ON COLUMN expunge.investigationallegation_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.investigationallegation_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.investigationallegation_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.investigationallegation_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.investigationallegation_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.investigationallegation_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.investigationallegation_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.investigationallegation_expunge.financial IS 'Financial Flag';
COMMENT ON COLUMN expunge.investigationallegation_expunge.addedindicators IS 'Added Indicators';
COMMENT ON COLUMN expunge.investigationallegation_expunge."comments" IS 'Investigation allegation Comments';
COMMENT ON COLUMN expunge.investigationallegation_expunge.incidentdate IS 'Incidentdate';
COMMENT ON COLUMN expunge.investigationallegation_expunge.maltreatmentid IS 'Maltreatmentid';
COMMENT ON COLUMN expunge.investigationallegation_expunge.injurycomments IS 'injurycomments';
COMMENT ON COLUMN expunge.investigationallegation_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.investigationallegation_expunge.sextrafficking IS 'Sextrafficking';
COMMENT ON COLUMN expunge.investigationallegation_expunge.investigationmaltreatmentactorid IS 'investigationmaltreatmentactor id (Foreign Key)';
COMMENT ON COLUMN expunge.investigationallegation_expunge.isapproximatedate IS 'Isapproximatedate';
COMMENT ON COLUMN expunge.investigationallegation_expunge.timeofincidence IS 'Timeofincidence';
COMMENT ON COLUMN expunge.investigationallegation_expunge.incidentlocationtypekey IS 'Incidentlocationtypekey';
COMMENT ON COLUMN expunge.investigationallegation_expunge.enddate IS 'Enddate';
COMMENT ON COLUMN expunge.investigationallegation_expunge.isproviderinvolved IS 'Provider involved flag';
COMMENT ON COLUMN expunge.investigationallegation_expunge.fatalitycomments IS 'Updtaed comments by appeal worker if any changes were made in the dropdown values';
COMMENT ON COLUMN expunge.investigationallegation_expunge.isexpunged IS 'Flag to indicate the expunged record';
