
DROP TABLE cjams.permanencyplan_history;

CREATE TABLE  IF NOT EXISTS cjams.permanencyplan_history (
	permanencyplanhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	modifieddata json,
	rowtype character varying(20),
	permanencyplanid uuid NOT NULL,
	intakeservicerequestactorid uuid NULL,
	intakeserviceid uuid NULL,
	projecteddate timestamp NULL,
	achieveddate timestamp NULL,
	establisheddate timestamp NULL,
	caseworkername varchar(100) NULL,
	remarks text NULL,
	reviseddate timestamp NULL,
	effectivedate timestamp NULL, -- Record valid from
	insertedon timestamp NOT NULL DEFAULT now(), -- Record created date and time
	insertedby varchar(50) NOT NULL, -- User who created this record
	updatedon timestamp NULL, -- Record updated date and time
	updatedby varchar(50) NOT NULL, -- user who last updated the record
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	old_id varchar(50) NULL, -- Used for migration purpose
	primarypermanencytype varchar(25) NULL,
	concurrentpermanencytype varchar(25) NULL,
	primaryarrangetype varchar(25) NULL,
	concurrentarrangetype varchar(25) NULL,
	resourcename varchar(100) NULL,
	address1 varchar(100) NULL,
	address2 varchar(100) NULL,
	state varchar(32) NULL,
	city varchar(32) NULL,
	countyid uuid NULL,
	country varchar(50) NULL,
	zipcode varchar(32) NULL,
	primaryrelativename varchar(50) NULL,
	primarynonrelativename varchar(50) NULL,
	primaryprovidercode varchar(15) NULL,
	ispriresourceidentified int4 NULL,
	concurrentrelativename varchar(50) NULL,
	concurrentnonrelativename varchar(50) NULL,
	concurrentprovidercode varchar(15) NULL,
	isconresourceidentified int4 NULL,
	fk_id varchar(10) NULL,
	primaryproviderid int4 NULL,
	primarylivingrelativename varchar(50) NULL,
	primarylivingnonrelativename varchar(50) NULL,
	primarynoresourceflag int4 NULL,
	primarylegalstatustypekey varchar(5) NULL,
	secondaryproviderid int4 NULL,
	secondarylivingrelativename varchar(50) NULL,
	secondarynonrelativename varchar(50) NULL,
	secondarynoresourceflag int4 NULL,
	scndrylegalstatustypekey varchar(5) NULL,
	approvalstatustypekey varchar(5) NULL,
	datavalidsflag int4 NULL,
	clientmergeid uuid NULL,
	servicecaseid uuid NULL, -- Service Case id
	concurrentcomments text NULL,
	placementid uuid NULL, -- Placement id
	permplanquestdata jsonb NULL,
	enddate timestamp NULL,
	reason varchar NULL,
	parentname uuid NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	courtorderreceived bool NULL,
	parent2name uuid NULL,
	actualdata json NULL, -- To save permanencyplan actualdata 
	permanencyplanremainssame bool NULL, -- To save permanencyplanremainssame value 
	permanencyplanremainssamedate timestamp NULL, -- To save permanencyplanremainssamedate value 
	reviewdate timestamp NULL, -- To save reviewdate value 
	CONSTRAINT pk_permanencyplan_history PRIMARY KEY (permanencyplanhistoryid),
	CONSTRAINT fk_permanencyplan_hist FOREIGN KEY (permanencyplanid) REFERENCES permanencyplan(permanencyplanid)
);

COMMENT ON COLUMN cjams.permanencyplan_history.permanencyplanhistoryid IS 'Primary Key';
COMMENT ON COLUMN cjams.permanencyplan_history.intakeservicerequestactorid IS 'foreing key';
COMMENT ON COLUMN cjams.permanencyplan_history.intakeserviceid IS 'foreing key';
COMMENT ON COLUMN cjams.permanencyplan_history.projecteddate IS 'to save projecteddate';
COMMENT ON COLUMN cjams.permanencyplan_history.achieveddate IS 'to save achieveddate';
COMMENT ON COLUMN cjams.permanencyplan_history.establisheddate IS 'to save establisheddate';
COMMENT ON COLUMN cjams.permanencyplan_history.caseworkername IS 'to save caseworkername';
COMMENT ON COLUMN cjams.permanencyplan_history.remarks IS 'to save remarks';
COMMENT ON COLUMN cjams.permanencyplan_history.reviseddate IS 'to save reviseddate';
COMMENT ON COLUMN cjams.permanencyplan_history.effectivedate IS 'Record valid from';
COMMENT ON COLUMN cjams.permanencyplan_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.permanencyplan_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.permanencyplan_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.permanencyplan_history.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.permanencyplan_history.activeflag IS 'Status of the record';
COMMENT ON COLUMN cjams.permanencyplan_history.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN cjams.permanencyplan_history.primarypermanencytype IS 'to save primarypermanencytype';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentpermanencytype IS 'to save concurrentpermanencytype';
COMMENT ON COLUMN cjams.permanencyplan_history.primaryarrangetype IS 'to save primaryarrangetype';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentarrangetype IS 'to save concurrentarrangetype';
COMMENT ON COLUMN cjams.permanencyplan_history.resourcename IS 'to save resourcename';
COMMENT ON COLUMN cjams.permanencyplan_history.address1 IS 'to save address1';
COMMENT ON COLUMN cjams.permanencyplan_history.address2 IS 'to save address2';
COMMENT ON COLUMN cjams.permanencyplan_history.state IS 'to save state';
COMMENT ON COLUMN cjams.permanencyplan_history.city IS 'to save city';
COMMENT ON COLUMN cjams.permanencyplan_history.countyid IS 'to save countyid';
COMMENT ON COLUMN cjams.permanencyplan_history.country IS 'to save country';
COMMENT ON COLUMN cjams.permanencyplan_history.zipcode IS 'to save zipcode';
COMMENT ON COLUMN cjams.permanencyplan_history.primaryrelativename IS 'to save primaryrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.primarynonrelativename IS 'to save primarynonrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.primaryprovidercode IS 'to save primaryprovidercode';
COMMENT ON COLUMN cjams.permanencyplan_history.ispriresourceidentified IS 'to save ispriresourceidentified';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentrelativename IS 'to save concurrentrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentnonrelativename IS 'to save concurrentnonrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentprovidercode IS 'to save concurrentprovidercode';
COMMENT ON COLUMN cjams.permanencyplan_history.isconresourceidentified IS 'to save isconresourceidentified';
COMMENT ON COLUMN cjams.permanencyplan_history.fk_id IS 'to save fk_id';
COMMENT ON COLUMN cjams.permanencyplan_history.primaryproviderid IS 'to save primaryproviderid';
COMMENT ON COLUMN cjams.permanencyplan_history.primarylivingrelativename IS 'to save primarylivingrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.primarylivingnonrelativename IS 'to save primarylivingnonrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.primarynoresourceflag IS 'to save primarynoresourceflag';
COMMENT ON COLUMN cjams.permanencyplan_history.primarylegalstatustypekey IS 'to save primarylegalstatustypekey';
COMMENT ON COLUMN cjams.permanencyplan_history.secondaryproviderid IS 'to save secondaryproviderid';
COMMENT ON COLUMN cjams.permanencyplan_history.secondarylivingrelativename IS 'to save secondarylivingrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.secondarynonrelativename IS 'to save secondarynonrelativename';
COMMENT ON COLUMN cjams.permanencyplan_history.secondarynoresourceflag IS 'to save secondarynoresourceflag';
COMMENT ON COLUMN cjams.permanencyplan_history.scndrylegalstatustypekey IS 'to save scndrylegalstatustypekey';
COMMENT ON COLUMN cjams.permanencyplan_history.approvalstatustypekey IS 'to save approvalstatustypekey';
COMMENT ON COLUMN cjams.permanencyplan_history.datavalidsflag IS 'to save datavalidsflag';
COMMENT ON COLUMN cjams.permanencyplan_history.clientmergeid IS 'to save clientmergeid';
COMMENT ON COLUMN cjams.permanencyplan_history.servicecaseid IS 'Service Case id';
COMMENT ON COLUMN cjams.permanencyplan_history.concurrentcomments IS 'to save the comments';
COMMENT ON COLUMN cjams.permanencyplan_history.placementid IS 'Placement id';
COMMENT ON COLUMN cjams.permanencyplan_history.permplanquestdata IS 'to save permplanquestdata';
COMMENT ON COLUMN cjams.permanencyplan_history.enddate IS 'to save enddate';
COMMENT ON COLUMN cjams.permanencyplan_history.reason IS 'to save reason';
COMMENT ON COLUMN cjams.permanencyplan_history.parentname IS 'to save parentname';
COMMENT ON COLUMN cjams.permanencyplan_history.etl_userid IS '';
COMMENT ON COLUMN cjams.permanencyplan_history.etl_load_date IS '';
COMMENT ON COLUMN cjams.permanencyplan_history.courtorderreceived IS 'to save courtorderreceived';
COMMENT ON COLUMN cjams.permanencyplan_history.parent2name IS 'to save parent2name';