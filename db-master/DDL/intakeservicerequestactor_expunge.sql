-- expunge.intakeservicerequestactor_expunge definition

-- Drop table

-- DROP TABLE expunge.intakeservicerequestactor_expunge;

CREATE TABLE expunge.intakeservicerequestactor_expunge (
	intakeservicerequestactorexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Intake actor details stored in this table(Primary Key)
	intakeservicerequestactorid uuid NOT NULL, -- Intake actor details stored in this table(Primary Key)
	actorid uuid NOT NULL, -- Intake actor id(Foreign Key)
	intakeservicerequestpersontypekey varchar(15) NULL, -- Persontype key
	rapersontypekey varchar(15) NULL, -- Reported adult persontype (Foreign key)
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL, -- Record updated date and time
	expirationdate timestamp NULL, -- Record inactive date
	"timestamp" bytea NULL, -- Timestamp
	intakeserviceid uuid NULL, -- Intakeserviceid (Foreign key)
	routingaddressid uuid NULL, -- Routingaddress (Foreign key)
	employeetypeid uuid NULL, -- Employee type (Foreign key)
	employeetypename varchar(50) NULL, -- Employee name
	medicaideligibility bool NULL, -- Medicaideligibility
	blockgranteligibility bool NULL, -- Blockgranteligibility
	livingarrangementtypekey varchar(50) NULL, -- Livingarrangementtype (Foreign key)
	guardianname varchar(512) NULL, -- Guardianname
	guardianinfo varchar(126) NULL, -- Gardian information
	ramentalhealth bool NULL, -- Report adult health
	ramentalretarted bool NULL, -- Report adult retarted
	ramentalretartedtype varchar(50) NULL, -- Report adult mental retarted type
	refusessn bool NULL, -- Intake actor SSN
	refusedob bool NULL, -- Intake actor Date of Birth
	activeflag int4 DEFAULT 1 NULL, -- Status of the record
	reported bool DEFAULT false NULL, -- Reported 
	isprimary bool DEFAULT false NULL, -- Primary role
	personid uuid NULL, -- personid
	old_id varchar(50) NULL, -- Used for migration purpose
	ismaltreator bool NULL,
	rcprimaryroletypekey varchar(5) NULL,
	ncpspriorhistoryflag int4 NULL,
	householdnumber int4 NULL,
	ssnverifytypekey varchar(5) NULL,
	rchandicapflag int4 NULL,
	rchomelessflag int4 NULL,
	lvgarrangementtypekey varchar(5) NULL,
	livingprefixtypekey varchar(5) NULL,
	lvgfirstname varchar(20) NULL,
	lvgmiddlename varchar(20) NULL,
	lvglastname varchar(20) NULL,
	lvgsuffixtypekey varchar(5) NULL,
	lvgrelationshiptypekey varchar(5) NULL,
	lvgcomments varchar(500) NULL,
	rchouseholdflag int4 NULL,
	rcchildflag int4 NULL,
	nonparticipatingflag int4 NULL,
	householdheadflag int4 NULL,
	rcinsertedon timestamp(6) NULL,
	rcinsertedby varchar(10) NULL,
	rcupdatedon timestamp(6) NULL,
	rcupdatedby varchar(10) NULL,
	rcactiveflag int4 DEFAULT 1 NULL,
	livingwith varchar(500) NULL,
	rcreporteranonymousflag int4 NULL,
	rcreporternoletterflag int4 NULL,
	clientflag int4 NULL,
	rcexpungementflag int4 NULL,
	rcdatavalidflag int4 NULL,
	rcclientmergeid int4 NULL,
	arclientid int4 NULL,
	arsummaryid int4 NULL,
	altrespclientid int4 NULL,
	participatingchildflag int4 NULL,
	aractiveflag int4 DEFAULT 1 NULL,
	screeningpersonid int4 NULL,
	prexpungementflag int4 NULL,
	prdatavalidflag int4 NULL,
	prinsertedby varchar(10) NULL,
	prupdatedby varchar(10) NULL,
	practiveflag int4 DEFAULT 1 NULL,
	referralclientid int4 NULL,
	caseclientid int4 NULL,
	crexpungementflag int4 NULL,
	crdatavalidflag int4 NULL,
	crinsertedby varchar(10) NULL,
	crupdatedby varchar(10) NULL,
	sphouseholdmemberflag int4 NULL,
	spchildflag int4 NULL,
	spreporteranonymousflag int4 NULL,
	spreporternoletterflag int4 NULL,
	spexpungementflag int4 NULL,
	fetalalcoholspctrmdisordflag int4 NULL,
	drugexposednewbornflag int4 NULL,
	probationsearchconductedflag int4 NULL,
	sexoffenderregisteredflag int4 NULL,
	otherdrugs int4 NULL,
	unknownreporterflag int4 NULL,
	spproviderid int4 NULL,
	fk_id varchar(50) NULL,
	isvictim int4 NULL,
	servicecaseid uuid NULL, -- Servicecase primary key
	fk_cl_id varchar(50) NULL,
	intakenumber varchar NULL,
	isheadofhousehold bool NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_intakeservicerequestactor_expunge PRIMARY KEY (intakeservicerequestactorexpungeid),
	CONSTRAINT fk_intakeservicerequest_expunge_actor FOREIGN KEY (actorid) REFERENCES cjams.actor(actorid),
	CONSTRAINT fk_intakeservicerequestactor_expunge_employeetype FOREIGN KEY (employeetypeid) REFERENCES cjams.employeetype(employeetypeid),
	CONSTRAINT fk_intakeservicerequestactor_expunge_livingarrangementtype FOREIGN KEY (livingarrangementtypekey) REFERENCES cjams.livingarrangementtype(livingarrangementtypekey),
	CONSTRAINT fk_intakeservicerequestactor_expunge_person FOREIGN KEY (personid) REFERENCES cjams.person(personid),
	CONSTRAINT fk_intakeservicerequestactor_expunge_personaddress FOREIGN KEY (routingaddressid) REFERENCES cjams.personaddress(personaddressid),
	CONSTRAINT fk_intakeservicerequestactor_expunge_rapersontype FOREIGN KEY (rapersontypekey) REFERENCES cjams.rapersontype(rapersontypekey)
);
CREATE INDEX idx_intakeservicerequestactor_expunge_person ON expunge.intakeservicerequestactor_expunge USING btree (intakeserviceid, activeflag, isheadofhousehold, personid, actorid);
CREATE INDEX idx_intakeservicerequestactor_expunge_serviceid ON expunge.intakeservicerequestactor_expunge USING btree (servicecaseid, actorid, intakeservicerequestactorid, intakeservicerequestpersontypekey);
CREATE INDEX indx_intakeserrequestactor_expunge_pertyekey22 ON expunge.intakeservicerequestactor_expunge USING btree (intakeservicerequestpersontypekey);
CREATE INDEX intakeservicerequestactor_expunge_activeflag_idx ON expunge.intakeservicerequestactor_expunge USING btree (activeflag);
CREATE INDEX intakeservicerequestactor_expunge_actorid_idx ON expunge.intakeservicerequestactor_expunge USING btree (actorid);
CREATE INDEX intakeservicerequestactor_expunge_employeetypeid_idx ON expunge.intakeservicerequestactor_expunge USING btree (employeetypeid);
CREATE INDEX intakeservicerequestactor_expunge_intakenumber_idx ON expunge.intakeservicerequestactor_expunge USING btree (intakenumber);
CREATE INDEX intakeservicerequestactor_expunge_intakeserviceid_idx ON expunge.intakeservicerequestactor_expunge USING btree (intakeserviceid);
CREATE INDEX intakeservicerequestactor_expunge_intakeservicerequest_idx ON expunge.intakeservicerequestactor_expunge USING btree (intakeserviceid, actorid, intakeservicerequestactorid);
CREATE INDEX intakeservicerequestactor_expunge_isheadofhousehold_idx ON expunge.intakeservicerequestactor_expunge USING btree (isheadofhousehold);
CREATE INDEX intakeservicerequestactor_expunge_livingarrangementtypekey_idx ON expunge.intakeservicerequestactor_expunge USING btree (livingarrangementtypekey);
CREATE INDEX intakeservicerequestactor_expunge_personid_idx ON expunge.intakeservicerequestactor_expunge USING btree (personid);
CREATE INDEX intakeservicerequestactor_expunge_rapersontypekey_idx ON expunge.intakeservicerequestactor_expunge USING btree (rapersontypekey);
CREATE INDEX intakeservicerequestactor_expunge_routingaddressid_idx ON expunge.intakeservicerequestactor_expunge USING btree (routingaddressid);
CREATE INDEX intakeservicerequestactor_expunge_servicecaseid_idx ON expunge.intakeservicerequestactor_expunge USING btree (servicecaseid);
CREATE INDEX ix_intakeservicerequestactor_expunge_object_id ON expunge.intakeservicerequestactor_expunge USING btree (objectid);
CREATE INDEX ix_intakeservicerequestactor_expunge_object_type ON expunge.intakeservicerequestactor_expunge USING btree (objecttype);

-- Column comments
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.intakeservicerequestactorexpungeid IS 'Intake actor details stored in this table(Primary Key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.intakeservicerequestactorid IS 'Intake actor details stored in this table(Primary Key) for intakeservicerequestactor table';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.actorid IS 'Intake actor id(Foreign Key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.intakeservicerequestpersontypekey IS 'Persontype key';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.rapersontypekey IS 'Reported adult persontype (Foreign key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge."timestamp" IS 'Timestamp';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.intakeserviceid IS 'Intakeserviceid (Foreign key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.routingaddressid IS 'Routingaddress (Foreign key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.employeetypeid IS 'Employee type (Foreign key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.employeetypename IS 'Employee name';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.medicaideligibility IS 'Medicaideligibility';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.blockgranteligibility IS 'Blockgranteligibility';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.livingarrangementtypekey IS 'Livingarrangementtype (Foreign key)';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.guardianname IS 'Guardianname';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.guardianinfo IS 'Gardian information';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.ramentalhealth IS 'Report adult health';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.ramentalretarted IS 'Report adult retarted';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.ramentalretartedtype IS 'Report adult mental retarted type';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.refusessn IS 'Intake actor SSN';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.refusedob IS 'Intake actor Date of Birth';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.reported IS 'Reported ';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.isprimary IS 'Primary role';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.personid IS 'personid';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.servicecaseid IS 'Servicecase primary key';
COMMENT ON COLUMN expunge.intakeservicerequestactor_expunge.isexpunged IS 'Flag to indicate the expunged record';
