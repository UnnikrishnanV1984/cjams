-- expunge.investigation_expunge definition

-- Drop table

-- DROP TABLE expunge.investigation_expunge;

CREATE TABLE expunge.investigation_expunge (
	investigationexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Investigation details stored in this table (primary key)
	investigationid uuid NOT NULL, -- Investigation details stored in this table (primary key)
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	intakeserviceid uuid NOT NULL, -- Intake service id (foreign key)
	riskscore int4 NULL, -- Risk core
	reviewdate timestamp NULL, -- Review date
	targetcompletiondate timestamp NULL, -- Target completion date
	completiondate timestamp NULL, -- Completion date
	investigationsummary text NULL, -- Summary of the investigation
	insertedby varchar(50) NOT NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	"timestamp" bytea NULL, -- Timestamp¶
	cursoryreviewid uuid NULL, -- Cursory review id
	edl bool NULL, -- Edl
	financial bool NULL, -- Financial
	jointinvestigation bool NULL, -- Join investigation
	investigationreviewtypekey varchar(50) NULL, -- Review type key of investigation (foreign key)
	investigationreviewtypedate timestamp NULL, -- Date of investigation review type
	old_id varchar(50) NULL, -- Used for migration purpose
	referralname varchar(50) NULL,
	referraltypeflag int4 NULL,
	contacttypekey varchar(50) NULL,
	screenerid int4 NULL,
	recorddate timestamp(6) NULL,
	recordtime timestamp(6) NULL,
	critialincidentflag int4 NULL,
	immdtdangerflag int4 NULL,
	childfacilityflag int4 NULL,
	priorityflag int4 NULL,
	priorityreason varchar(200) NULL,
	allegmaltreatmentdate timestamp(6) NULL,
	agencyname varchar(150) NULL,
	formattypekey varchar(50) NULL,
	streetnumber int4 NULL,
	boxnumber int4 NULL,
	predirtypekey varchar(50) NULL,
	streetname varchar(100) NULL,
	streetsuffixtypekey varchar(50) NULL,
	postdirtypekey varchar(50) NULL,
	unittypekey varchar(50) NULL,
	unittext varchar(100) NULL,
	cityname varchar(100) NULL,
	countytypekey varchar(50) NULL,
	statetypekey varchar(50) NULL,
	zip5no int4 NULL,
	zip4no int4 NULL,
	direction varchar(500) NULL,
	foreignaddress varchar(500) NULL,
	foreignstate varchar(50) NULL,
	country varchar(50) NULL,
	postalcode varchar(50) NULL,
	workphone varchar(50) NULL,
	workextn varchar(50) NULL,
	email varchar(100) NULL,
	fax varchar(10) NULL,
	url varchar(100) NULL,
	othercontacts varchar(100) NULL,
	outofhomeflag int4 NULL,
	outofhometypekey varchar(50) NULL,
	referralinformation varchar(5000) NULL,
	commrqrdflag int4 NULL,
	lawifiedflag int4 NULL,
	complaint varchar(20) NULL,
	lawofficerassignedflag int4 NULL,
	badge varchar(20) NULL,
	lawdistrict varchar(20) NULL,
	lawofficerprefixtypekey varchar(50) NULL,
	lawofficerfirstname varchar(20) NULL,
	lawofficermiddlename varchar(20) NULL,
	lawofficerlastname varchar(20) NULL,
	lawofficersuffixtypekey varchar(50) NULL,
	officerphone varchar(10) NULL,
	lawifieddate timestamp(6) NULL,
	lawifiedtime timestamp(6) NULL,
	completeddate timestamp(6) NULL,
	completedtime timestamp(6) NULL,
	snapshotflag int4 NULL,
	cpsrecommendflag int4 NULL,
	cpsrecommendtypekey varchar(50) NULL,
	screenoutreasontypekey varchar(50) NULL,
	screenoutreason varchar(1000) NULL,
	cpasdecision varchar(500) NULL,
	ncpsreferraltypekey varchar(50) NULL,
	ncpsreferralflag int4 NULL,
	ncpsreason varchar(500) NULL,
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
	ncpscomments varchar(1000) NULL,
	ircomments varchar(1000) NULL,
	referralstatusflag int4 NULL,
	invaccepteddate timestamp(6) NULL,
	invfindingdate timestamp(6) NULL,
	disposition varchar(5000) NULL,
	lawenforcementflag int4 NULL,
	lawenforcementresults varchar(1000) NULL,
	invcomments varchar(1000) NULL,
	refapprvstatustypekey varchar(50) NULL,
	invappvstatustypekey varchar(50) NULL,
	caseid uuid NULL,
	hcrecomtocloseflag int4 NULL,
	providerid int4 NULL,
	primaryflag int4 NULL,
	streettext varchar(500) NULL,
	intinvfinalflag int4 NULL,
	intinvfinaldate timestamp(6) NULL,
	refnamesoundex varchar(20) NULL,
	frmrefname varchar(50) NULL,
	intinvexpungeflag int4 NULL,
	manualexpungeflag int4 NULL,
	expungementflag int4 NULL,
	rnmsoundex varchar(20) NULL,
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
	fatalitycommentaudittrail jsonb NULL, -- Json data to store fatality comments, previous and current dropdown status values
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_investigation_expunge PRIMARY KEY (investigationexpungeid),
	CONSTRAINT fk_investigationexpunge_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES cjams.intakeservicerequest(intakeserviceid),
	CONSTRAINT fk_investigation_expunge_investigationreviewtype FOREIGN KEY (investigationreviewtypekey) REFERENCES cjams.investigationreviewtype(investigationreviewtypekey)
);
CREATE INDEX investigation_expunge_intakeserviceid_idx ON expunge.investigation_expunge USING btree (intakeserviceid);
CREATE INDEX investigation_expunge_intakeservicerequest_idx ON expunge.investigation_expunge USING btree (intakeserviceid, investigationid);
CREATE INDEX investigation_expunge_investigationid_idx ON expunge.investigation_expunge USING btree (investigationid, activeflag, intakeserviceid);
CREATE INDEX investigation_expunge_investigationreviewtypekey_idx ON expunge.investigation_expunge USING btree (investigationreviewtypekey);

-- Column comments
COMMENT ON COLUMN expunge.investigation_expunge.investigationexpungeid IS 'Investigation details stored in this table (primary key)';
COMMENT ON COLUMN expunge.investigation_expunge.investigationid IS 'Investigation details stored in this table (primary key) for investigation table';
COMMENT ON COLUMN expunge.investigation_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.investigation_expunge.intakeserviceid IS 'Intake service id (foreign key)';
COMMENT ON COLUMN expunge.investigation_expunge.riskscore IS 'Risk core';
COMMENT ON COLUMN expunge.investigation_expunge.reviewdate IS 'Review date';
COMMENT ON COLUMN expunge.investigation_expunge.targetcompletiondate IS 'Target completion date';
COMMENT ON COLUMN expunge.investigation_expunge.completiondate IS 'Completion date';
COMMENT ON COLUMN expunge.investigation_expunge.investigationsummary IS 'Summary of the investigation';
COMMENT ON COLUMN expunge.investigation_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.investigation_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.investigation_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.investigation_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.investigation_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.investigation_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.investigation_expunge."timestamp" IS 'Timestamp
';
COMMENT ON COLUMN expunge.investigation_expunge.cursoryreviewid IS 'Cursory review id';
COMMENT ON COLUMN expunge.investigation_expunge.edl IS 'Edl';
COMMENT ON COLUMN expunge.investigation_expunge.financial IS 'Financial';
COMMENT ON COLUMN expunge.investigation_expunge.jointinvestigation IS 'Join investigation';
COMMENT ON COLUMN expunge.investigation_expunge.investigationreviewtypekey IS 'Review type key of investigation (foreign key)';
COMMENT ON COLUMN expunge.investigation_expunge.investigationreviewtypedate IS 'Date of investigation review type';
COMMENT ON COLUMN expunge.investigation_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.investigation_expunge.fatalitycommentaudittrail IS 'Json data to store fatality comments, previous and current dropdown status values';
COMMENT ON COLUMN expunge.investigation_expunge.isexpunged IS 'Flag to indicate the expunged record';