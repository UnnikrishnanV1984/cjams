ALTER TABLE IF EXISTS cjams.personimmunization_history DROP CONSTRAINT IF EXISTS pk_personimmunization_history;
DROP TABLE IF EXISTS cjams.personimmunization_history;

CREATE TABLE cjams.personimmunization_history (
	personimmunizationhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	currentdata json,
    previousdata json,
    modifieddata json,
    rowtype character varying(20),
    personimmunizationid uuid NULL,
    personid uuid NULL,
    immunizationtypekey varchar(50) NULL,
    immunizationdate timestamp  NULL,
    nextduedate timestamp  NULL,
    "comments" varchar(50) NULL,
    certifiedcopyflag int4 NULL,
    updatedby varchar(50) NULL,
    updatedon timestamp  NULL,
    insertedby varchar(50) NULL,
    direction varchar(500) NULL,
    insertedon timestamp  NULL,
    zip4no int4 NULL,
    activeflag int4 NULL,
    fk_id varchar(50) NULL,
    zip5no int4 NULL,
    statetypekey varchar(50) NULL,
    providerid uuid NULL,
    nonimmunreason varchar(500) NULL,
    foreignstate varchar(100) NULL,
    cityname varchar(100) NULL,
    notimmunizedflag int4 NULL,
    unitnumber varchar(10) NULL,
    country varchar(100) NULL,
    unittypekey varchar(50) NULL,
    postdirtypekey varchar(50) NULL,
    streetsuffixtypekey varchar(50) NULL,
    postalcode varchar(100) NULL,
    streetname varchar(100) NULL,
    predirtypekey varchar(50) NULL,
    boxnumber int4 NULL,
    mobile varchar(100) NULL,
    streetnumber int4 NULL,
    hospitalname varchar(100) NULL,
    fax varchar(20) NULL,
    countytypekey varchar(50) NULL,
    foreignaddress varchar(500) NULL,
    email varchar(200) NULL,
    pager varchar(10) NULL,
    infocomments varchar(500) NULL,
    motherflag int4 NULL,
    fatherflag int4 NULL,
    homephone varchar(200) NULL,
    otherflag int4 NULL,
    othernotes varchar(2000) NULL,
    workextn varchar(10) NULL,
    workphone varchar(10) NULL,
    formattypekey varchar(50) NULL,
    url varchar(200) NULL,
    othercontacts varchar(200) NULL,
    iminfoprovidedtypekey varchar(50) NULL,
    providedbyclientid int4 NULL,
    collateralid int4 NULL,
    infoclienttypekey varchar(50) NULL,
    addresstypekey varchar(50) NULL,
    streetnotes varchar(2000) NULL,
    providedbynotes varchar(2000) NULL,
    providedbyrelationtypekey varchar(50) NULL,
    expungementflag int4 NULL,
    datavalidflag int4 NULL,
    clientmergeid uuid NULL,
    old_id varchar(50) NULL,
    reportedby varchar(50) NULL,
    immunizationdocpath text,
    immunizationdocname varchar(50) NULL,
    isimmunefileavail boolean NULL,
    uploadpath json NULL,
    dose varchar(50) NULL,
    personimmunizationconfigid uuid NULL,
    etl_userid varchar(30) NULL,
    etl_load_date date,
    vaccinemanufacturer varchar(50) NULL,
    vaccineadministered varchar(50) NULL,
    approxdate boolean NULL,    
    sourcesystem varchar(50) NULL,
    sourcesystemprimarykey varchar(250) NULL,
    sourcesystemupdatetimestamp timestamp NULL,    
	CONSTRAINT pk_personimmunization_history PRIMARY KEY (personimmunizationhistoryid)
);

--Column comments
COMMENT ON COLUMN cjams.personimmunization_history.personimmunizationhistoryid IS 'personimmunization_history snapshot details stored in this snapshot table(primary key)';
COMMENT ON COLUMN cjams.personimmunization_history.personimmunizationid IS 'personimmunization details stored in the personimmunization table';
COMMENT ON COLUMN cjams.personimmunization_history.currentdata IS 'Column to record the latest data ';
COMMENT ON COLUMN cjams.personimmunization_history.previousdata IS 'Column to record the previous data ';
COMMENT ON COLUMN cjams.personimmunization_history.modifieddata IS 'Column to record the modified data ';
COMMENT ON COLUMN cjams.personimmunization_history.rowtype IS 'Column to record the type of transaction';
COMMENT ON COLUMN cjams.personimmunization_history.personid IS 'id of the person';
COMMENT ON COLUMN cjams.personimmunization_history.immunizationtypekey IS 'type id of the immunization';
COMMENT ON COLUMN cjams.personimmunization_history.immunizationdate IS 'date of immunization';
COMMENT ON COLUMN cjams.personimmunization_history.nextduedate IS 'next due date for the immunization';
COMMENT ON COLUMN cjams.personimmunization_history."comments" IS 'comments on the immunization';
COMMENT ON COLUMN cjams.personimmunization_history.certifiedcopyflag IS 'flag to indicate certified copy';
COMMENT ON COLUMN cjams.personimmunization_history.updatedby IS 'user who last updated this record';
COMMENT ON COLUMN cjams.personimmunization_history.updatedon IS 'record updated date and time';
COMMENT ON COLUMN cjams.personimmunization_history.insertedby IS 'user who inserted this record';
COMMENT ON COLUMN cjams.personimmunization_history.insertedon IS 'record inserted date and time';
COMMENT ON COLUMN cjams.personimmunization_history.zip4no IS 'zip4 code';
COMMENT ON COLUMN cjams.personimmunization_history.activeflag IS 'flag to indicate the active status of the record';
COMMENT ON COLUMN cjams.personimmunization_history.fk_id IS 'foreign key id';
COMMENT ON COLUMN cjams.personimmunization_history.zip5no IS 'zip5 code';
COMMENT ON COLUMN cjams.personimmunization_history.statetypekey IS 'state type key';
COMMENT ON COLUMN cjams.personimmunization_history.providerid IS 'provider id';
COMMENT ON COLUMN cjams.personimmunization_history.nonimmunreason IS 'reason for non immunization';
COMMENT ON COLUMN cjams.personimmunization_history.foreignstate IS 'foreign state ';
COMMENT ON COLUMN cjams.personimmunization_history.cityname IS 'city name of person address';
COMMENT ON COLUMN cjams.personimmunization_history.notimmunizedflag IS 'flag to indicate person is nonimmunized';
COMMENT ON COLUMN cjams.personimmunization_history.unitnumber IS 'unit number of person address';
COMMENT ON COLUMN cjams.personimmunization_history.country IS 'country of person address';
COMMENT ON COLUMN cjams.personimmunization_history.unittypekey IS 'unit type of person address';
COMMENT ON COLUMN cjams.personimmunization_history.postdirtypekey IS 'post dir type of person address';
COMMENT ON COLUMN cjams.personimmunization_history.streetsuffixtypekey IS 'street suffix type of person address';
COMMENT ON COLUMN cjams.personimmunization_history.postalcode IS 'postal code of person address';
COMMENT ON COLUMN cjams.personimmunization_history.streetname IS 'street name of person address';
COMMENT ON COLUMN cjams.personimmunization_history.predirtypekey IS 'pre dir type of person address';
COMMENT ON COLUMN cjams.personimmunization_history.boxnumber IS 'address box number';
COMMENT ON COLUMN cjams.personimmunization_history.mobile IS 'mobile number of person';
COMMENT ON COLUMN cjams.personimmunization_history.streetnumber IS 'street number of person address';
COMMENT ON COLUMN cjams.personimmunization_history.hospitalname IS 'hospital name';
COMMENT ON COLUMN cjams.personimmunization_history.fax IS 'fax address';
COMMENT ON COLUMN cjams.personimmunization_history.countytypekey IS 'county type of person address';
COMMENT ON COLUMN cjams.personimmunization_history.foreignaddress IS 'foreign address';
COMMENT ON COLUMN cjams.personimmunization_history.email IS 'email id of person';
COMMENT ON COLUMN cjams.personimmunization_history.pager IS 'pager id of person';
COMMENT ON COLUMN cjams.personimmunization_history.infocomments IS 'info comments';
COMMENT ON COLUMN cjams.personimmunization_history.motherflag IS 'mother flag';
COMMENT ON COLUMN cjams.personimmunization_history.fatherflag IS 'father flag';
COMMENT ON COLUMN cjams.personimmunization_history.homephone IS 'home phone number';
COMMENT ON COLUMN cjams.personimmunization_history.otherflag IS 'other flag';
COMMENT ON COLUMN cjams.personimmunization_history.othernotes IS 'other notes';
COMMENT ON COLUMN cjams.personimmunization_history.workextn IS 'work extn';
COMMENT ON COLUMN cjams.personimmunization_history.workphone IS 'work phone';
COMMENT ON COLUMN cjams.personimmunization_history.formattypekey IS 'format type';
COMMENT ON COLUMN cjams.personimmunization_history.url IS 'url';
COMMENT ON COLUMN cjams.personimmunization_history.othercontacts IS 'other contacts';
COMMENT ON COLUMN cjams.personimmunization_history.iminfoprovidedtypekey IS 'type in which immunization info provided';
COMMENT ON COLUMN cjams.personimmunization_history.providedbyclientid IS 'client id who provided immunization info';
COMMENT ON COLUMN cjams.personimmunization_history.collateralid IS 'collateral id';
COMMENT ON COLUMN cjams.personimmunization_history.infoclienttypekey IS 'client type who provided immunization info';
COMMENT ON COLUMN cjams.personimmunization_history.addresstypekey IS 'address type';
COMMENT ON COLUMN cjams.personimmunization_history.streetnotes IS 'street notes';
COMMENT ON COLUMN cjams.personimmunization_history.providedbynotes IS 'notes by client who provided info';
COMMENT ON COLUMN cjams.personimmunization_history.providedbyrelationtypekey IS 'relation of client who provided info';
COMMENT ON COLUMN cjams.personimmunization_history.expungementflag IS 'expungement flag';
COMMENT ON COLUMN cjams.personimmunization_history.datavalidflag IS 'data valid flag';
COMMENT ON COLUMN cjams.personimmunization_history.clientmergeid IS 'client merge id';
COMMENT ON COLUMN cjams.personimmunization_history.old_id IS 'old id';
COMMENT ON COLUMN cjams.personimmunization_history.reportedby IS 'user who reported this record';
COMMENT ON COLUMN cjams.personimmunization_history.immunizationdocpath IS 'path of doc who gave immunization';
COMMENT ON COLUMN cjams.personimmunization_history.immunizationdocname IS 'name of doc who gave immunization';
COMMENT ON COLUMN cjams.personimmunization_history.isimmunefileavail IS 'flag to indicate if immunization file is available or not';
COMMENT ON COLUMN cjams.personimmunization_history.uploadpath IS 'upload path';
COMMENT ON COLUMN cjams.personimmunization_history.dose IS 'dose number';
COMMENT ON COLUMN cjams.personimmunization_history.personimmunizationconfigid IS 'person immunization config id';
COMMENT ON COLUMN cjams.personimmunization_history.etl_userid IS 'audit column for user who loaded this record';
COMMENT ON COLUMN cjams.personimmunization_history.etl_load_date IS 'audit column for date on which record is loaded';
COMMENT ON COLUMN cjams.personimmunization_history.vaccineadministered IS 'vaccine given';
COMMENT ON COLUMN cjams.personimmunization_history.approxdate IS 'approximate date of vaccination';
COMMENT ON COLUMN cjams.personimmunization_history.vaccinemanufacturer IS 'Column to record the Manufacturer of COVID vaccine injected to the person';
COMMENT ON COLUMN cjams.personimmunization_history.sourcesystem IS 'source system for the immunization record';
COMMENT ON COLUMN cjams.personimmunization_history.sourcesystemprimarykey IS 'source system primarykey for the immunization record';
COMMENT ON COLUMN cjams.personimmunization_history.sourcesystemupdatetimestamp IS 'source system updatetimestamp for the immunization record';

