-- Drop table

-- DROP TABLE encr.intakeservicerequest_encr;

CREATE TABLE encr.intakeservicerequest_encr (
	intakeserviceencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	intakeserviceid uuid NOT NULL ,
	activeflag int4 NOT NULL DEFAULT 1,
	servicerequestnumber bytea NULL,
	servicerequestincidenttypekey varchar(15) NULL,
	narrative bytea NULL,
	title bytea NULL,
	description bytea NULL,
	reporteddate timestamp NULL,
	reportedtime timestamp NULL,
	reportedarea varchar(20) NULL,
	reportedtypekey varchar(15) NULL,
	reportedbyself bool NULL,
	sourcearea varchar(20) NULL,
	intakeservreqinputtypeid uuid NOT NULL,
	intakeservreqtypeid uuid NOT NULL,
	inputtypevalue varchar(50) NULL,
	intakeserreqstatustypeid uuid NOT NULL,
	intakeservicerequestclassid uuid NULL,
	crossreferencewith varchar(50) NULL,
	priorityid uuid NULL,
	statuschangedate timestamp NULL,
	statuschangedescription text NULL,
	dangerlevel int4 NULL,
	dangerreason varchar(500) NULL,
	accesslevel bool NOT NULL DEFAULT false,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	archiveon timestamp NULL,
	archiveby varchar(50) NULL,
	"timestamp" bytea NULL,
	old_id varchar(50) NULL,
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	suspiciousdeath bool NULL DEFAULT false,
	missingpersons bool NULL DEFAULT false,
	sharedcaretaxcredit bool NULL DEFAULT false,
	sharedcaretaxcredityear int4 NULL,
	agencyname varchar(256) NULL,
	notes text NULL,
	externalagencyphone bool NULL DEFAULT false,
	externalagencyfax bool NULL DEFAULT false,
	externalagencyemail bool NULL DEFAULT false,
	investigatable bool NULL DEFAULT false,
	visitinfo text NULL,
	illegalactivity bool NULL,
	intakeservicerequestillegalactivitytypekey varchar(15) NULL,
	targetcompletedate timestamp NULL,
	supervisorreview bool NULL,
	rarejectedmedicaidstatus bool NULL DEFAULT false,
	moneyfollowsperson bool NULL DEFAULT false,
	im54adate timestamp NULL,
	hcb bool NULL DEFAULT false,
	adverseactiondate timestamp NULL,
	applicationhearingreceiveddate timestamp NULL,
	reversaladverseactiondate timestamp NULL,
	monumber varchar(50) NULL,
	intakeservreqinputsourceid uuid NULL,
	isanonymousreporter bool NULL,
	intakeservreqpurposeid uuid NULL,
	isrouted bool NULL DEFAULT false,
	routedusersid varchar NULL,
	intakenumber bytea NULL,
	routedon timestamp NULL,
	teamtypekey varchar(25) NULL,
	isotheragency bool NULL DEFAULT false,
	isunknownreporter bool NULL,
	reporterfirstname bytea NULL,
	reporterlastname bytea NULL,
	isappealed bool NULL DEFAULT false,
	actiontype varchar(5) NULL,
	offenselocation varchar(100) NULL,
	requesterphone bytea NULL,
	requesterzipcode varchar(20) NULL,
	iszipcoderefuse bool NULL,
	iscps bool NULL,
	isaccepted bool NULL,
	accepteddate timestamp NULL,
	isdraft int4 NULL DEFAULT 0,
	foldertypekey varchar(100) NULL,
	folderreasontypekey varchar(50) NULL,
	folderopendatetime timestamp NULL,
	foldernotes text NULL,
	responsibilitytypekey varchar(50) NULL,
	exitdate timestamp NULL,
	islocalreferal int4 NULL,
	referalcomments bytea NULL,
	nonreferalreason bytea NULL,
	screeningname varchar(50) NULL,
	screenintypeflag int4 NULL,
	contacttypekey varchar(5) NULL,
	screenerid int4 NULL,
	recorddate timestamp NULL,
	recordtime timestamp NULL,
	scnapprovalstatustypekey varchar(5) NULL,
	scnapprovaldate timestamp NULL,
	screeningnmsoundex varchar(5) NULL,
	formattedreferralname bytea NULL,
	expungementflag int4 NULL,
	lastexpungementdate timestamp NULL,
	demoscreeningcompleteflag int4 NULL,
	narratvscreeningcompleteflag int4 NULL,
	rnmsoundex varchar(20) NULL,
	caseid uuid NULL,
	communicationastncrqrdflag int4 NULL,
	jurisdictionofincidenttypekey varchar(5) NULL,
	historyclearanceinfo bytea NULL,
	histclearanceenteredby varchar(10) NULL,
	histclearanceenteredtimestamp timestamp NULL,
	histclearanceeditedby varchar(50) NULL,
	histclearanceeditedtimestamp timestamp NULL,
	receivedtime timestamp NULL,
	fk1_id varchar(10) NULL,
	requesteraddress1 bytea NULL,
	requesteraddress2 bytea NULL,
	requestercity bytea NULL,
	requesterstate bytea NULL,
	requestercounty bytea NULL,
	isacknowledgementletter int4 NULL,
	isrestitution bool NULL,
	servicecaseid uuid NULL,
	countyid uuid NULL,
	constentreceiveddate timestamp NULL,
	searchworkername varchar(100) NULL,
	isnoticedthirdparty int4 NULL,
	isnoticedindividual int4 NULL,
	isclosecpshistory int4 NULL,
	clearancereasontypekey varchar(50) NULL,
	fk_source varchar(50) NULL,
	status_indc varchar(20) NULL,
	reportermiddlename bytea NULL,
	reporterphonenumber bytea NULL,
	reporterroletypekey varchar(50) NULL,
	reporterzipcode bytea NULL,
	reporterincidentlocation bytea NULL,
	reporteremail bytea NULL,
	reporterisapproximate bool NULL,
	reporterorganization bytea NULL,
	reportertitle varchar(150) NULL,
	reporterincidentdate timestamp NULL,
	reporterisanonymousreporter bool NULL,
	reporterisunknownreporter bool NULL,
	reporternarrative bytea NULL,
	reporterrefusetosharezip bytea NULL,
	reporterisacknowledgementletter int4 NULL,
	reporteraddress1 bytea NULL,
	reporteraddress2 bytea NULL,
	reportercity bytea NULL,
	reporterstate bytea NULL,
	narrativeupdateddate timestamp NULL,
	reporterphonenumberext bytea NULL,
	isscreening int4 NULL,
	intakedaterecieved timestamp NULL,
	hascisdata bool NULL DEFAULT false,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	responsetimer timestamp NULL,
	intakestatus text NULL,
	cissuid varchar(50) NULL,
	responsetimerdetails varchar NULL,
	addendum text NULL,
	untimely bool NULL DEFAULT false,
	addendumnarrativeupdateddate timestamp NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_intakeservicerequest_encr PRIMARY KEY (intakeserviceencrid),
	CONSTRAINT uk_intakeservicerequest_encrno UNIQUE (servicerequestnumber),
	CONSTRAINT fk_intakeservicerequest_encr_intakeserreqstatustype FOREIGN KEY (intakeserreqstatustypeid) REFERENCES intakeserreqstatustype(intakeserreqstatustypeid),
	CONSTRAINT fk_intakeservicerequest_encr_intakeservicerequestillegalactivitytype FOREIGN KEY (intakeservicerequestillegalactivitytypekey) REFERENCES intakeservicerequestillegalactivitytype(intakeservicerequestillegalactivitytypekey),
	CONSTRAINT fk_intakeservicerequest_encr_intakeservicerequestinputsource FOREIGN KEY (intakeservreqinputsourceid) REFERENCES intakeservicerequestinputsource(intakeservreqinputsourceid),
	CONSTRAINT fk_intakeservicerequest_encr_intakeservicerequesttype FOREIGN KEY (intakeservreqtypeid) REFERENCES intakeservicerequesttype(intakeservreqtypeid),
	CONSTRAINT fk_intakeservicerequest_encr_priority FOREIGN KEY (priorityid) REFERENCES priority(priorityid),
	CONSTRAINT fk_intakeservicerequest_encr_reportedtype FOREIGN KEY (reportedtypekey) REFERENCES reportedtype(reportedtypekey),
	CONSTRAINT fk_intakeservicerequest_encr_servicecase FOREIGN KEY (servicecaseid) REFERENCES servicecase(servicecaseid),
	CONSTRAINT fk_intakeservicerequest_encr_servicerequestincidenttype FOREIGN KEY (servicerequestincidenttypekey) REFERENCES servicerequestincidenttype(servicerequestincidenttypekey),
	CONSTRAINT fk_servicerequestsubtype_intakeservicerequest_encr FOREIGN KEY (intakeservicerequestclassid) REFERENCES servicerequestsubtype(servicerequestsubtypeid)
);
CREATE INDEX idx_intakeservicerequest_encr_casetype ON encr.intakeservicerequest_encr USING btree (teamtypekey, activeflag, isdraft, actiontype, servicerequestnumber);
CREATE INDEX idx_intakeservicerequest_encr_comp22 ON encr.intakeservicerequest_encr USING btree (servicecaseid, activeflag);
CREATE INDEX idx_intakeservicerequest_encr_intakeno ON encr.intakeservicerequest_encr USING btree (intakenumber);
CREATE INDEX idx_intakeservicerequest_encr_intakenoa ON encr.intakeservicerequest_encr USING btree (intakenumber, activeflag);
CREATE UNIQUE INDEX idx_intakeservicerequest_encrno ON encr.intakeservicerequest_encr USING btree (servicerequestnumber);
CREATE INDEX intakeservicerequest_encr_foldertypekey_idx ON encr.intakeservicerequest_encr USING btree (foldertypekey);
CREATE INDEX intakeservicerequest_encr_insertedby_idx ON encr.intakeservicerequest_encr USING btree (insertedby);
CREATE INDEX intakeservicerequest_encr_intakeserreqstatustypeid_idx ON encr.intakeservicerequest_encr USING btree (intakeserreqstatustypeid);
CREATE INDEX intakeservicerequest_encr_intakeservicerequestclassid_idx ON encr.intakeservicerequest_encr USING btree (intakeservicerequestclassid);
CREATE INDEX intakeservicerequest_encr_intakeservicerequestillegalactivitytypekey ON encr.intakeservicerequest_encr USING btree (intakeservicerequestillegalactivitytypekey);
CREATE INDEX intakeservicerequest_encr_intakeservreqinputtypeid_idx ON encr.intakeservicerequest_encr USING btree (intakeservreqinputtypeid);
CREATE INDEX intakeservicerequest_encr_intakeservreqtypeid_idx ON encr.intakeservicerequest_encr USING btree (intakeservreqtypeid);
CREATE INDEX intakeservicerequest_encr_priorityid_idx ON encr.intakeservicerequest_encr USING btree (priorityid);
CREATE INDEX intakeservicerequest_encr_reportedtypekey_idx ON encr.intakeservicerequest_encr USING btree (reportedtypekey);
CREATE INDEX intakeservicerequest_encr_servicerequestincidenttypekey_idx ON encr.intakeservicerequest_encr USING btree (servicerequestincidenttypekey);
CREATE INDEX ix_intakeservicerequest_encr_insertedby_insertedon ON encr.intakeservicerequest_encr USING btree (insertedby, insertedon);
CREATE INDEX ix_intakeservicerequest_encr_intakeservicerequestclassid_insertedon ON encr.intakeservicerequest_encr USING btree (intakeservicerequestclassid, insertedon);
CREATE INDEX ix_intakeservicerequest_encr_intakeservicerequestclassidcomp ON encr.intakeservicerequest_encr USING btree (intakeservreqtypeid, intakeservicerequestclassid);
CREATE INDEX ix_intakeservicerequest_encr_intakeservid_actflg ON encr.intakeservicerequest_encr USING btree (intakeserviceid, activeflag);
CREATE INDEX xie1_intakeservicerequest_encr ON encr.intakeservicerequest_encr USING btree (lower((servicerequestnumber)::text), actiontype, isdraft, teamtypekey) WHERE (((actiontype)::text = ANY (ARRAY[('IR'::character varying)::text, ('AR'::character varying)::text])) AND (isdraft = 0) AND ((teamtypekey)::text = 'CW'::text));
CREATE INDEX xie2_intakeservicerequest_encr ON encr.intakeservicerequest_encr USING btree (lower((servicerequestnumber)::text), teamtypekey, activeflag);
CREATE INDEX xie3_intakeservicerequest_encr ON encr.intakeservicerequest_encr USING btree (routedusersid, isrouted, activeflag);

-- Column comments
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeserviceencrid IS 'Intake details stored in this table in encrypted form(Primary key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeserviceid IS 'Intake details stored in this table intakeservicerequest(Primary key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakeservicerequest_encr.servicerequestnumber IS 'Intake Number';
COMMENT ON COLUMN encr.intakeservicerequest_encr.servicerequestincidenttypekey IS ' service request incidenttype  (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.narrative IS 'Details of intake';
COMMENT ON COLUMN encr.intakeservicerequest_encr.title IS 'Title';
COMMENT ON COLUMN encr.intakeservicerequest_encr.description IS 'Description of intake';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reporteddate IS 'Reported date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reportedtime IS 'Reported time';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reportedarea IS 'Intake reporte darea';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reportedtypekey IS 'Intake reportedtypekey(foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reportedbyself IS 'Self reported flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.sourcearea IS 'Source area';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservreqinputtypeid IS 'Input source id (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservreqtypeid IS 'Service type id (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.inputtypevalue IS 'Input type value';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeserreqstatustypeid IS 'Intake status type id (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservicerequestclassid IS 'Service subtype id (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.crossreferencewith IS 'Crossreference Intake number';
COMMENT ON COLUMN encr.intakeservicerequest_encr.priorityid IS 'Priority id';
COMMENT ON COLUMN encr.intakeservicerequest_encr.statuschangedate IS 'Status change date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.statuschangedescription IS 'Status change description';
COMMENT ON COLUMN encr.intakeservicerequest_encr.dangerlevel IS 'Dangerl level';
COMMENT ON COLUMN encr.intakeservicerequest_encr.dangerreason IS 'Dangerreason';
COMMENT ON COLUMN encr.intakeservicerequest_encr.accesslevel IS 'Access level';
COMMENT ON COLUMN encr.intakeservicerequest_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakeservicerequest_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakeservicerequest_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakeservicerequest_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakeservicerequest_encr.archiveon IS 'Archived date ';
COMMENT ON COLUMN encr.intakeservicerequest_encr.archiveby IS 'Archiveby';
COMMENT ON COLUMN encr.intakeservicerequest_encr."timestamp" IS 'Timestamp';
COMMENT ON COLUMN encr.intakeservicerequest_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.intakeservicerequest_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.intakeservicerequest_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.suspiciousdeath IS 'Suspicious death';
COMMENT ON COLUMN encr.intakeservicerequest_encr.missingpersons IS 'Missing persons';
COMMENT ON COLUMN encr.intakeservicerequest_encr.sharedcaretaxcredit IS 'Shared care tax credit';
COMMENT ON COLUMN encr.intakeservicerequest_encr.sharedcaretaxcredityear IS 'Shared care tax credit year';
COMMENT ON COLUMN encr.intakeservicerequest_encr.agencyname IS 'Name of the agency';
COMMENT ON COLUMN encr.intakeservicerequest_encr.notes IS 'Notes';
COMMENT ON COLUMN encr.intakeservicerequest_encr.externalagencyphone IS 'Contains phone number of external agency';
COMMENT ON COLUMN encr.intakeservicerequest_encr.externalagencyfax IS 'External agency fax';
COMMENT ON COLUMN encr.intakeservicerequest_encr.externalagencyemail IS 'External agency email';
COMMENT ON COLUMN encr.intakeservicerequest_encr.investigatable IS 'Investigatable';
COMMENT ON COLUMN encr.intakeservicerequest_encr.visitinfo IS 'Visitinfo';
COMMENT ON COLUMN encr.intakeservicerequest_encr.illegalactivity IS 'illegal activity';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservicerequestillegalactivitytypekey IS 'illegal activity type key (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.targetcompletedate IS 'Target complete date of intake';
COMMENT ON COLUMN encr.intakeservicerequest_encr.supervisorreview IS 'Supervisor review of Intake';
COMMENT ON COLUMN encr.intakeservicerequest_encr.rarejectedmedicaidstatus IS 'Rrarejected medica id status';
COMMENT ON COLUMN encr.intakeservicerequest_encr.moneyfollowsperson IS 'Money follow sperson';
COMMENT ON COLUMN encr.intakeservicerequest_encr.im54adate IS 'Im54adate';
COMMENT ON COLUMN encr.intakeservicerequest_encr.hcb IS 'Hcb';
COMMENT ON COLUMN encr.intakeservicerequest_encr.adverseactiondate IS 'Averseactiondate';
COMMENT ON COLUMN encr.intakeservicerequest_encr.applicationhearingreceiveddate IS 'Application hearing receive ddate';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reversaladverseactiondate IS 'Aeversal adverse action date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.monumber IS 'Monumber';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservreqinputsourceid IS 'Input source id (foreign key)';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isanonymousreporter IS 'Is anonymous reporter';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakeservreqpurposeid IS 'Servreq purpose id';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isrouted IS 'Is routed';
COMMENT ON COLUMN encr.intakeservicerequest_encr.routedusersid IS 'Routed users id';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN encr.intakeservicerequest_encr.routedon IS 'Routed on';
COMMENT ON COLUMN encr.intakeservicerequest_encr.teamtypekey IS 'Team type';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isotheragency IS 'Otheragency flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isunknownreporter IS 'unknownreporter flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reporterfirstname IS 'Reporter firstname';
COMMENT ON COLUMN encr.intakeservicerequest_encr.reporterlastname IS 'Reporter lastname';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isappealed IS 'Appealed flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.actiontype IS 'Action type';
COMMENT ON COLUMN encr.intakeservicerequest_encr.offenselocation IS 'Offense location';
COMMENT ON COLUMN encr.intakeservicerequest_encr.requesterphone IS 'Requester phone';
COMMENT ON COLUMN encr.intakeservicerequest_encr.requesterzipcode IS 'Requester zipcode';
COMMENT ON COLUMN encr.intakeservicerequest_encr.iszipcoderefuse IS 'Zipcode refuse flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.iscps IS 'CPS flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isaccepted IS 'Accepted flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.accepteddate IS 'Accepted date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isdraft IS 'draft flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.foldertypekey IS 'DJS Folder Type';
COMMENT ON COLUMN encr.intakeservicerequest_encr.folderreasontypekey IS 'DJS Folder Reason Type';
COMMENT ON COLUMN encr.intakeservicerequest_encr.folderopendatetime IS 'DJS Folder Open date and time';
COMMENT ON COLUMN encr.intakeservicerequest_encr.foldernotes IS 'DJS Folder notes';
COMMENT ON COLUMN encr.intakeservicerequest_encr.responsibilitytypekey IS 'responsibility type';
COMMENT ON COLUMN encr.intakeservicerequest_encr.exitdate IS 'Exit date';
COMMENT ON COLUMN encr.intakeservicerequest_encr.isrestitution IS 'Is Restitution Flag';
COMMENT ON COLUMN encr.intakeservicerequest_encr.servicecaseid IS 'Servicecase primary key';
COMMENT ON COLUMN encr.intakeservicerequest_encr.intakedaterecieved IS 'Intake received date to be used only for new cjams application intakes';
COMMENT ON COLUMN encr.intakeservicerequest_encr.cissuid IS 'Casenumber from CIS';
COMMENT ON COLUMN encr.intakeservicerequest_encr.addendum IS 'to add intake addendum';
COMMENT ON COLUMN encr.intakeservicerequest_encr.untimely IS 'untimely closed case boolean value stored in this column for the intakeservicerequest table';
COMMENT ON COLUMN encr.intakeservicerequest_encr.addendumnarrativeupdateddate IS 'to store addedndumNarrative updated date value';

