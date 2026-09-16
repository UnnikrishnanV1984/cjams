-- expunge.intakeservicerequest_expunge definition

-- Drop table

-- DROP TABLE expunge.intakeservicerequest_expunge;

CREATE TABLE expunge.intakeservicerequest_expunge (
    intakeserviceexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Intake details stored in this table(Primary key)¶
	intakeserviceid uuid NOT NULL, -- Intake details stored in this table(Primary key)¶
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	servicerequestnumber varchar(50) NULL, -- Intake Number¶
	servicerequestincidenttypekey varchar(15) NULL, --  service request incidenttype  (foreign key)¶
	narrative text NULL, -- Details of intake¶
	title varchar(50) NULL, -- Title¶
	description varchar(4000) NULL, -- Description of intake¶
	reporteddate timestamp NULL, -- Reported date
	reportedtime timestamp NULL, -- Reported time
	reportedarea varchar(20) NULL, -- Intake reporte darea¶
	reportedtypekey varchar(15) NULL, -- Intake reportedtypekey(foreign key)¶
	reportedbyself bool NULL, -- Self reported flag¶
	sourcearea varchar(20) NULL, -- Source area¶
	intakeservreqinputtypeid uuid NOT NULL, -- Input source id (foreign key)¶
	intakeservreqtypeid uuid NOT NULL, -- Service type id (foreign key)¶
	inputtypevalue varchar(50) NULL, -- Input type value¶
	intakeserreqstatustypeid uuid NOT NULL, -- Intake status type id (foreign key)¶
	intakeservicerequestclassid uuid NULL, -- Service subtype id (foreign key)¶
	crossreferencewith varchar(50) NULL, -- Crossreference Intake number¶
	priorityid uuid NULL, -- Priority id¶
	statuschangedate timestamp NULL, -- Status change date¶
	statuschangedescription text NULL, -- Status change description¶
	dangerlevel int4 NULL, -- Dangerl level¶
	dangerreason varchar(500) NULL, -- Dangerreason¶
	accesslevel bool DEFAULT false NOT NULL, -- Access level¶
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	archiveon timestamp NULL, -- Archived date ¶
	archiveby varchar(50) NULL, -- Archiveby¶
	"timestamp" bytea NULL, -- Timestamp¶
	old_id varchar(50) NULL, -- Used for migration purpose
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from ¶
	expirationdate timestamp NULL, -- Record inactive date¶
	suspiciousdeath bool DEFAULT false NULL, -- Suspicious death¶
	missingpersons bool DEFAULT false NULL, -- Missing persons¶
	sharedcaretaxcredit bool DEFAULT false NULL, -- Shared care tax credit¶
	sharedcaretaxcredityear int4 NULL, -- Shared care tax credit year¶
	agencyname varchar(256) NULL, -- Name of the agency ¶
	notes text NULL, -- Notes¶
	externalagencyphone bool DEFAULT false NULL, -- Contains phone number of external agency ¶
	externalagencyfax bool DEFAULT false NULL, -- External agency fax¶
	externalagencyemail bool DEFAULT false NULL, -- External agency email¶
	investigatable bool DEFAULT false NULL, -- Investigatable¶
	visitinfo text NULL, -- Visitinfo¶
	illegalactivity bool NULL, -- illegal activity¶
	intakeservicerequestillegalactivitytypekey varchar(15) NULL, -- illegal activity type key (foreign key)¶
	targetcompletedate timestamp NULL, -- Target complete date of intake¶
	supervisorreview bool NULL, -- Supervisor review of Intake¶
	rarejectedmedicaidstatus bool DEFAULT false NULL, -- Rrarejected medica id status¶
	moneyfollowsperson bool DEFAULT false NULL, -- Money follow sperson¶
	im54adate timestamp NULL, -- Im54adate¶
	hcb bool DEFAULT false NULL, -- Hcb¶
	adverseactiondate timestamp NULL, -- Averseactiondate¶
	applicationhearingreceiveddate timestamp NULL, -- Application hearing receive ddate¶
	reversaladverseactiondate timestamp NULL, -- Aeversal adverse action date¶
	monumber varchar(50) NULL, -- Monumber¶
	intakeservreqinputsourceid uuid NULL, -- Input source id (foreign key)¶
	isanonymousreporter bool NULL, -- Is anonymous reporter¶
	intakeservreqpurposeid uuid NULL, -- Servreq purpose id¶
	isrouted bool DEFAULT false NULL, -- Is routed
	routedusersid varchar NULL, -- Routed users id
	intakenumber varchar NULL, -- Intakenumber
	routedon timestamp NULL, -- Routed on
	teamtypekey varchar(25) NULL, -- Team type
	isotheragency bool DEFAULT false NULL, -- Otheragency flag
	isunknownreporter bool NULL, -- unknownreporter flag
	reporterfirstname varchar(200) NULL, -- Reporter firstname
	reporterlastname varchar(200) NULL, -- Reporter lastname
	isappealed bool DEFAULT false NULL, -- Appealed flag
	actiontype varchar(5) NULL, -- Action type
	offenselocation varchar(100) NULL, -- Offense location
	requesterphone varchar(100) NULL, -- Requester phone
	requesterzipcode varchar(20) NULL, -- Requester zipcode
	iszipcoderefuse bool NULL, -- Zipcode refuse flag
	iscps bool NULL, -- CPS flag
	isaccepted bool NULL, -- Accepted flag
	accepteddate timestamp NULL, -- Accepted date
	isdraft int4 DEFAULT 0 NULL, -- draft flag
	foldertypekey varchar(100) NULL, -- DJS Folder Type
	folderreasontypekey varchar(50) NULL, -- DJS Folder Reason Type
	folderopendatetime timestamp NULL, -- DJS Folder Open date and time
	foldernotes text NULL, -- DJS Folder notes
	responsibilitytypekey varchar(50) NULL, -- responsibility type
	exitdate timestamp NULL, -- Exit date
	islocalreferal int4 NULL,
	referalcomments varchar(300) NULL,
	nonreferalreason varchar(1000) NULL,
	screeningname varchar(50) NULL,
	screenintypeflag int4 NULL,
	contacttypekey varchar(5) NULL,
	screenerid int4 NULL,
	recorddate timestamp(6) NULL,
	recordtime timestamp(6) NULL,
	scnapprovalstatustypekey varchar(5) NULL,
	scnapprovaldate timestamp(6) NULL,
	screeningnmsoundex varchar(5) NULL,
	formattedreferralname varchar(50) NULL,
	expungementflag int4 NULL,
	lastexpungementdate timestamp(6) NULL,
	demoscreeningcompleteflag int4 NULL,
	narratvscreeningcompleteflag int4 NULL,
	rnmsoundex varchar(20) NULL,
	caseid uuid NULL,
	communicationastncrqrdflag int4 NULL,
	jurisdictionofincidenttypekey varchar(5) NULL,
	historyclearanceinfo varchar(10000) NULL,
	histclearanceenteredby varchar(10) NULL,
	histclearanceenteredtimestamp timestamp(6) NULL,
	histclearanceeditedby varchar(50) NULL,
	histclearanceeditedtimestamp timestamp(6) NULL,
	receivedtime timestamp(6) NULL,
	fk1_id varchar(10) NULL,
	requesteraddress1 varchar(100) NULL,
	requesteraddress2 varchar(100) NULL,
	requestercity varchar(100) NULL,
	requesterstate varchar(2) NULL,
	requestercounty varchar(50) NULL,
	isacknowledgementletter int4 NULL,
	isrestitution bool NULL, -- Is Restitution Flag
	servicecaseid uuid NULL, -- Servicecase primary key
	countyid uuid NULL,
	constentreceiveddate timestamp NULL,
	searchworkername varchar(100) NULL,
	isnoticedthirdparty int4 NULL,
	isnoticedindividual int4 NULL,
	isclosecpshistory int4 NULL,
	clearancereasontypekey varchar(50) NULL,
	fk_source varchar(50) NULL,
	status_indc varchar(20) NULL,
	reportermiddlename varchar(50) NULL,
	reporterphonenumber varchar(50) NULL,
	reporterroletypekey varchar(50) NULL,
	reporterzipcode varchar(50) NULL,
	reporterincidentlocation text NULL,
	reporteremail varchar(50) NULL,
	reporterisapproximate bool NULL,
	reporterorganization varchar(120) NULL,
	reportertitle varchar(150) NULL,
	reporterincidentdate timestamp NULL,
	reporterisanonymousreporter bool NULL,
	reporterisunknownreporter bool NULL,
	reporternarrative text NULL,
	reporterrefusetosharezip varchar(50) NULL,
	reporterisacknowledgementletter int4 NULL,
	reporteraddress1 varchar(500) NULL,
	reporteraddress2 varchar(500) NULL,
	reportercity varchar(150) NULL,
	reporterstate varchar(150) NULL,
	narrativeupdateddate timestamp NULL,
	reporterphonenumberext varchar(10) NULL,
	isscreening int4 NULL,
	intakedaterecieved timestamp NULL, -- Intake received date to be used only for new cjams application intakes
	hascisdata bool DEFAULT false NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	responsetimer timestamp NULL,
	intakestatus text NULL,
	cissuid varchar(50) NULL, -- Casenumber from CIS
	responsetimerdetails varchar NULL,
	addendum text NULL, -- to add intake addendum
	untimely bool DEFAULT false NULL, -- untimely closed case boolean value stored in this column for the intakeservicerequest table
	addendumnarrativeupdateddate timestamp NULL, -- to store addedndumNarrative updated date value
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_intakeservicerequest_expunge PRIMARY KEY (intakeserviceexpungeid),
	CONSTRAINT uk_intakeservicerequest_expungeno UNIQUE (servicerequestnumber),
	CONSTRAINT fk_intakeservicerequest_expunge_intakeserreqstatustype FOREIGN KEY (intakeserreqstatustypeid) REFERENCES cjams.intakeserreqstatustype(intakeserreqstatustypeid),
	CONSTRAINT fk_intakeservicerequest_expunge_intakeservicerequestillegalactivitytype FOREIGN KEY (intakeservicerequestillegalactivitytypekey) REFERENCES cjams.intakeservicerequestillegalactivitytype(intakeservicerequestillegalactivitytypekey),
	CONSTRAINT fk_intakeservicerequest_expunge_intakeservicerequestinputsource FOREIGN KEY (intakeservreqinputsourceid) REFERENCES cjams.intakeservicerequestinputsource(intakeservreqinputsourceid),
	CONSTRAINT fk_intakeservicerequest_expunge_intakeservicerequesttype FOREIGN KEY (intakeservreqtypeid) REFERENCES cjams.intakeservicerequesttype(intakeservreqtypeid),
	CONSTRAINT fk_intakeservicerequest_expunge_priority FOREIGN KEY (priorityid) REFERENCES cjams.priority(priorityid),
	CONSTRAINT fk_intakeservicerequest_expunge_reportedtype FOREIGN KEY (reportedtypekey) REFERENCES cjams.reportedtype(reportedtypekey),
	CONSTRAINT fk_intakeservicerequest_expunge_servicecase FOREIGN KEY (servicecaseid) REFERENCES cjams.servicecase(servicecaseid),
	CONSTRAINT fk_intakeservicerequest_expunge_servicerequestincidenttype FOREIGN KEY (servicerequestincidenttypekey) REFERENCES cjams.servicerequestincidenttype(servicerequestincidenttypekey),
	CONSTRAINT fk_servicerequestsubtype_intakeservicerequest_expunge FOREIGN KEY (intakeservicerequestclassid) REFERENCES cjams.servicerequestsubtype(servicerequestsubtypeid)
);
CREATE INDEX idx_intakeservicerequest_expunge_casetype ON expunge.intakeservicerequest_expunge USING btree (teamtypekey, activeflag, isdraft, actiontype, servicerequestnumber);
CREATE INDEX idx_intakeservicerequest_expunge_comp22 ON expunge.intakeservicerequest_expunge USING btree (servicecaseid, activeflag);
CREATE INDEX idx_intakeservicerequest_expunge_intakeno ON expunge.intakeservicerequest_expunge USING btree (intakenumber);
CREATE INDEX idx_intakeservicerequest_expunge_intakenoa ON expunge.intakeservicerequest_expunge USING btree (intakenumber, activeflag);
CREATE UNIQUE INDEX idx_intakeservicerequest_expungeno ON expunge.intakeservicerequest_expunge USING btree (servicerequestnumber);
CREATE INDEX idx_trgm_intakeservicerequest_expunge_servicerequestnumber ON expunge.intakeservicerequest_expunge USING gin (lower((servicerequestnumber)::text) gin_trgm_ops);
CREATE INDEX intakeservicerequest_expunge_foldertypekey_idx ON expunge.intakeservicerequest_expunge USING btree (foldertypekey);
CREATE INDEX intakeservicerequest_expunge_insertedby_idx ON expunge.intakeservicerequest_expunge USING btree (insertedby);
CREATE INDEX intakeservicerequest_expunge_intakeserreqstatustypeid_idx ON expunge.intakeservicerequest_expunge USING btree (intakeserreqstatustypeid);
CREATE INDEX "intakeservicerequest_expunge_intakeserviceid_IDX" ON expunge.intakeservicerequest_expunge USING btree (intakeserviceid, isexpunged);
CREATE INDEX intakeservicerequest_expunge_intakeservicerequestclassid_idx ON expunge.intakeservicerequest_expunge USING btree (intakeservicerequestclassid);
CREATE INDEX intakeservicerequest_expunge_intakeservicerequestillegalactivitytypekey ON expunge.intakeservicerequest_expunge USING btree (intakeservicerequestillegalactivitytypekey);
CREATE INDEX intakeservicerequest_expunge_intakeservreqinputtypeid_idx ON expunge.intakeservicerequest_expunge USING btree (intakeservreqinputtypeid);
CREATE INDEX intakeservicerequest_expunge_intakeservreqtypeid_idx ON expunge.intakeservicerequest_expunge USING btree (intakeservreqtypeid);
CREATE INDEX intakeservicerequest_expunge_priorityid_idx ON expunge.intakeservicerequest_expunge USING btree (priorityid);
CREATE INDEX intakeservicerequest_expunge_reportedtypekey_idx ON expunge.intakeservicerequest_expunge USING btree (reportedtypekey);
CREATE INDEX intakeservicerequest_expunge_servicerequestincidenttypekey_idx ON expunge.intakeservicerequest_expunge USING btree (servicerequestincidenttypekey);
CREATE INDEX ix_intakeservicerequest_expunge_insertedby_insertedon ON expunge.intakeservicerequest_expunge USING btree (insertedby, insertedon);
CREATE INDEX ix_intakeservicerequest_expunge_intakeservicerequestclassid_insertedon ON expunge.intakeservicerequest_expunge USING btree (intakeservicerequestclassid, insertedon);
CREATE INDEX ix_intakeservicerequest_expunge_intakeservicerequestclassidcomp ON expunge.intakeservicerequest_expunge USING btree (intakeservreqtypeid, intakeservicerequestclassid);
CREATE INDEX ix_intakeservicerequest_expunge_intakeservid_actflg ON expunge.intakeservicerequest_expunge USING btree (intakeserviceid, activeflag);
CREATE INDEX xie1_intakeservicerequest_expunge ON expunge.intakeservicerequest_expunge USING btree (lower((servicerequestnumber)::text), actiontype, isdraft, teamtypekey) WHERE (((actiontype)::text = ANY (ARRAY[('IR'::character varying)::text, ('AR'::character varying)::text])) AND (isdraft = 0) AND ((teamtypekey)::text = 'CW'::text));
CREATE INDEX xie2_intakeservicerequest_expunge ON expunge.intakeservicerequest_expunge USING btree (lower((servicerequestnumber)::text), teamtypekey, activeflag);
CREATE INDEX xie3_intakeservicerequest_expunge ON expunge.intakeservicerequest_expunge USING btree (routedusersid, isrouted, activeflag);

-- Column comments
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeserviceexpungeid IS 'Intake details stored in this table(Primary key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeserviceid IS 'Intake details stored in this table(Primary key) for intakeservicerequest table 
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.servicerequestnumber IS 'Intake Number
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.servicerequestincidenttypekey IS ' service request incidenttype  (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.narrative IS 'Details of intake
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.title IS 'Title
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.description IS 'Description of intake
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reporteddate IS 'Reported date';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reportedtime IS 'Reported time';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reportedarea IS 'Intake reporte darea
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reportedtypekey IS 'Intake reportedtypekey(foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reportedbyself IS 'Self reported flag
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.sourcearea IS 'Source area
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservreqinputtypeid IS 'Input source id (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservreqtypeid IS 'Service type id (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.inputtypevalue IS 'Input type value
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeserreqstatustypeid IS 'Intake status type id (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservicerequestclassid IS 'Service subtype id (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.crossreferencewith IS 'Crossreference Intake number
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.priorityid IS 'Priority id
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.statuschangedate IS 'Status change date
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.statuschangedescription IS 'Status change description
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.dangerlevel IS 'Dangerl level
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.dangerreason IS 'Dangerreason
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.accesslevel IS 'Access level
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.archiveon IS 'Archived date 
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.archiveby IS 'Archiveby
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge."timestamp" IS 'Timestamp
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.effectivedate IS 'Record valid from 
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.expirationdate IS 'Record inactive date
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.suspiciousdeath IS 'Suspicious death
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.missingpersons IS 'Missing persons
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.sharedcaretaxcredit IS 'Shared care tax credit
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.sharedcaretaxcredityear IS 'Shared care tax credit year
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.agencyname IS 'Name of the agency 
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.notes IS 'Notes
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.externalagencyphone IS 'Contains phone number of external agency 
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.externalagencyfax IS 'External agency fax
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.externalagencyemail IS 'External agency email
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.investigatable IS 'Investigatable
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.visitinfo IS 'Visitinfo
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.illegalactivity IS 'illegal activity
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservicerequestillegalactivitytypekey IS 'illegal activity type key (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.targetcompletedate IS 'Target complete date of intake
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.supervisorreview IS 'Supervisor review of Intake
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.rarejectedmedicaidstatus IS 'Rrarejected medica id status
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.moneyfollowsperson IS 'Money follow sperson
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.im54adate IS 'Im54adate
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.hcb IS 'Hcb
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.adverseactiondate IS 'Averseactiondate
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.applicationhearingreceiveddate IS 'Application hearing receive ddate
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reversaladverseactiondate IS 'Aeversal adverse action date
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.monumber IS 'Monumber
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservreqinputsourceid IS 'Input source id (foreign key)
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isanonymousreporter IS 'Is anonymous reporter
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakeservreqpurposeid IS 'Servreq purpose id
';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isrouted IS 'Is routed';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.routedusersid IS 'Routed users id';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.routedon IS 'Routed on';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.teamtypekey IS 'Team type';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isotheragency IS 'Otheragency flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isunknownreporter IS 'unknownreporter flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reporterfirstname IS 'Reporter firstname';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.reporterlastname IS 'Reporter lastname';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isappealed IS 'Appealed flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.actiontype IS 'Action type';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.offenselocation IS 'Offense location';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.requesterphone IS 'Requester phone';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.requesterzipcode IS 'Requester zipcode';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.iszipcoderefuse IS 'Zipcode refuse flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.iscps IS 'CPS flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isaccepted IS 'Accepted flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.accepteddate IS 'Accepted date';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isdraft IS 'draft flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.foldertypekey IS 'DJS Folder Type';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.folderreasontypekey IS 'DJS Folder Reason Type';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.folderopendatetime IS 'DJS Folder Open date and time';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.foldernotes IS 'DJS Folder notes';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.responsibilitytypekey IS 'responsibility type';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.exitdate IS 'Exit date';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isrestitution IS 'Is Restitution Flag';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.servicecaseid IS 'Servicecase primary key';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.intakedaterecieved IS 'Intake received date to be used only for new cjams application intakes';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.cissuid IS 'Casenumber from CIS';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.addendum IS 'to add intake addendum';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.untimely IS 'untimely closed case boolean value stored in this column for the intakeservicerequest table';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.addendumnarrativeupdateddate IS 'to store addedndumNarrative updated date value';
COMMENT ON COLUMN expunge.intakeservicerequest_expunge.isexpunged IS 'Flag to indicate the expunged record';