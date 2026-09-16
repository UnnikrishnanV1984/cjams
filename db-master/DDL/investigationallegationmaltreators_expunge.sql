-- expunge.investigationallegationmaltreators_expunge definition

-- Drop table

-- DROP TABLE expunge.investigationallegationmaltreators_expunge;

CREATE TABLE expunge.investigationallegationmaltreators_expunge (
    investigationallegationmaltreatorsexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Unique identifier of this table (Primary Key)
	investigationallegationmaltreatorsid uuid NOT NULL, -- Unique identifier of this table (Primary Key)
	investigationallegationid uuid NOT NULL, -- Investigationallegationid (Foreign Key)
	intakeservicerequestactorid uuid NULL, -- Intakeservicerequestactorid (Foreign Key)
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	insertedby varchar(50) NOT NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	old_id varchar(50) NULL, -- Used for migration purpose
	othermaltreator varchar NULL, -- Othermaltreator
	clientroleid int4 NULL,
	oaicesentdate timestamp(6) NULL,
	oahearingdatesetflag int4 NULL,
	oahearingdate timestamp(6) NULL,
	oanorhearingreason varchar(500) NULL,
	oahearingdecision varchar(500) NULL,
	oahearingdecisiondate timestamp(6) NULL,
	oadetails varchar(500) NULL,
	ccstayrequestedflag int4 NULL,
	ccstaygrantedflag int4 NULL,
	ccappealedflag int4 NULL,
	cchearingdecisiontypekey varchar(5) NULL,
	cchearingdecisiondate timestamp(6) NULL,
	ccdetails varchar(500) NULL,
	csastayrequestedflag int4 NULL,
	csastaygrantedflag int4 NULL,
	csaappealedflag int4 NULL,
	csahearingdecisiontypekey varchar(5) NULL,
	csahearingdecisiondate timestamp(6) NULL,
	csadetails varchar(500) NULL,
	oaappealedflag int4 NULL,
	scicesentdate timestamp(6) NULL,
	scconfheldflag int4 NULL,
	scdecisiontypekey varchar(5) NULL,
	scconferencedetail varchar(500) NULL,
	scconferencedate timestamp(6) NULL,
	overridedate timestamp(6) NULL,
	overrideby varchar(10) NULL,
	overridefindingtypekey varchar(50) NULL,
	overridecomments varchar(500) NULL,
	overrideapprflag int4 NULL,
	cccourtdecisionflag int4 NULL,
	cccompileddate timestamp(6) NULL,
	csacourtdecisionflag int4 NULL,
	csacompileddate timestamp(6) NULL,
	expungementflag int4 NULL,
	expungementprocessedflag int4 NULL,
	coastayreqflag int4 NULL,
	coastaygrantedflag int4 NULL,
	coaappealedflag int4 NULL,
	coahearingdecisiontypekey varchar(5) NULL,
	coahearingdecisiondate timestamp(6) NULL,
	coadetails varchar(50) NULL,
	coacase varchar(1) NULL,
	coacourtdecisionflag int4 NULL,
	coacompileddate timestamp(6) NULL,
	isvictim int4 NULL, -- Helps to identity the person is Victim
	coacasenumber varchar(50) NULL,
	oacasenumber varchar(50) NULL,
	cccasenumber varchar(50) NULL,
	csacasenumber varchar(50) NULL,
	scisappealed bool NULL,
	scappealedby varchar(50) NULL,
	scappealeddate timestamp NULL,
	oaldssname varchar(50) NULL,
	oaappellentatrny varchar(50) NULL,
	oalocaldept varchar(50) NULL,
	oarunningmotion varchar(50) NULL,
	ccldssname varchar(50) NULL,
	ccappellentatrny varchar(50) NULL,
	coaldssname varchar(50) NULL,
	coaappellentatrny varchar(50) NULL,
	csaldssname varchar(50) NULL,
	csaappellentatrny varchar(50) NULL,
	csanotifiedtodirector bool NULL,
	csacertiorari bool NULL,
	ccwhoappealed varchar(50) NULL,
	ccnotifiedtodirector bool NULL,
	cccicuitcourtkey varchar(50) NULL,
	ccldssnotifieddate timestamp NULL,
	csaldssnotifieddate timestamp NULL,
	scsummarymailed bool NULL,
	scappealedsetdate timestamp NULL,
	csawhoappealed varchar(50) NULL,
	fk_cid varchar(50) NULL,
	fk_rcd varchar(50) NULL,
	oahearingheldreason varchar(50) NULL,
	oahearingheld varchar(50) NULL,
	oalocationofhearing varchar(100) NULL,
	oahearingnarrative varchar NULL,
	oamodificationsmade varchar NULL,
	oarunningmotiondate timestamp NULL,
	oatranslator bool NULL,
	cclocationofhearing varchar(100) NULL,
	cchearingheld varchar(50) NULL,
	cchearingheldreason varchar(50) NULL,
	csaarguementheld varchar(50) NULL,
	csaarguementnotheldreason varchar(50) NULL,
	coacertioraristatus varchar(50) NULL,
	coacertgranteddate timestamp NULL,
	coacertdenieddate timestamp NULL,
	csalocationofhearing varchar(100) NULL,
	coalocationofhearing varchar(100) NULL,
	csahearingheldreason varchar(50) NULL,
	scisappealformsent varchar(10) NULL,
	oasummarydecisionfiledflag varchar(10) NULL,
	oasummarydecisionfileddate timestamp(6) NULL,
	oacompiledwithoah varchar(10) NULL,
	finalizeflag bool NULL,
	approveappeal bool NULL,
	appealfinding varchar(50) NULL,
	workercomments text NULL,
	finalizeddate timestamp NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	oahmaltreatmenttypeid uuid NULL,
	ccmaltreatmenttypeid uuid NULL,
	csmaltreatmenttypeid uuid NULL,
	coamaltreatmenttypeid uuid NULL,
	scmaltreatmenttypeid uuid NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_investigationallegationmaltreators_expunge PRIMARY KEY (investigationallegationmaltreatorsexpungeid),
	CONSTRAINT fk_investigationallegationmaltreators_expunge_intakeservicerequestactor FOREIGN KEY (intakeservicerequestactorid) REFERENCES cjams.intakeservicerequestactor(intakeservicerequestactorid),
	CONSTRAINT fk_investigationallegationmaltreators_expunge_investigationallegationid FOREIGN KEY (investigationallegationid) REFERENCES cjams.investigationallegation(investigationallegationid)
);
CREATE INDEX indx_investigationallegationmaltreators_expunge_id ON expunge.investigationallegationmaltreators_expunge USING btree (investigationallegationid);
CREATE INDEX indx_investigationallegationmaltreators_expunge_intakeservicerequestact ON expunge.investigationallegationmaltreators_expunge USING btree (investigationallegationid);
CREATE INDEX xie1_investigationallegationmaltreators_expunge ON expunge.investigationallegationmaltreators_expunge USING btree (intakeservicerequestactorid);

-- Column comments
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.investigationallegationmaltreatorsexpungeid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.investigationallegationmaltreatorsid IS 'Unique identifier of this table (Primary Key) for investigationallegationmaltreators table';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.investigationallegationid IS 'Investigationallegationid (Foreign Key)';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.intakeservicerequestactorid IS 'Intakeservicerequestactorid (Foreign Key)';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.othermaltreator IS 'Othermaltreator';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.isvictim IS 'Helps to identity the person is Victim';
COMMENT ON COLUMN expunge.investigationallegationmaltreators_expunge.isexpunged IS 'Flag to indicate the expunged record';