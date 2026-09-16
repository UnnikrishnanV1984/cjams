-- expunge.actor_expunge definition

-- Drop table

-- DROP TABLE expunge.actor_expunge;

CREATE TABLE expunge.actor_expunge (
	actorexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Actor details stored in this table (primary key)
	actorid uuid NOT NULL, -- Actor details stored in this table (primary key)
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	personid uuid NOT NULL, -- Person Id (Foreign Key)
	actortype varchar(50) NOT NULL, -- Type of actor
	dangerlevel int4 NULL, -- Danger level
	dangerreason varchar(512) NULL, -- Danger reason
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL, -- Record updated date and time
	expirationdate timestamp NULL, -- Record inactive date
	"timestamp" bytea NULL, -- Timestamp¶
	primarylanguageid uuid NULL, -- Primary Language id of actor (foreign key)
	secondarylanguageid uuid NULL, -- Secondary language id
	employeetypeid uuid NULL, -- Employee type id (foreign key)
	employeetypename varchar(50) NULL, -- Employee type name
	medicaideligibility bool DEFAULT true NULL, -- Medicaideligibility
	blockgranteligibility bool DEFAULT true NULL, -- Blockgranteligibility
	recipientstatus bool DEFAULT true NULL, -- Recipientstatus
	livingarrangementtypekey varchar(50) NULL, -- living arrangement type key (foreign key)
	interpreterrequired varchar(256) NULL, -- interpreterrequired
	guardianname varchar(50) NULL, -- Guardianname
	guardianinfo varchar(126) NULL, -- Guardianinfo
	ramentalhealth bool NULL, -- Ramentalhealth
	ramentalretarted bool NULL, -- Ramentalretartedtype
	ramentalretartedtype varchar(50) NULL, -- Ramentalretartedtype
	manualupdateflag bpchar(1) DEFAULT 'N'::bpchar NOT NULL, -- Manualupdateflag
	intakeserviceid uuid NULL, -- Case Id
	iscollateralcontact int4 NULL, -- Collateral Contact flag updated
	old_id varchar(50) NULL, -- Used for migration purpose
	ismentalillness int4 NULL, -- Mentalillness
	mentalillnessdetail varchar NULL, -- MentalillnessDetail
	ismentalimpair int4 NULL, -- Mentalillness
	mentalimpairdetail varchar NULL, -- MentalimpairDetail
	ishouseholdmember int4 NULL, -- House hold memeber flag updated 
	isdangertoworker int4 NULL, -- Person danger to work status
	dangertoworkerreason varchar(512) NULL, -- Dangerto worker reason
	sphouseholdmemberflag int4 NULL,
	spchildflag int4 NULL,
	spreporteranonymousflag int4 NULL,
	spreporternoletterflag int4 NULL,
	spexpungementflag int4 NULL,
	fetalalcoholspctrmdisordflag int4 NULL,
	drugexposednewbornflag int4 NULL,
	probationsearchconductedflag int4 NULL,
	sexoffenderregisteredflag int4 NULL,
	otherdrugs varchar(255) NULL,
	unknownreporterflag int4 NULL,
	spproviderid int4 NULL,
	servicecaseid uuid NULL, -- Child removal primary key
	fk_id varchar(20) NULL,
	fk_c_id varchar(30) NULL,
	personroletypeid uuid NULL,
	drugexposedkey varchar(50) NULL,
	intakenumber varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
	startdate timestamp NULL, -- The actor start date for public provider backup role
	enddate timestamp NULL, -- The actor end date for for public provider backup role
	householdswitch varchar(50) NULL, -- To get the household status
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_actorexpunge PRIMARY KEY (actorexpungeid),
	CONSTRAINT fk_actorexpunge_employeetype FOREIGN KEY (employeetypeid) REFERENCES cjams.employeetype(employeetypeid),
	CONSTRAINT fk_actorexpunge_languagetype FOREIGN KEY (primarylanguageid) REFERENCES cjams.languagetype(languagetypeid),
	CONSTRAINT fk_actorexpunge_livingarrangement FOREIGN KEY (livingarrangementtypekey) REFERENCES cjams.livingarrangementtype(livingarrangementtypekey),
	CONSTRAINT fk_actorexpunge_person FOREIGN KEY (personid) REFERENCES cjams.person(personid)
);
CREATE INDEX actorexpunge_activeflag_idx ON expunge.actor_expunge USING btree (activeflag);
CREATE INDEX actorexpunge_actortype_idx ON expunge.actor_expunge USING btree (actortype);
CREATE INDEX actorexpunge_employeetypeid_idx ON expunge.actor_expunge USING btree (employeetypeid);
CREATE INDEX actorexpunge_householdactor_idx ON expunge.actor_expunge USING btree (actorid, ishouseholdmember, activeflag);
CREATE INDEX actorexpunge_householdactoracitve_idx ON expunge.actor_expunge USING btree (ishouseholdmember, activeflag);
CREATE INDEX actorexpunge_livingarrangementtypekey_idx ON expunge.actor_expunge USING btree (livingarrangementtypekey);
CREATE INDEX actorexpunge_person_active_idx ON expunge.actor_expunge USING btree (personid, activeflag);
CREATE INDEX actorexpunge_person_idx ON expunge.actor_expunge USING btree (personid, actorid);
CREATE INDEX actoexpunge_personid_idx ON expunge.actor_expunge USING btree (personid);
CREATE INDEX actorexpunge_primarylanguageid_idx ON expunge.actor_expunge USING btree (primarylanguageid);
CREATE INDEX idx_actorexpunge_serviceid ON expunge.actor_expunge USING btree (servicecaseid, actorid, personid);
CREATE INDEX indx_actorexpunge_comp ON expunge.actor_expunge USING btree (intakeserviceid, ishouseholdmember);
CREATE INDEX indx_actorexpunge_intakenumber ON expunge.actor_expunge USING btree (intakenumber);
CREATE INDEX xie1_actorexpunge ON expunge.actor_expunge USING btree (objectid);

-- Column comments
COMMENT ON COLUMN expunge.actor_expunge.actorexpungeid IS 'Actor details stored in this table (primary key)';
COMMENT ON COLUMN expunge.actor_expunge.actorid IS 'Actor details stored in this table (primary key) for actor table';
COMMENT ON COLUMN expunge.actor_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.actor_expunge.personid IS 'Person Id (Foreign Key)';
COMMENT ON COLUMN expunge.actor_expunge.actortype IS 'Type of actor';
COMMENT ON COLUMN expunge.actor_expunge.dangerlevel IS 'Danger level';
COMMENT ON COLUMN expunge.actor_expunge.dangerreason IS 'Danger reason';
COMMENT ON COLUMN expunge.actor_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.actor_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.actor_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.actor_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.actor_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.actor_expunge."timestamp" IS 'Timestamp
';
COMMENT ON COLUMN expunge.actor_expunge.primarylanguageid IS 'Primary Language id of actor (foreign key)';
COMMENT ON COLUMN expunge.actor_expunge.secondarylanguageid IS 'Secondary language id';
COMMENT ON COLUMN expunge.actor_expunge.employeetypeid IS 'Employee type id (foreign key)';
COMMENT ON COLUMN expunge.actor_expunge.employeetypename IS 'Employee type name';
COMMENT ON COLUMN expunge.actor_expunge.medicaideligibility IS 'Medicaideligibility';
COMMENT ON COLUMN expunge.actor_expunge.blockgranteligibility IS 'Blockgranteligibility';
COMMENT ON COLUMN expunge.actor_expunge.recipientstatus IS 'Recipientstatus';
COMMENT ON COLUMN expunge.actor_expunge.livingarrangementtypekey IS 'living arrangement type key (foreign key)';
COMMENT ON COLUMN expunge.actor_expunge.interpreterrequired IS 'interpreterrequired';
COMMENT ON COLUMN expunge.actor_expunge.guardianname IS 'Guardianname';
COMMENT ON COLUMN expunge.actor_expunge.guardianinfo IS 'Guardianinfo';
COMMENT ON COLUMN expunge.actor_expunge.ramentalhealth IS 'Ramentalhealth';
COMMENT ON COLUMN expunge.actor_expunge.ramentalretarted IS 'Ramentalretartedtype';
COMMENT ON COLUMN expunge.actor_expunge.ramentalretartedtype IS 'Ramentalretartedtype';
COMMENT ON COLUMN expunge.actor_expunge.manualupdateflag IS 'Manualupdateflag';
COMMENT ON COLUMN expunge.actor_expunge.intakeserviceid IS 'Case Id';
COMMENT ON COLUMN expunge.actor_expunge.iscollateralcontact IS 'Collateral Contact flag updated';
COMMENT ON COLUMN expunge.actor_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.actor_expunge.ismentalillness IS 'Mentalillness';
COMMENT ON COLUMN expunge.actor_expunge.mentalillnessdetail IS 'MentalillnessDetail';
COMMENT ON COLUMN expunge.actor_expunge.ismentalimpair IS 'Mentalillness';
COMMENT ON COLUMN expunge.actor_expunge.mentalimpairdetail IS 'MentalimpairDetail';
COMMENT ON COLUMN expunge.actor_expunge.ishouseholdmember IS 'House hold memeber flag updated ';
COMMENT ON COLUMN expunge.actor_expunge.isdangertoworker IS 'Person danger to work status';
COMMENT ON COLUMN expunge.actor_expunge.dangertoworkerreason IS 'Dangerto worker reason';
COMMENT ON COLUMN expunge.actor_expunge.servicecaseid IS 'Child removal primary key';
COMMENT ON COLUMN expunge.actor_expunge.startdate IS 'The actor start date for public provider backup role';
COMMENT ON COLUMN expunge.actor_expunge.enddate IS 'The actor end date for for public provider backup role';
COMMENT ON COLUMN expunge.actor_expunge.householdswitch IS 'To get the household status';
COMMENT ON COLUMN expunge.actor_expunge.isexpunged IS 'Flag to indicate the expunged record';