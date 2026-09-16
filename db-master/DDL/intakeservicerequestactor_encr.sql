-- Drop table

-- DROP TABLE encr.intakeservicerequestactor_encr;

CREATE TABLE encr.intakeservicerequestactor_encr (
	intakeservicerequestactorencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    intakeservicerequestactorid uuid NOT NULL,
	actorid uuid NOT NULL,
	intakeservicerequestpersontypekey bytea NULL,
	rapersontypekey varchar(15) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	expirationdate timestamp NULL,
	"timestamp" bytea NULL,
	intakeserviceid uuid NULL,
	routingaddressid uuid NULL,
	employeetypeid uuid NULL,
	employeetypename varchar(50) NULL,
	medicaideligibility bool NULL,
	blockgranteligibility bool NULL,
	livingarrangementtypekey varchar(50) NULL,
	guardianname varchar(512) NULL,
	guardianinfo varchar(126) NULL,
	ramentalhealth bool NULL,
	ramentalretarted bool NULL,
	ramentalretartedtype varchar(50) NULL,
	refusessn bool NULL,
	refusedob bool NULL,
	activeflag int4 NULL DEFAULT 1,
	reported bool NULL DEFAULT false,
	isprimary bool NULL DEFAULT false,
	personid bytea NULL,
	old_id varchar(50) NULL,
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
	rcinsertedon timestamp NULL,
	rcinsertedby varchar(10) NULL,
	rcupdatedon timestamp NULL,
	rcupdatedby varchar(10) NULL,
	rcactiveflag int4 NULL DEFAULT 1,
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
	aractiveflag int4 NULL DEFAULT 1,
	screeningpersonid int4 NULL,
	prexpungementflag int4 NULL,
	prdatavalidflag int4 NULL,
	prinsertedby varchar(10) NULL,
	prupdatedby varchar(10) NULL,
	practiveflag int4 NULL DEFAULT 1,
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
	servicecaseid uuid NULL,
	fk_cl_id varchar(50) NULL,
	intakenumber bytea NULL,
	isheadofhousehold bool NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_intakeservicerequestactor_encr PRIMARY KEY (intakeservicerequestactorencrid),
	CONSTRAINT fk_intakeservicerequestactor_encr_actor FOREIGN KEY (actorid) REFERENCES actor(actorid),
	CONSTRAINT fk_intakeservicerequestactor_encr_employeetype FOREIGN KEY (employeetypeid) REFERENCES employeetype(employeetypeid),
	CONSTRAINT fk_intakeservicerequestactor_encr_livingarrangementtype FOREIGN KEY (livingarrangementtypekey) REFERENCES livingarrangementtype(livingarrangementtypekey),
	CONSTRAINT fk_intakeservicerequestactor_encr_personaddress FOREIGN KEY (routingaddressid) REFERENCES personaddress(personaddressid),
	CONSTRAINT fk_intakeservicerequestactor_encr_rapersontype FOREIGN KEY (rapersontypekey) REFERENCES rapersontype(rapersontypekey)
);
CREATE INDEX idx_intakeservicerequestactor_encr_person ON encr.intakeservicerequestactor_encr USING btree (intakeserviceid, activeflag, isheadofhousehold, personid, actorid);
CREATE INDEX idx_intakeservicerequestactor_encr_serviceid ON encr.intakeservicerequestactor_encr USING btree (servicecaseid, actorid, intakeservicerequestactorid, intakeservicerequestpersontypekey);
CREATE INDEX intakeservicerequestactor_encr_activeflag_idx ON encr.intakeservicerequestactor_encr USING btree (activeflag);
CREATE INDEX intakeservicerequestactor_encr_actorid_idx ON encr.intakeservicerequestactor_encr USING btree (actorid);
CREATE INDEX intakeservicerequestactor_encr_employeetypeid_idx ON encr.intakeservicerequestactor_encr USING btree (employeetypeid);
CREATE INDEX intakeservicerequestactor_encr_intakenumber_idx ON encr.intakeservicerequestactor_encr USING btree (intakenumber);
CREATE INDEX intakeservicerequestactor_encr_intakeserviceid_idx ON encr.intakeservicerequestactor_encr USING btree (intakeserviceid);
CREATE INDEX intakeservicerequestactor_encr_intakeservicerequest_idx ON encr.intakeservicerequestactor_encr USING btree (intakeserviceid, actorid, intakeservicerequestactorid);
CREATE INDEX intakeservicerequestactor_encr_intakeservicerequestpersontypekey_idx ON encr.intakeservicerequestactor_encr USING btree (intakeservicerequestpersontypekey);
CREATE INDEX intakeservicerequestactor_encr_isheadofhousehold_idx ON encr.intakeservicerequestactor_encr USING btree (isheadofhousehold);
CREATE INDEX intakeservicerequestactor_encr_livingarrangementtypekey_idx ON encr.intakeservicerequestactor_encr USING btree (livingarrangementtypekey);
CREATE INDEX intakeservicerequestactor_encr_personid_idx ON encr.intakeservicerequestactor_encr USING btree (personid);
CREATE INDEX intakeservicerequestactor_encr_rapersontypekey_idx ON encr.intakeservicerequestactor_encr USING btree (rapersontypekey);
CREATE INDEX intakeservicerequestactor_encr_routingaddressid_idx ON encr.intakeservicerequestactor_encr USING btree (routingaddressid);
CREATE INDEX intakeservicerequestactor_encr_servicecaseid_idx ON encr.intakeservicerequestactor_encr USING btree (servicecaseid);
CREATE INDEX ix_intakeservicerequestactor_encr_object_id ON encr.intakeservicerequestactor_encr USING btree (objectid);
CREATE INDEX ix_intakeservicerequestactor_encr_object_type ON encr.intakeservicerequestactor_encr USING btree (objecttype);

-- Column comments
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.intakeservicerequestactorencrid IS 'Intake actor details stored in this Encrypted table(Primary Key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.intakeservicerequestactorid IS 'Intake actor details stored in this table(Primary Key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.actorid IS 'Intake actor id(Foreign Key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.intakeservicerequestpersontypekey IS 'Persontype key';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.rapersontypekey IS 'Reported adult persontype (Foreign key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr."timestamp" IS 'Timestamp';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.intakeserviceid IS 'Intakeserviceid (Foreign key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.routingaddressid IS 'Routingaddress (Foreign key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.employeetypeid IS 'Employee type (Foreign key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.employeetypename IS 'Employee name';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.medicaideligibility IS 'Medicaideligibility';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.blockgranteligibility IS 'Blockgranteligibility';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.livingarrangementtypekey IS 'Livingarrangementtype (Foreign key)';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.guardianname IS 'Guardianname';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.guardianinfo IS 'Gardian information';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.ramentalhealth IS 'Report adult health';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.ramentalretarted IS 'Report adult retarted';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.ramentalretartedtype IS 'Report adult mental retarted type';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.refusessn IS 'Intake actor SSN';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.refusedob IS 'Intake actor Date of Birth';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.reported IS 'Reported ';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.isprimary IS 'Primary role';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.personid IS 'personid';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.intakeservicerequestactor_encr.servicecaseid IS 'Servicecase primary key';