ALTER TABLE IF EXISTS cjams.crispinboundinterface DROP CONSTRAINT IF EXISTS pk_crispinboundinterface;
DROP TABLE IF EXISTS cjams.crispinboundinterface;

CREATE TABLE cjams.crispinboundinterface (
	crispinboundinterfaceid uuid NOT NULL DEFAULT gen_random_uuid(),
	addedondate timestamp  NULL,
	studentno int8  NULL,
	clientid int8 NULL,
	matchtype varchar(200) NULL,
	firstname varchar(50) NULL,
	middlename varchar(50) NULL,
	lastname varchar(50) NULL,
	birthdate timestamp NULL,
	gender varchar(10),
	race varchar(50) NULL,
	ethnicity varchar(50) NULL,
	streetaddress varchar(100) NULL,
	otheraddrln varchar(100)  NULL,
	addresstypecode varchar(50)  NULL,
	cityname varchar(50)  NULL,
	statecode varchar(50)  NULL,
	zipcode int8 NULL,
	countycode1 varchar(20)  NULL,
	emailaddr varchar(200)  NULL,
	phonenumber varchar(100) NULL,
	mothersfirstname varchar(50)  NULL,
	mothersmaidenlast varchar(50)  NULL,
	immunizationid varchar(250)  NULL,
	vaccinationdt timestamp NULL,
	vaccinetype varchar(200)  NULL,
	sendingorg varchar(100)  NULL,
	vfcpin varchar(250)  NULL,
	enteredbyorgid varchar(100) NULL,
	lastupdateddt timestamp  NULL,
	lastupdateddt1 timestamp  NULL,
	bodysitecode varchar(10)  NULL,
	administrationroutecd varchar(10)  NULL,
	vaccinelotid varchar(50)  NULL,
	cptcode varchar(50)  NULL,
	cvxcode varchar(50)  NULL,
	vaccinename varchar(200)  NULL,
	manufacturercd varchar(50)  NULL,
	manufacturername varchar(200)  NULL,
	populationgrpcode varchar(50)  NULL,
	administeringorg varchar(50)  NULL,
	administeringorgname varchar(250) NULL,
	activeflag int4 NOT NULL DEFAULT 1, 
   	insertedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE', 
   	insertedon timestamp NOT NULL DEFAULT now(), 
   	updatedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE', 
   	updatedon timestamp NULL DEFAULT now(),
	batchlogid int8 NULL,
	status text NULL,
	comments text NULL,
	CONSTRAINT pk_crispinboundinterface PRIMARY KEY (crispinboundinterfaceid)
);


---Column comments

COMMENT ON COLUMN cjams.crispinboundinterface.crispinboundinterfaceid IS 'crispinboundinterface details stored in this table(primary key)';
COMMENT ON COLUMN cjams.crispinboundinterface.addedondate IS 'Date the immunization record was first created';
COMMENT ON COLUMN cjams.crispinboundinterface.studentno IS 'student number';
COMMENT ON COLUMN cjams.crispinboundinterface.clientid IS 'client id of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.matchtype IS 'match type to the crisp system';
COMMENT ON COLUMN cjams.crispinboundinterface.firstname IS 'first name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.middlename IS 'middle name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.lastname IS 'last name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.birthdate IS 'birthdate of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.gender IS 'gender of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.race IS 'race of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.ethnicity IS 'ethinicity of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.streetaddress IS 'street address';
COMMENT ON COLUMN cjams.crispinboundinterface.otheraddrln IS 'additional address';
COMMENT ON COLUMN cjams.crispinboundinterface.addresstypecode IS 'address type code';
COMMENT ON COLUMN cjams.crispinboundinterface.cityname IS 'city name';
COMMENT ON COLUMN cjams.crispinboundinterface.statecode IS 'state code';
COMMENT ON COLUMN cjams.crispinboundinterface.zipcode IS 'zip code';
COMMENT ON COLUMN cjams.crispinboundinterface.countycode1 IS 'county code';
COMMENT ON COLUMN cjams.crispinboundinterface.emailaddr IS 'email address of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.phonenumber IS 'phone number of the person';
COMMENT ON COLUMN cjams.crispinboundinterface.mothersfirstname IS 'persons mother first name';
COMMENT ON COLUMN cjams.crispinboundinterface.mothersmaidenlast IS 'persons mother maiden or last name';
COMMENT ON COLUMN cjams.crispinboundinterface.immunizationid IS 'immunization id';
COMMENT ON COLUMN cjams.crispinboundinterface.vaccinationdt IS 'date of vaccination';
COMMENT ON COLUMN cjams.crispinboundinterface.vaccinetype IS 'vaccine type';
COMMENT ON COLUMN cjams.crispinboundinterface.sendingorg IS 'organization sending this record';
COMMENT ON COLUMN cjams.crispinboundinterface.vfcpin IS 'vfc pin for this record';
COMMENT ON COLUMN cjams.crispinboundinterface.enteredbyorgid IS 'organization that enetered this record';
COMMENT ON COLUMN cjams.crispinboundinterface.lastupdateddt IS 'last update timestamp for this record';
COMMENT ON COLUMN cjams.crispinboundinterface.lastupdateddt1 IS 'new timestamp for any updates to existing records';
COMMENT ON COLUMN cjams.crispinboundinterface.bodysitecode IS 'body site code';
COMMENT ON COLUMN cjams.crispinboundinterface.administrationroutecd IS 'administration route code';
COMMENT ON COLUMN cjams.crispinboundinterface.vaccinelotid IS 'vaccine lot id';
COMMENT ON COLUMN cjams.crispinboundinterface.cptcode IS 'cpt code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface.cvxcode IS 'cvx code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface.vaccinename IS 'vaccination name';
COMMENT ON COLUMN cjams.crispinboundinterface.manufacturername IS 'manufacturer name';
COMMENT ON COLUMN cjams.crispinboundinterface.manufacturercd IS 'manufacturer code';
COMMENT ON COLUMN cjams.crispinboundinterface.populationgrpcode IS 'population group code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface.administeringorg IS 'adminstering organization';
COMMENT ON COLUMN cjams.crispinboundinterface.administeringorgname IS 'administering organization name';
COMMENT ON COLUMN cjams.crispinboundinterface.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispinboundinterface.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispinboundinterface.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispinboundinterface.updatedby IS 'user who last updated this record';
COMMENT ON COLUMN cjams.crispinboundinterface.updatedon IS 'record updated date and time';
COMMENT ON COLUMN cjams.crispinboundinterface.batchlogid IS 'CJAMS-CRISP Inbound Batch Log ID';
COMMENT ON COLUMN cjams.crispinboundinterface.status IS 'success status of this record';
COMMENT ON COLUMN cjams.crispinboundinterface.comments IS 'comments on this record';


