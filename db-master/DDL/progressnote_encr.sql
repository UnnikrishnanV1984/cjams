-- Drop table

-- DROP TABLE encr.progressnote_encr;

CREATE TABLE encr.progressnote_encr (
	progressnoteencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    progressnoteid uuid NOT NULL,
	progressnotetypeid uuid NOT NULL,
	title bytea NULL,
	description bytea NULL,
	entitytype bytea NOT NULL,
	entitytypeid varchar(50) NOT NULL,
	pagetitle varchar(250) NULL,
	pageurl text NULL,
	islatest int4 NULL,
	versionof uuid NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	archivedby varchar(50) NULL,
	archivedon timestamp NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	"timestamp" bytea NULL,
	savemode bool NOT NULL DEFAULT true,
	progressnotesubtypeid uuid NULL,
	contactdate timestamp NULL,
	contactname bytea NULL,
	progressnotetypekey varchar(20) NULL,
	contactroletypekey varchar(20) NULL,
	contactphone bytea NULL,
	contactemail bytea NULL,
	attemptindicator bool NULL,
	activeflag int4 NULL DEFAULT 1,
	documentpropertiesid uuid NULL,
	starttime timestamp NULL,
	endtime timestamp NULL,
	instantresults int4 NULL,
	contactstatus bool NULL,
	drugscreen bool NULL,
	progressnotepurposetypekey varchar(50) NULL,
	old_id varchar(50) NULL,
	traveltime bytea NULL,
	totaltime bytea NULL,
	progressnotereasontypekey bytea NULL,
	locationname bytea NULL,
	witsinboundid varchar(50) NULL,
	roletypekey varchar(15) NULL,
	islocked bool NULL DEFAULT false,
	stafftypekey varchar(50) NULL,
	notesid varchar(50) NULL,
	witsstatus varchar(1) NULL,
	witsupdatedate timestamp NULL,
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
	otherpersonname bytea NULL,
	uploadedfile bytea NULL,
	adjustmentfostercaretext bytea NULL,
	screeningfortheservicetext bytea NULL,
	ischildgotoshool bool NULL,
	qualityofcaretochildtext bytea NULL,
	fk_user_id bytea NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	fromjurisdictionid uuid NULL,
	tojurisdictionid uuid NULL,
	transferdate timestamp NULL,
	transfertime timestamp NULL,
	witsid bytea NOT NULL,
	travelstarttime timestamp NULL,
	travelendtime timestamp NULL,
	servicesprovided bytea NULL,
	otherservices bytea NULL,
	anyriskpresented bool NULL,
	otherrisk bytea NULL,
	focusperson bytea NULL,
	factor1_risk_scale varchar NULL,
	factor2_dependent_independent_scale varchar NULL,
	factor3_outcome_scale varchar NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_progressnote_encr PRIMARY KEY (progressnoteencrid),
	CONSTRAINT fk_progressnote_encr_contactroletype FOREIGN KEY (contactroletypekey) REFERENCES contactroletype(contactroletypekey),
	CONSTRAINT fk_progressnote_encr_progressnotepurposetypekey FOREIGN KEY (progressnotepurposetypekey) REFERENCES progressnotepurposetype(progressnotepurposetypekey)
);
CREATE INDEX indx_progressnote_encr_documentpropertiesid ON encr.progressnote_encr USING btree (documentpropertiesid);
CREATE INDEX ix1001_progressnote_encr ON encr.progressnote_encr USING btree (insertedby);
CREATE INDEX ix1003_progressnote_encr ON encr.progressnote_encr USING btree (insertedon);
CREATE INDEX ix1004_progressnote_encr ON encr.progressnote_encr USING btree (contactdate);
CREATE INDEX progressnote_encr_activeflag_idx ON encr.progressnote_encr USING btree (activeflag);
CREATE INDEX progressnote_encr_contactroletypekey_idx ON encr.progressnote_encr USING btree (contactroletypekey);
CREATE INDEX progressnote_encr_entitytype_idx ON encr.progressnote_encr USING btree (entitytype);
CREATE INDEX progressnote_encr_entitytypeid_idx ON encr.progressnote_encr USING btree (entitytypeid);
CREATE INDEX progressnote_encr_intakeserviceid_idx ON encr.progressnote_encr USING btree (intakeserviceid);
CREATE INDEX progressnote_encr_progressnotereasontypekey_idx ON encr.progressnote_encr USING btree (progressnotereasontypekey);
CREATE INDEX progressnote_encr_progressnotesubtypeid_idx ON encr.progressnote_encr USING btree (progressnotesubtypeid);
CREATE INDEX progressnote_encr_progressnotetypeid_idx ON encr.progressnote_encr USING btree (progressnotetypeid);
CREATE INDEX progressnote_encr_servicecaseid_idx ON encr.progressnote_encr USING btree (servicecaseid);
CREATE INDEX progressnote_encr_witsid_idx ON encr.progressnote_encr USING btree (witsid);
CREATE INDEX xie1_progressnote_encr ON encr.progressnote_encr USING btree (date(insertedon));
CREATE INDEX xie2_progressnote_encr ON encr.progressnote_encr USING btree (date(contactdate));

-- Column comments

COMMENT ON COLUMN encr.progressnote_encr.progressnoteencrid IS 'Progress note encrypted Table (Primary key)';
COMMENT ON COLUMN encr.progressnote_encr.progressnoteid IS 'Progress note Table (Primary key)';
COMMENT ON COLUMN encr.progressnote_encr.progressnotetypeid IS 'Progress note typeid (foreign key)';
COMMENT ON COLUMN encr.progressnote_encr.title IS 'Progress note title';
COMMENT ON COLUMN encr.progressnote_encr.description IS 'Description of the notes';
COMMENT ON COLUMN encr.progressnote_encr.entitytype IS 'Entity types';
COMMENT ON COLUMN encr.progressnote_encr.entitytypeid IS 'Entity type id (foreign key)';
COMMENT ON COLUMN encr.progressnote_encr.pagetitle IS 'Page title';
COMMENT ON COLUMN encr.progressnote_encr.pageurl IS 'Page url';
COMMENT ON COLUMN encr.progressnote_encr.islatest IS 'Is latest checked';
COMMENT ON COLUMN encr.progressnote_encr.versionof IS 'Notes version';
COMMENT ON COLUMN encr.progressnote_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.progressnote_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.progressnote_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.progressnote_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.progressnote_encr.savemode IS 'Save mode';
COMMENT ON COLUMN encr.progressnote_encr.progressnotesubtypeid IS 'Progress note sub type (foreign key)';
COMMENT ON COLUMN encr.progressnote_encr.contactdate IS 'Contact date';
COMMENT ON COLUMN encr.progressnote_encr.contactname IS 'Contact name';
COMMENT ON COLUMN encr.progressnote_encr.progressnotetypekey IS 'Progress note types';
COMMENT ON COLUMN encr.progressnote_encr.contactroletypekey IS 'Contact role types';
COMMENT ON COLUMN encr.progressnote_encr.contactphone IS 'Conact phone number';
COMMENT ON COLUMN encr.progressnote_encr.contactemail IS 'Contact email';
COMMENT ON COLUMN encr.progressnote_encr.attemptindicator IS 'Attempt indicator';
COMMENT ON COLUMN encr.progressnote_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.progressnote_encr.documentpropertiesid IS 'Document properties id (foreign key) ';
COMMENT ON COLUMN encr.progressnote_encr.starttime IS 'Notes start time';
COMMENT ON COLUMN encr.progressnote_encr.endtime IS 'Notes end time';
COMMENT ON COLUMN encr.progressnote_encr.instantresults IS 'CJS Notes instantresults Positive, Negative';
COMMENT ON COLUMN encr.progressnote_encr.contactstatus IS 'CJS Notes contactstatus Yes ,No option';
COMMENT ON COLUMN encr.progressnote_encr.drugscreen IS 'CJS Notes drugscreen Yes ,No option';
COMMENT ON COLUMN encr.progressnote_encr.progressnotepurposetypekey IS 'Progressnote purpose type';
COMMENT ON COLUMN encr.progressnote_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.progressnote_encr.traveltime IS 'Traveltime';
COMMENT ON COLUMN encr.progressnote_encr.totaltime IS 'Total time';
COMMENT ON COLUMN encr.progressnote_encr.progressnotereasontypekey IS 'Progress note reason types';
COMMENT ON COLUMN encr.progressnote_encr.locationname IS 'Location name';
COMMENT ON COLUMN encr.progressnote_encr.witsinboundid IS 'Wits in bound id';
COMMENT ON COLUMN encr.progressnote_encr.roletypekey IS 'Role types ';
COMMENT ON COLUMN encr.progressnote_encr.islocked IS 'Is locked';
COMMENT ON COLUMN encr.progressnote_encr.stafftypekey IS 'DJS Staff Type Dropdown list';
COMMENT ON COLUMN encr.progressnote_encr.notesid IS 'DJS Notes Tab History maintain in notesid';
COMMENT ON COLUMN encr.progressnote_encr.focusperson IS 'focus person json column';
COMMENT ON COLUMN encr.progressnote_encr.factor1_risk_scale IS 'Factor 1 Risk scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
COMMENT ON COLUMN encr.progressnote_encr.factor2_dependent_independent_scale IS 'Factor 2 dependent independent for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
COMMENT ON COLUMN encr.progressnote_encr.factor3_outcome_scale IS 'Factor 3 outcome scale for Contact purpose Case Closue and Reconsideration values, this will be used in case load priority assessment';
