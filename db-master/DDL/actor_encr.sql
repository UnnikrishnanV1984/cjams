-- Drop table

-- DROP TABLE encr.actor_encr;

CREATE TABLE encr.actor_encr(
	actorencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    actorid uuid NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	personid bytea NOT NULL,
	actortype bytea NOT NULL,
	dangerlevel int4 NULL,
	dangerreason varchar(512) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	expirationdate timestamp NULL,
	"timestamp" bytea NULL,
	primarylanguageid uuid NULL,
	secondarylanguageid uuid NULL,
	employeetypeid uuid NULL,
	employeetypename varchar(50) NULL,
	medicaideligibility bool NULL DEFAULT true,
	blockgranteligibility bool NULL DEFAULT true,
	recipientstatus bool NULL DEFAULT true,
	livingarrangementtypekey varchar(50) NULL,
	interpreterrequired varchar(256) NULL,
	guardianname varchar(50) NULL,
	guardianinfo varchar(126) NULL,
	ramentalhealth bool NULL,
	ramentalretarted bool NULL,
	ramentalretartedtype varchar(50) NULL,
	manualupdateflag bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	intakeserviceid uuid NULL,
	iscollateralcontact int4 NULL,
	old_id varchar(50) NULL,
	ismentalillness int4 NULL,
	mentalillnessdetail bytea NULL,
	ismentalimpair int4 NULL,
	mentalimpairdetail bytea NULL,
	ishouseholdmember int4 NULL,
	isdangertoworker int4 NULL,
	dangertoworkerreason bytea NULL,
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
	servicecaseid uuid NULL,
	fk_id varchar(20) NULL,
	fk_c_id varchar(30) NULL,
	personroletypeid uuid NULL,
	drugexposedkey varchar(50) NULL,
	intakenumber bytea NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	householdswitch varchar(50) NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_actor_encr PRIMARY KEY (actorencrid),
	CONSTRAINT fk_actor_encr_employeetype FOREIGN KEY (employeetypeid) REFERENCES employeetype(employeetypeid),
	CONSTRAINT fk_actor_encr_languagetype FOREIGN KEY (primarylanguageid) REFERENCES languagetype(languagetypeid),
	CONSTRAINT fk_actor_encr_livingarrangement FOREIGN KEY (livingarrangementtypekey) REFERENCES livingarrangementtype(livingarrangementtypekey)
);
CREATE INDEX actor_encr_encr_activeflag_idx ON encr.actor_encr USING btree (activeflag);
CREATE INDEX actor_encr_encr_actortype_idx ON encr.actor_encr USING btree (actortype);
CREATE INDEX actor_encr_encr_employeetypeid_idx ON encr.actor_encr USING btree (employeetypeid);
CREATE INDEX actor_encr_encr_householdactor_encr_idx ON encr.actor_encr USING btree (actorid, ishouseholdmember, activeflag);
CREATE INDEX actor_encr_encr_householdactoracitve_idx ON encr.actor_encr USING btree (ishouseholdmember, activeflag);
CREATE INDEX actor_encr_livingarrangementtypekey_idx ON encr.actor_encr USING btree (livingarrangementtypekey);
CREATE INDEX actor_encr_person_active_idx ON encr.actor_encr USING btree (personid, activeflag);
CREATE INDEX actor_encr_person_idx ON encr.actor_encr USING btree (personid, actorid);
CREATE INDEX actor_encr_personid_idx ON encr.actor_encr USING btree (personid);
CREATE INDEX actor_encr_primarylanguageid_idx ON encr.actor_encr USING btree (primarylanguageid);
CREATE INDEX idx_actor_encr_serviceid ON encr.actor_encr USING btree (servicecaseid, actorid, personid);
CREATE INDEX indx_actor_encr_comp ON encr.actor_encr USING btree (intakeserviceid, ishouseholdmember);
CREATE INDEX indx_actor_encr_intakenumber ON encr.actor_encr USING btree (intakenumber);
CREATE INDEX xie1_actor_encr ON encr.actor_encr USING btree (objectid);

-- Column comments
COMMENT ON COLUMN encr.actor_encr.actorencrid IS 'primary key';
COMMENT ON COLUMN encr.actor_encr.actorid IS 'Actor table (primary key)';
COMMENT ON COLUMN encr.actor_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.actor_encr.personid IS 'Person Id (Foreign Key)';
COMMENT ON COLUMN encr.actor_encr.actortype IS 'Type of actor';
COMMENT ON COLUMN encr.actor_encr.dangerlevel IS 'Danger level';
COMMENT ON COLUMN encr.actor_encr.dangerreason IS 'Danger reason';
COMMENT ON COLUMN encr.actor_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.actor_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.actor_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.actor_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.actor_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.actor_encr."timestamp" IS 'Timestamp
';
COMMENT ON COLUMN encr.actor_encr.primarylanguageid IS 'Primary Language id of actor (foreign key)';
COMMENT ON COLUMN encr.actor_encr.secondarylanguageid IS 'Secondary language id';
COMMENT ON COLUMN encr.actor_encr.employeetypeid IS 'Employee type id (foreign key)';
COMMENT ON COLUMN encr.actor_encr.employeetypename IS 'Employee type name';
COMMENT ON COLUMN encr.actor_encr.medicaideligibility IS 'Medicaideligibility';
COMMENT ON COLUMN encr.actor_encr.blockgranteligibility IS 'Blockgranteligibility';
COMMENT ON COLUMN encr.actor_encr.recipientstatus IS 'Recipientstatus';
COMMENT ON COLUMN encr.actor_encr.livingarrangementtypekey IS 'living arrangement type key (foreign key)';
COMMENT ON COLUMN encr.actor_encr.interpreterrequired IS 'interpreterrequired';
COMMENT ON COLUMN encr.actor_encr.guardianname IS 'Guardianname';
COMMENT ON COLUMN encr.actor_encr.guardianinfo IS 'Guardianinfo';
COMMENT ON COLUMN encr.actor_encr.ramentalhealth IS 'Ramentalhealth';
COMMENT ON COLUMN encr.actor_encr.ramentalretarted IS 'Ramentalretartedtype';
COMMENT ON COLUMN encr.actor_encr.ramentalretartedtype IS 'Ramentalretartedtype';
COMMENT ON COLUMN encr.actor_encr.manualupdateflag IS 'Manualupdateflag';
COMMENT ON COLUMN encr.actor_encr.intakeserviceid IS 'Case Id';
COMMENT ON COLUMN encr.actor_encr.iscollateralcontact IS 'Collateral Contact flag updated';
COMMENT ON COLUMN encr.actor_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.actor_encr.ismentalillness IS 'Mentalillness';
COMMENT ON COLUMN encr.actor_encr.mentalillnessdetail IS 'MentalillnessDetail';
COMMENT ON COLUMN encr.actor_encr.ismentalimpair IS 'Mentalillness';
COMMENT ON COLUMN encr.actor_encr.mentalimpairdetail IS 'MentalimpairDetail';
COMMENT ON COLUMN encr.actor_encr.ishouseholdmember IS 'House hold memeber flag updated ';
COMMENT ON COLUMN encr.actor_encr.isdangertoworker IS 'Person danger to work status';
COMMENT ON COLUMN encr.actor_encr.dangertoworkerreason IS 'Dangerto worker reason';
COMMENT ON COLUMN encr.actor_encr.servicecaseid IS 'Child removal primary key';
COMMENT ON COLUMN encr.actor_encr.startdate IS 'The actor start date for public provider backup role';
COMMENT ON COLUMN encr.actor_encr.enddate IS 'The actor end date for for public provider backup role';
COMMENT ON COLUMN encr.actor_encr.householdswitch IS 'To get the household status';