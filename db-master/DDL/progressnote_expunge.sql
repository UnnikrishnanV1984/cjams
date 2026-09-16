-- expunge.progressnote_expunge definition

-- Drop table

-- DROP TABLE expunge.progressnote_expunge;

CREATE TABLE expunge.progressnote_expunge (
	progressnoteexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Progress note details (Primary key)
    progressnoteid uuid NOT NULL, -- Progress note details (Primary key)
	progressnotetypeid uuid NOT NULL, -- Progress note typeid (foreign key)
	title text NULL, -- Progress note title
	description text NULL, -- Description of the notes
	entitytype varchar(50) NOT NULL, -- Entity types
	entitytypeid varchar(50) NOT NULL, -- Entity type id (foreign key)
	pagetitle varchar(250) NULL, -- Page title
	pageurl text NULL, -- Page url
	islatest int4 NULL, -- Is latest checked
	versionof uuid NULL, -- Notes version
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	archivedby varchar(50) NULL,
	archivedon timestamp NULL,
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	"timestamp" bytea NULL,
	savemode bool DEFAULT true NOT NULL, -- Save mode
	progressnotesubtypeid uuid NULL, -- Progress note sub type (foreign key)
	contactdate timestamp NULL, -- Contact date
	contactname varchar(256) NULL, -- Contact name
	progressnotetypekey varchar(20) NULL, -- Progress note types
	contactroletypekey varchar(20) NULL, -- Contact role types
	contactphone varchar(32) NULL, -- Conact phone number
	contactemail varchar(256) NULL, -- Contact email
	attemptindicator bool NULL, -- Attempt indicator
	activeflag int4 DEFAULT 1 NULL, -- Status of the record
	documentpropertiesid uuid NULL, -- Document properties id (foreign key) 
	starttime timestamp NULL, -- Notes start time
	endtime timestamp NULL, -- Notes end time
	instantresults int4 NULL, -- CJS Notes instantresults Positive, Negative
	contactstatus bool NULL, -- CJS Notes contactstatus Yes ,No option
	drugscreen bool NULL, -- CJS Notes drugscreen Yes ,No option
	progressnotepurposetypekey varchar(50) NULL, -- Progressnote purpose type
	old_id varchar(50) NULL, -- Used for migration purpose
	traveltime varchar(50) NULL, -- Traveltime
	totaltime varchar(50) NULL, -- Total time
	progressnotereasontypekey varchar(500) NULL, -- Progress note reason types
	locationname varchar(50) NULL, -- Location name
	witsinboundid varchar(50) NULL, -- Wits in bound id
	roletypekey varchar(15) NULL, -- Role types 
	islocked bool DEFAULT false NULL, -- Is locked
	stafftypekey varchar(50) NULL, -- DJS Staff Type Dropdown list
	notesid varchar(50) NULL, -- DJS Notes Tab History maintain in notesid
	witsstatus varchar(1) NULL,
	witsupdatedate timestamp(6) NULL,
	witsupdatebyidno float8 NULL,
	contactcategoryidno float8 NULL,
	iconimgtext varchar(50) NULL,
	parametercodeidno float8 NULL,
	detaillookup float8 NULL,
	fk_id varchar(12) NULL,
	initiationindicator bool NULL,
	intakeserviceid uuid NULL,
	servicecaseid uuid NULL,
	isintake varchar(1) NULL,
	otherpersonname text NULL,
	uploadedfile jsonb NULL,
	adjustmentfostercaretext varchar(10000) NULL,
	screeningfortheservicetext varchar NULL,
	ischildgotoshool bool NULL,
	qualityofcaretochildtext varchar(10000) NULL,
	fk_user_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	fromjurisdictionid uuid NULL,
	tojurisdictionid uuid NULL,
	transferdate timestamp NULL,
	transfertime timestamp NULL,
	travelstarttime timestamp NULL,
	travelendtime timestamp NULL,
	servicesprovided varchar(250) NULL,
	otherservices varchar(10000) NULL,
	anyriskpresented bool NULL,
	otherrisk varchar(10000) NULL,
	witsid bigserial NOT NULL,
	focusperson json NULL, -- focus person json column
	factor1_risk_scale varchar NULL, -- Factor 1 Risk scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment
	factor2_dependent_independent_scale varchar NULL, -- Factor 2 dependent independent for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment
	factor3_outcome_scale varchar NULL, -- Factor 3 outcome scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_progressnoteexpunge PRIMARY KEY (progressnoteexpungeid),
	CONSTRAINT fk_progressnoteexpunge_contactroletype FOREIGN KEY (contactroletypekey) REFERENCES cjams.contactroletype(contactroletypekey),
	CONSTRAINT fk_progressnoteexpunge_progressnotepurposetypekey FOREIGN KEY (progressnotepurposetypekey) REFERENCES cjams.progressnotepurposetype(progressnotepurposetypekey)
);
CREATE INDEX indx_progressnote_expunge_documentpropertiesid ON expunge.progressnote_expunge USING btree (documentpropertiesid);
CREATE INDEX ix1001_progressnoteexpunge ON expunge.progressnote_expunge USING btree (insertedby);
CREATE INDEX ix1003_progressnoteexpunge ON expunge.progressnote_expunge USING btree (insertedon);
CREATE INDEX ix1004_progressnoteexpunge ON expunge.progressnote_expunge USING btree (contactdate);
CREATE INDEX progressnoteexpunge_activeflag_idx ON expunge.progressnote_expunge USING btree (activeflag);
CREATE INDEX progressnoteexpunge_contactroletypekey_idx ON expunge.progressnote_expunge USING btree (contactroletypekey);
CREATE INDEX progressnotexpunge_entitytype_idx ON expunge.progressnote_expunge USING btree (entitytype);
CREATE INDEX progressnoteexpunge_entitytypeid_idx ON expunge.progressnote_expunge USING btree (entitytypeid);
CREATE INDEX progressnoteexpunge_intakeserviceid_idx ON expunge.progressnote_expunge USING btree (intakeserviceid);
CREATE INDEX progressnoteexpunge_progressnotereasontypekey_idx ON expunge.progressnote_expunge USING btree (progressnotereasontypekey);
CREATE INDEX progressnoteexpunge_progressnotesubtypeid_idx ON expunge.progressnote_expunge USING btree (progressnotesubtypeid);
CREATE INDEX progressnoteexpunge_progressnotetypeid_idx ON expunge.progressnote_expunge USING btree (progressnotetypeid);
CREATE INDEX progressnoteexpunge_servicecaseid_idx ON expunge.progressnote_expunge USING btree (servicecaseid);
CREATE INDEX progressnoteexpunge_witsid_idx ON expunge.progressnote_expunge USING btree (witsid);
CREATE INDEX xie1_progressnoteexpunge ON expunge.progressnote_expunge USING btree (date(insertedon));
CREATE INDEX xie2_progressnoteexpunge ON expunge.progressnote_expunge USING btree (date(contactdate));

-- Column comments
COMMENT ON COLUMN expunge.progressnote_expunge.progressnoteexpungeid IS 'Progress note details (Primary key)';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnoteid IS 'Progress note details (Primary key) for progressnote table';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnotetypeid IS 'Progress note typeid (foreign key)';
COMMENT ON COLUMN expunge.progressnote_expunge.title IS 'Progress note title';
COMMENT ON COLUMN expunge.progressnote_expunge.description IS 'Description of the notes';
COMMENT ON COLUMN expunge.progressnote_expunge.entitytype IS 'Entity types';
COMMENT ON COLUMN expunge.progressnote_expunge.entitytypeid IS 'Entity type id (foreign key)';
COMMENT ON COLUMN expunge.progressnote_expunge.pagetitle IS 'Page title';
COMMENT ON COLUMN expunge.progressnote_expunge.pageurl IS 'Page url';
COMMENT ON COLUMN expunge.progressnote_expunge.islatest IS 'Is latest checked';
COMMENT ON COLUMN expunge.progressnote_expunge.versionof IS 'Notes version';
COMMENT ON COLUMN expunge.progressnote_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.progressnote_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.progressnote_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.progressnote_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.progressnote_expunge.savemode IS 'Save mode';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnotesubtypeid IS 'Progress note sub type (foreign key)';
COMMENT ON COLUMN expunge.progressnote_expunge.contactdate IS 'Contact date';
COMMENT ON COLUMN expunge.progressnote_expunge.contactname IS 'Contact name';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnotetypekey IS 'Progress note types';
COMMENT ON COLUMN expunge.progressnote_expunge.contactroletypekey IS 'Contact role types';
COMMENT ON COLUMN expunge.progressnote_expunge.contactphone IS 'Conact phone number';
COMMENT ON COLUMN expunge.progressnote_expunge.contactemail IS 'Contact email';
COMMENT ON COLUMN expunge.progressnote_expunge.attemptindicator IS 'Attempt indicator';
COMMENT ON COLUMN expunge.progressnote_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.progressnote_expunge.documentpropertiesid IS 'Document properties id (foreign key) ';
COMMENT ON COLUMN expunge.progressnote_expunge.starttime IS 'Notes start time';
COMMENT ON COLUMN expunge.progressnote_expunge.endtime IS 'Notes end time';
COMMENT ON COLUMN expunge.progressnote_expunge.instantresults IS 'CJS Notes instantresults Positive, Negative';
COMMENT ON COLUMN expunge.progressnote_expunge.contactstatus IS 'CJS Notes contactstatus Yes ,No option';
COMMENT ON COLUMN expunge.progressnote_expunge.drugscreen IS 'CJS Notes drugscreen Yes ,No option';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnotepurposetypekey IS 'Progressnote purpose type';
COMMENT ON COLUMN expunge.progressnote_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.progressnote_expunge.traveltime IS 'Traveltime';
COMMENT ON COLUMN expunge.progressnote_expunge.totaltime IS 'Total time';
COMMENT ON COLUMN expunge.progressnote_expunge.progressnotereasontypekey IS 'Progress note reason types';
COMMENT ON COLUMN expunge.progressnote_expunge.locationname IS 'Location name';
COMMENT ON COLUMN expunge.progressnote_expunge.witsinboundid IS 'Wits in bound id';
COMMENT ON COLUMN expunge.progressnote_expunge.roletypekey IS 'Role types ';
COMMENT ON COLUMN expunge.progressnote_expunge.islocked IS 'Is locked';
COMMENT ON COLUMN expunge.progressnote_expunge.stafftypekey IS 'DJS Staff Type Dropdown list';
COMMENT ON COLUMN expunge.progressnote_expunge.notesid IS 'DJS Notes Tab History maintain in notesid';
COMMENT ON COLUMN expunge.progressnote_expunge.focusperson IS 'focus person json column';
COMMENT ON COLUMN expunge.progressnote_expunge.factor1_risk_scale IS 'Factor 1 Risk scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
COMMENT ON COLUMN expunge.progressnote_expunge.factor2_dependent_independent_scale IS 'Factor 2 dependent independent for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
COMMENT ON COLUMN expunge.progressnote_expunge.factor3_outcome_scale IS 'Factor 3 outcome scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
COMMENT ON COLUMN expunge.progressnote_expunge.isexpunged IS 'Flag to indicate the expunged record';