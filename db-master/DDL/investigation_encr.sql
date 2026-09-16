-- encr.investigation_encr definition

-- Drop table

-- DROP TABLE encr.investigation_encr;

CREATE TABLE encr.investigation_encr (
    investigationencrid uuid DEFAULT cjams.gen_random_uuid() NOT NULL,
	investigationid uuid NOT NULL,
	activeflag int4 DEFAULT 1 NOT NULL,
	intakeserviceid uuid NOT NULL,
	riskscore int4 NULL,
	reviewdate timestamp NULL,
	targetcompletiondate timestamp NULL,
	completiondate timestamp NULL,
	investigationsummary text NULL,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp DEFAULT now() NOT NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp DEFAULT now() NULL,
	effectivedate timestamp DEFAULT now() NOT NULL,
	expirationdate timestamp NULL,
	"timestamp" bytea NULL,
	cursoryreviewid uuid NULL,
	edl bool NULL,
	financial bool NULL,
	jointinvestigation bool NULL,
	investigationreviewtypekey varchar(50) NULL,
	investigationreviewtypedate timestamp NULL,
	old_id varchar(50) NULL,
	referralname bytea NULL,
	referraltypeflag int4 NULL,
	contacttypekey varchar(50) NULL,
	screenerid int4 NULL,
	recorddate timestamp(6) NULL,
	recordtime timestamp(6) NULL,
	critialincidentflag int4 NULL,
	immdtdangerflag int4 NULL,
	childfacilityflag int4 NULL,
	priorityflag int4 NULL,
	priorityreason bytea NULL,
	allegmaltreatmentdate timestamp(6) NULL,
	agencyname bytea NULL,
	formattypekey varchar(50) NULL,
	streetnumber int4 NULL,
	boxnumber int4 NULL,
	predirtypekey varchar(50) NULL,
	streetname bytea NULL,
	streetsuffixtypekey varchar(50) NULL,
	postdirtypekey varchar(50) NULL,
	unittypekey varchar(50) NULL,
	unittext bytea NULL,
	cityname bytea NULL,
	countytypekey varchar(50) NULL,
	statetypekey varchar(50) NULL,
	zip5no int4 NULL,
	zip4no int4 NULL,
	direction bytea NULL,
	foreignaddress varchar(500) NULL,
	foreignstate varchar(50) NULL,
	country varchar(50) NULL,
	postalcode varchar(50) NULL,
	workphone bytea NULL,
	workextn bytea NULL,
	email varchar(50) NULL,
	fax varchar(50) NULL,
	url bytea NULL,
	othercontacts bytea NULL,
	outofhomeflag int4 NULL,
	outofhometypekey varchar(50) NULL,
	referralinformation bytea NULL,
	commrqrdflag int4 NULL,
	lawifiedflag int4 NULL,
	complaint bytea NULL,
	lawofficerassignedflag int4 NULL,
	badge bytea NULL,
	lawdistrict bytea NULL,
	lawofficerprefixtypekey varchar(50) NULL,
	lawofficerfirstname bytea NULL,
	lawofficermiddlename bytea NULL,
	lawofficerlastname bytea NULL,
	lawofficersuffixtypekey varchar(50) NULL,
	officerphone bytea NULL,
	lawifieddate timestamp(6) NULL,
	lawifiedtime timestamp(6) NULL,
	completeddate timestamp(6) NULL,
	completedtime timestamp(6) NULL,
	snapshotflag int4 NULL,
	cpsrecommendflag int4 NULL,
	cpsrecommendtypekey varchar(50) NULL,
	screenoutreasontypekey varchar(50) NULL,
	screenoutreason bytea NULL,
	cpasdecision varchar(500) NULL,
	ncpsreferraltypekey varchar(50) NULL,
	ncpsreferralflag int4 NULL,
	ncpsreason bytea NULL,
	irtypetypekey varchar(50) NULL,
	irothertype varchar(1000) NULL,
	recommtocloseflag int4 NULL,
	iractiontakentypekey varchar(50) NULL,
	irworkeractiontaken varchar(1000) NULL,
	hcreasontypekey varchar(50) NULL,
	hcconsentreceiveddate timestamp(6) NULL,
	hcsearchstaffid int4 NULL,
	hchistfoundtypekey varchar(50) NULL,
	idenmaltreatertypekey varchar(50) NULL,
	caserecordreviewtypekey varchar(50) NULL,
	thirdpartyletterflag int4 NULL,
	individualletterflag int4 NULL,
	mltrtrhearingtypekey varchar(50) NULL,
	hccomments varchar(1000) NULL,
	cpscomments varchar(1000) NULL,
	ncpscomments bytea NULL,
	ircomments varchar(1000) NULL,
	referralstatusflag int4 NULL,
	invaccepteddate timestamp(6) NULL,
	invfindingdate timestamp(6) NULL,
	disposition bytea NULL,
	lawenforcementflag int4 NULL,
	lawenforcementresults bytea NULL,
	invcomments bytea NULL,
	refapprvstatustypekey varchar(50) NULL,
	invappvstatustypekey varchar(50) NULL,
	caseid uuid NULL,
	hcrecomtocloseflag int4 NULL,
	providerid int4 NULL,
	primaryflag int4 NULL,
	streettext bytea NULL,
	intinvfinalflag int4 NULL,
	intinvfinaldate timestamp(6) NULL,
	refnamesoundex bytea NULL,
	frmrefname bytea NULL,
	intinvexpungeflag int4 NULL,
	manualexpungeflag int4 NULL,
	expungementflag int4 NULL,
	rnmsoundex bytea NULL,
	orderofshelterflag int4 NULL,
	lastexpungementdate timestamp(6) NULL,
	oohmaltsettingtypekey varchar(50) NULL,
	privateadoptiondate timestamp(6) NULL,
	adoptionofferedflag int4 NULL,
	onlysubsidyflag int4 NULL,
	accepdeclinedflag int4 NULL,
	maonlypaymenttypekey varchar(50) NULL,
	fatheragreementdate timestamp(6) NULL,
	motheragreementdate timestamp(6) NULL,
	designeeagreementdate timestamp(6) NULL,
	screeningid int4 NULL,
	assistingcountytypekey varchar(50) NULL,
	cpsresponsetypekey varchar(50) NULL,
	fk_id varchar(10) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	fatalitycommentaudittrail bytea NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_investigation_encr PRIMARY KEY (investigationencrid),
	CONSTRAINT fk_investigation_encr_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES cjams.intakeservicerequest(intakeserviceid),
	CONSTRAINT fk_investigation_encr_investigationreviewtype FOREIGN KEY (investigationreviewtypekey) REFERENCES cjams.investigationreviewtype(investigationreviewtypekey)
);
CREATE INDEX investigation_encr_intakeserviceid_idx ON encr.investigation_encr USING btree (intakeserviceid);
CREATE INDEX investigation_encr_intakeservicerequest_idx ON encr.investigation_encr USING btree (intakeserviceid, investigationid);
CREATE INDEX investigation_encr_investigationid_idx ON encr.investigation_encr USING btree (investigationid, activeflag, intakeserviceid);
CREATE INDEX investigation_encr_investigationreviewtypekey_idx ON encr.investigation_encr USING btree (investigationreviewtypekey);

-- Column comments
COMMENT ON COLUMN encr.investigation_encr.investigationencrid IS 'Investigation details encryted data stored in this table (primary key)';
COMMENT ON COLUMN encr.investigation_encr.investigationid IS 'Investigation details stored in this table (primary key)';
COMMENT ON COLUMN encr.investigation_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.investigation_encr.intakeserviceid IS 'Intake service id (foreign key)';
COMMENT ON COLUMN encr.investigation_encr.riskscore IS 'Risk core';
COMMENT ON COLUMN encr.investigation_encr.reviewdate IS 'Review date';
COMMENT ON COLUMN encr.investigation_encr.targetcompletiondate IS 'Target completion date';
COMMENT ON COLUMN encr.investigation_encr.completiondate IS 'Completion date';
COMMENT ON COLUMN encr.investigation_encr.investigationsummary IS 'Summary of the investigation';
COMMENT ON COLUMN encr.investigation_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.investigation_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.investigation_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.investigation_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.investigation_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.investigation_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.investigation_encr."timestamp" IS 'Timestamp
';
COMMENT ON COLUMN encr.investigation_encr.cursoryreviewid IS 'Cursory review id';
COMMENT ON COLUMN encr.investigation_encr.edl IS 'Edl';
COMMENT ON COLUMN encr.investigation_encr.financial IS 'Financial';
COMMENT ON COLUMN encr.investigation_encr.jointinvestigation IS 'Join investigation';
COMMENT ON COLUMN encr.investigation_encr.investigationreviewtypekey IS 'Review type key of investigation (foreign key)';
COMMENT ON COLUMN encr.investigation_encr.investigationreviewtypedate IS 'Date of investigation review type';
COMMENT ON COLUMN encr.investigation_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.investigation_encr.fatalitycommentaudittrail IS 'Json data to store fatality comments, previous and current dropdown status values';